//
//  TestCustomActionView.m
//  GoveeHome
//
//  Created by liyebiao on 2021/6/4.
//  Copyright © 2021 ihoment. All rights reserved.
//

#import "TestCustomActionView.h"


@interface TestCustomActionView()
@property (nonatomic,strong) ATModalCustomPopView * customPopView;
@end

@implementation TestCustomActionView

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





