//
//  CustomAlertView.m
//  ATModalViewDemo
//
//  Created by liyebiao on 2021/6/21.
//

#import "CustomAlertView.h"

@interface CustomAlertViewConfig()

@property (nonatomic,assign) CGRect titleFrame;
@property (nonatomic,assign) CGRect messageFrame;
@property (nonatomic,assign) CGFloat alertViewWidth;
@property (nonatomic,assign) CGFloat topHeight;
@property (nonatomic,assign) CGFloat contentHeight;
@property (nonatomic,assign) CGFloat bottomHeight;

@end

@implementation CustomAlertViewConfig

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title = [self defaultTitleAttributed:@"This is title"];
        self.message = [self defaultMessageAttributed:@"This is message"];
        self.items = @[[self defaultItemAttributed:@"Cancel"],[self defaultItemAttributed:@"OK"]];
        
        self.titleMinHeight = 20;
        self.messageMinHeight = 20;
        self.bottomMinHeight = 44;
        
        self.itemInterval = 20;

        self.topInsets = UIEdgeInsetsMake(20, 20, 10, 20);
        self.contentInsets = UIEdgeInsetsMake(20, 20, 40, 20);
        self.bottomInsets = UIEdgeInsetsMake(5, 25, 20, 25);
        
        self.titleAlignment = NSTextAlignmentCenter;
        self.messageAlignment = NSTextAlignmentCenter;
        
        //....
        self.popMarginLeft = 30;
        self.popMarginRight = 30;
        
        self.popCornerRadius = 13;
    }
    return self;
}

- (CGSize)sizeWithText:(NSAttributedString *)text maxSize:(CGSize)maxSize{
    return [text boundingRectWithSize:maxSize options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) context:nil].size;
}

- (void)createLayout{
    
    CGFloat titleMaxWidth = self.alertViewWidth - self.topInsets.left - self.topInsets.right;
    CGFloat messageMaxWidth = self.alertViewWidth - self.contentInsets.left - self.contentInsets.right;
    
    CGFloat titleHeight = [self sizeWithText:self.title maxSize:CGSizeMake(titleMaxWidth, 1000)].height;
    CGFloat messageHeight = [self sizeWithText:self.message maxSize:CGSizeMake(messageMaxWidth, 1000)].height;
    
    self.titleFrame = CGRectMake(self.topInsets.left, self.topInsets.top, titleMaxWidth, MAX(titleHeight, self.titleMinHeight));
    self.messageFrame = CGRectMake(self.contentInsets.left, self.contentInsets.top, messageMaxWidth, MAX(messageHeight, self.messageMinHeight));
    
    self.topHeight = self.topInsets.top + self.topInsets.bottom + self.titleFrame.size.height;
    self.contentHeight = self.contentInsets.top + self.contentInsets.bottom + self.messageFrame.size.height;
    self.bottomHeight = self.bottomInsets.top + self.bottomInsets.bottom + self.bottomMinHeight;
}

- (NSMutableAttributedString *)defaultTitleAttributed:(NSString *)text{
    NSMutableAttributedString * textAttributed = [[NSMutableAttributedString alloc] initWithString:text];
    [textAttributed setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:UIColor.blackColor} range:NSMakeRange(0, text.length)];
    return textAttributed;
}
- (NSMutableAttributedString *)defaultMessageAttributed:(NSString *)text{
    NSMutableAttributedString * textAttributed = [[NSMutableAttributedString alloc] initWithString:text];
    [textAttributed setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColor.blackColor} range:NSMakeRange(0, text.length)];
    return textAttributed;
}
- (NSMutableAttributedString *)defaultItemAttributed:(NSString *)text{
    NSMutableAttributedString * textAttributed = [[NSMutableAttributedString alloc] initWithString:text];
    [textAttributed setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:UIColor.systemBlueColor} range:NSMakeRange(0, text.length)];
    return textAttributed;
}

@end

@interface CustomAlertView()
@property (nonatomic,strong) ATModalCustomPopView * customPopView;
@property (nonatomic,strong) UIView * topView;
@property (nonatomic,strong) UIView * contentView;
@property (nonatomic,strong) UIView * bottomView;

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * messageLabel;

@property (nonatomic,strong) CustomAlertViewConfig * config;
@end

@implementation CustomAlertView

