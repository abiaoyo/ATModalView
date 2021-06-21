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


@end
