//
//  ViewController.m
//  ATModalViewDemo
//
//  Created by liyebiao on 2021/6/21.
//

#import "ViewController.h"
#import "TestCustomViewController.h"
#import "TestCustomAlertView.h"
#import "TestCustomAlertView2.h"
#import "CustomAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickAction:(id)sender {
    TestCustomViewController * viewCtl = [[TestCustomViewController alloc] init];
    [self presentViewController:viewCtl animated:NO completion:nil];
}

- (IBAction)clickAlert1:(id)sender {
    [TestCustomAlertView showInView:self.view];
}

- (IBAction)clickAlertChangeFrame:(id)sender {
    [TestCustomAlertView2 showInView:self.view];
}

- (IBAction)clickDefaultAlert:(id)sender {
    
    [CustomAlertView showAlertInView:self.view configBlock:^(CustomAlertViewConfig * _Nonnull config) {
        config.title = [config defaultTitleAttributed:@"标题"];
        config.message = [config defaultMessageAttributed:@"消息内容"];
        config.items = @[[config defaultItemAttributed:@"取消"],[config defaultItemAttributed:@"确定"]];
        config.itemBackgroundColors = @[[UIColor colorWithRed:1 green:0 blue:0 alpha:0.35],[UIColor colorWithRed:0.3 green:0.8 blue:0 alpha:0.35]];
        config.onClickItemBlock = ^(NSUInteger index, BOOL * _Nonnull canDismiss) {
            if(index == 1){
                *canDismiss = NO;
            }
        };
    }];
}

@end
