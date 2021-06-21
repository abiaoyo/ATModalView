//
//  TestCustomViewController.m
//  GoveeHome
//
//  Created by liyebiao on 2021/6/7.
//  Copyright © 2021 ihoment. All rights reserved.
//

#import "TestCustomViewController.h"
#import "TestCustomActionView.h"
#import "ATModalCustomPopView.h"

@interface TestCustomViewController ()

@property (nonatomic,assign) BOOL hasShow;

@end

@implementation TestCustomViewController

- (void)dealloc
{
    NSLog(@"--- dealloc %@ ---",self.class);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!self.hasShow){
        self.hasShow = YES;
        
        __weak typeof(self) weakSelf = self;
        
        CGFloat selfWidth = CGRectGetWidth(weakSelf.view.frame);
        CGFloat selfHeight = CGRectGetHeight(weakSelf.view.frame);
        CGFloat popHeight = selfHeight/2.0f;
        
        TestCustomActionView * customView = [[TestCustomActionView alloc] init];
        [ATModalCustomPopView showInView:self.view customView:customView configBlock:^(ATModalPopViewConfig * _Nonnull config) {
            ATModalCustomPopViewConfig * customConfig = (ATModalCustomPopViewConfig *)config;
            
            config.isTransformAnimated = NO;
            config.popFrameForInit = CGRectMake(0, selfHeight, selfWidth, popHeight);
            
            config.popFrameForShow = CGRectMake(0, selfHeight-popHeight, selfWidth, popHeight);
            config.popFrameForHide = config.popFrameForInit;
            
            customConfig.initLayoutBlock = ^(ATModalCustomPopView * _Nonnull customPopView, UIView<ATModalCustomViewProtocol> * _Nonnull customView, ATModalCustomPopViewConfig * _Nonnull config) {
                customView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.35];
            };
            customConfig.didDismissBlock = ^{
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
            };
        }];
    }
}

@end
