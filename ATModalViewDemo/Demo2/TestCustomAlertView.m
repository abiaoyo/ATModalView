//
//  TestCustomAlertView.m
//  ATModalViewDemo
//
//  Created by liyebiao on 2021/6/21.
//

#import "TestCustomAlertView.h"

@interface TestCustomAlertView()
@property (nonatomic,weak) ATModalCustomPopView * customPopView;
@end

@implementation TestCustomAlertView

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
}

- (void)setupLayout{
    
}

- (void)clickClose{
    [self.customPopView dismiss:nil];
}

- (void)customViewInitLayout:(ATModalCustomPopView *)customPopView config:(ATModalCustomPopViewConfig *)config{
    self.customPopView = customPopView;
    self.frame = customPopView.popView.bounds;
}

@end


@implementation TestCustomAlertView(Ext)

+ (void)showInView:(UIView *)view{
    
    CGFloat inViewHeight = CGRectGetHeight(view.frame);
    CGFloat inViewWidth = CGRectGetWidth(view.frame);
    
    TestCustomAlertView * customView = [[TestCustomAlertView alloc] init];
    
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