- (instancetype)initWithFrame:(CGRect)frame config:(nonnull CustomAlertViewConfig *)config{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = config;
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (void)setupSubviews{
    self.topView = [[UIView alloc] init];
    [self addSubview:self.topView];
    
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
    
    self.bottomView = [[UIView alloc] init];
    [self addSubview:self.bottomView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = self.config.titleAlignment;
    self.titleLabel.attributedText = self.config.title;
    self.titleLabel.frame = self.config.titleFrame;
    [self.topView addSubview:self.titleLabel];
    
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.textAlignment = self.config.messageAlignment;
    self.messageLabel.attributedText = self.config.message;
    self.messageLabel.frame = self.config.messageFrame;
    [self.contentView addSubview:self.messageLabel];
    
    
    NSUInteger itemCount = self.config.items.count;
    
    CGFloat bottomContentWidth = self.config.alertViewWidth - self.config.bottomInsets.left - self.config.bottomInsets.right;
    
    CGFloat bottomItemContentWidth = bottomContentWidth - (itemCount>0?((itemCount-1)*self.config.itemInterval):0);
    CGFloat itemWidth = bottomItemContentWidth/itemCount;
    CGFloat itemHeight = self.config.bottomHeight-self.config.bottomInsets.top-self.config.bottomInsets.bottom;
    CGFloat itemLeft = self.config.bottomInsets.left;
    
    NSUInteger index = 0;
    for(NSAttributedString * item in self.config.items){
        UIButton * itemButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        if(self.config.itemBackgroundColors){
            itemButton.backgroundColor = self.config.itemBackgroundColors[index];
        }else{
            itemButton.backgroundColor = self.config.itemBackgroundColor;
        }
        itemButton.tag = index;
        [itemButton setAttributedTitle:item forState:UIControlStateNormal];
        itemButton.frame = CGRectMake(itemLeft+(self.config.itemInterval*index)+(index*itemWidth), self.config.bottomInsets.top, itemWidth, itemHeight);
        itemButton.layer.cornerRadius = itemHeight/2.0f;
        itemButton.layer.masksToBounds = YES;
        [itemButton addTarget:self action:@selector(clickItemButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:itemButton];
        index ++;
    }
}

- (void)setupLayout{
    self.topView.frame = CGRectMake(0, 0, self.config.alertViewWidth, self.config.topHeight);
    self.contentView.frame = CGRectMake(0, self.config.topHeight, self.config.alertViewWidth, self.config.contentHeight);
    self.bottomView.frame = CGRectMake(0, self.config.topHeight+self.config.contentHeight, self.config.alertViewWidth, self.config.bottomHeight);
}

- (void)clickItemButton:(UIButton *)sender{
    BOOL canDismiss = YES;
    if(self.config.onClickItemBlock){
        self.config.onClickItemBlock(sender.tag,&canDismiss);
    }
    if(canDismiss){
        [self.customPopView dismiss:nil];
    }
}

//MARK:ATModalCustomViewProtocol
- (void)customViewInitLayout:(ATModalCustomPopView *)customPopView config:(ATModalCustomPopViewConfig *)config{
    self.customPopView = customPopView;
    self.frame = customPopView.popView.bounds;
}


@end


@implementation CustomAlertView(ExtShow)

+ (void)showAlertInView:(UIView *)view configBlock:(ATModalAlertConfigBlock)configBlock{
    CGFloat inViewHeight = CGRectGetHeight(view.frame);
    CGFloat inViewWidth = CGRectGetWidth(view.frame);
    
    CustomAlertViewConfig * alertConfig = [CustomAlertViewConfig new];
    if(configBlock){
        configBlock(alertConfig);
    }
    alertConfig.alertViewWidth = inViewWidth-alertConfig.popMarginLeft-alertConfig.popMarginRight;
    [alertConfig createLayout];
    
    CGFloat popViewHeight = alertConfig.topHeight + alertConfig.contentHeight + alertConfig.bottomHeight;
    
    CustomAlertView * customView = [[CustomAlertView alloc] initWithFrame:view.bounds config:alertConfig];
    
    [ATModalCustomPopView showInView:view customView:customView configBlock:^(ATModalPopViewConfig * _Nonnull config) {
        ATModalCustomPopViewConfig * customConfig = (ATModalCustomPopViewConfig *)config;
        config.tapModalDismiss = NO;
        config.popFrameForInit = CGRectMake(alertConfig.popMarginLeft, (inViewHeight-popViewHeight)/2, inViewWidth-alertConfig.popMarginLeft-alertConfig.popMarginRight, popViewHeight);
        config.popFrameForShow = config.popFrameForInit;
        config.popFrameForHide = config.popFrameForInit;
        
        customConfig.initLayoutBlock = ^(ATModalCustomPopView * _Nonnull customPopView, UIView<ATModalCustomViewProtocol> * _Nonnull customView, ATModalCustomPopViewConfig * _Nonnull config) {
            customPopView.popView.layer.cornerRadius = alertConfig.popCornerRadius;
            customPopView.popView.layer.masksToBounds = YES;
        };
    }];
}

@end
