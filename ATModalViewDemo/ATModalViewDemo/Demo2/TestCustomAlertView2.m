//
//  TestCustomAlertView2.m
//  ATModalViewDemo
//
//  Created by liyebiao on 2021/6/21.
//

#import "TestCustomAlertView2.h"

@interface TestCustomAlertView2()
@property (nonatomic,weak) ATModalCustomPopView * customPopView;
@property (nonatomic,weak) ATModalCustomPopViewConfig * config;

@end

@implementation TestCustomAlertView2

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupData];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (void)setupData{
    
}

- (void)setupSubviews{
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.backgroundColor = UIColor.orangeColor;
    closeButton.frame = CGRectMake(100, 100, 100, 50);
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(clickClose) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    
    UIButton * changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeButton.backgroundColor = UIColor.orangeColor;
    changeButton.frame = CGRectMake(100, 200, 100, 50);
    [changeButton setTitle:@"ChangeFrame" forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(clickChangeFrame) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:changeButton];
}

- (void)setupLayout{
    
}

- (void)clickClose{
    [self.customPopView dismiss:nil];
}

- (void)clickChangeFrame{
    
    CGFloat modalViewHeight = CGRectGetHeight(self.customPopView.frame);
    CGFloat modalViewWidth = CGRectGetWidth(self.customPopView.frame);
    
    CGFloat popViewHeight = 400;
    self.config.popFrameForInit = CGRectMake(20, (modalViewHeight-popViewHeight)/2, modalViewWidth-20*2, popViewHeight);
    
    self.config.popFrameForShow = self.config.popFrameForInit;
    self.config.popFrameForHide = self.config.popFrameForInit;
    
    __weak typeof(self) weakSelf = self;
    [self.customPopView viewShowAnimationBlock:^{
        weakSelf.customPopView.popView.frame = weakSelf.config.popFrameForInit;
        weakSelf.frame = weakSelf.customPopView.popView.bounds;
    } completion:nil];
}

- (void)customViewInitLayout:(ATModalCustomPopView *)customPopView config:(ATModalCustomPopViewConfig *)config{
    self.customPopView = customPopView;
    self.frame = customPopView.popView.bounds;
    
    self.config = config;
}

@end


@implementation TestCustomAlertView2(Ext)

+ (void)showInView:(UIView *)view{
    
    CGFloat inViewHeight = CGRectGetHeight(view.frame);
    CGFloat inViewWidth = CGRectGetWidth(view.frame);
    
    TestCustomAlertView2 * customView = [[TestCustomAlertView2 alloc] init];
    
    [ATModalCustomPopView showInView:view customView:customView configBlock:^(ATModalPopViewConfig * _Nonnull config) {
        ATModalCustomPopViewConfig * customConfig = (ATModalCustomPopViewConfig *)config;
        
        CGFloat popViewHeight = 300;
        config.popFrameForInit = CGRectMake(20, (inViewHeight-popViewHeight)/2, inViewWidth-20*2, popViewHeight);
        
        config.popFrameForShow = config.popFrameForInit;
        config.popFrameForHide = config.popFrameForInit;
        
        customConfig.initLayoutBlock = ^(ATModalCustomPopView * _Nonnull customPopView, UIView<ATModalCustomViewProtocol> * _Nonnull customView, ATModalCustomPopViewConfig * _Nonnull config) {
            customView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.35];
        };
    }];
}

@end
