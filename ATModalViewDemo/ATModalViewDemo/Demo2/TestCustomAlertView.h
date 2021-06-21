//
//  TestCustomAlertView.h
//  ATModalViewDemo
//
//  Created by liyebiao on 2021/6/21.
//

#import <UIKit/UIKit.h>
#import "ATModalCustomPopView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestCustomAlertView : UIView<ATModalCustomViewProtocol>

@end

@interface TestCustomAlertView(Ext)

+ (void)showInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
