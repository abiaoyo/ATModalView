//
//  TestCustomAlertView2.h
//  ATModalViewDemo
//
//  Created by liyebiao on 2021/6/21.
//

#import <UIKit/UIKit.h>
#import "ATModalCustomPopView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestCustomAlertView2 : UIView<ATModalCustomViewProtocol>

@end

@interface TestCustomAlertView2(Ext)

+ (void)showInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
