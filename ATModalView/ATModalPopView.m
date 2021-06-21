//
//  ATModalPopView.m
//  GoveeHome
//
//  Created by liyebiao on 2021/6/4.
//  Copyright © 2021 ihoment. All rights reserved.
//

#import "ATModalPopView.h"

@implementation ATModalPopViewConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.popFrameForInit = CGRectMake(10, (UIScreen.mainScreen.bounds.size.height-300)/2, UIScreen.mainScreen.bounds.size.width-20, 300);
        self.popFrameForShow = CGRectMake(10, (UIScreen.mainScreen.bounds.size.height-300)/2, UIScreen.mainScreen.bounds.size.width-20, 300);
        self.popFrameForHide = CGRectMake(10, (UIScreen.mainScreen.bounds.size.height-300)/2, UIScreen.mainScreen.bounds.size.width-20, 300);
        
        self.popAlphaForInit = 0.0;
        self.popAlphaForShow = 1.0;
        self.popAlphaForHide = 0.0;
        
        self.isTransformAnimated = YES;
        
        self.popTransformForInit = CGAffineTransformMakeScale(1.1, 1.1);
        self.popTransformForShow = CGAffineTransformIdentity;
        self.popTransformForHide = CGAffineTransformMakeScale(0.95, 0.95);;
    }
    return self;
}

@end

@interface ATModalPopView()
@property (nonatomic,strong) UIView * popView;
@end

@implementation ATModalPopView
+ (ATModalPopView *)showInView:(UIView *)view configBlock:(ATModalPopConfigBlock _Nullable)configBlock{
    
    ATModalPopViewConfig * config = [ATModalPopViewConfig new];
    if(configBlock){
        configBlock(config);
    }
    
    ATModalPopView * modalView = [[self.class alloc] initWithFrame:view.bounds config:config];
    [view addSubview:modalView];
    
    [modalView resetInit];
    [modalView show:nil];
    return modalView;
}

- (void)defaultInit{}

- (void)setupSubviews{
    ATModalPopViewConfig * config = (ATModalPopViewConfig *)self.config;
    
    self.popView.alpha = config.popAlphaForInit;
    self.popView.frame = config.popFrameForInit;
    [self addSubview:self.popView];
    
    if(config.isTransformAnimated){
        self.popView.transform = config.popTransformForInit;
    }
}

- (void)layoutForShowAnimation{
    ATModalPopViewConfig * config = (ATModalPopViewConfig *)self.config;
    self.popView.alpha = config.popAlphaForShow;
    
    if(!config.isTransformAnimated){
        self.popView.frame = config.popFrameForShow;
    }else{
        self.popView.transform = config.popTransformForShow;
    }
}

- (void)layoutForHideAnimation{
    ATModalPopViewConfig * config = (ATModalPopViewConfig *)self.config;
    self.popView.alpha = config.popAlphaForHide;
    
    if(!config.isTransformAnimated){
        self.popView.frame = config.popFrameForHide;
    }else{
        self.popView.transform = config.popTransformForHide;
    }
}

//Getter
- (UIView *)popView{
    if(!_popView){
        _popView = [[UIView alloc] init];
        _popView.backgroundColor = UIColor.whiteColor;
    }
    return _popView;
}

@end
