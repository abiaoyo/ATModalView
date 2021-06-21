//
//  ATModalView.h
//  GoveeHome
//
//  Created by liyebiao on 2021/6/4.
//  Copyright © 2021 ihoment. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ATModalBlock)(void);


@interface ATModalViewConfig: NSObject
@property (nonatomic,assign) CGFloat showAnimationDuration;
@property (nonatomic,assign) CGFloat hideAnimationDuration;
@property (nonatomic,assign) CGFloat showAnimationSpringDamping;
@property (nonatomic,assign) CGFloat hideAnimationSpringDamping;
@property (nonatomic,assign) CGFloat showAnimationSpringVelocity;
@property (nonatomic,assign) CGFloat hideAnimationSpringVelocity;
@property (nonatomic,assign) CGFloat showAnimationDelay;
@property (nonatomic,assign) CGFloat hideAnimationDelay;
@property (nonatomic,assign) UIViewAnimationOptions showAnimationOptions;
@property (nonatomic,assign) UIViewAnimationOptions hideAnimationOptions;

@property (nonatomic,assign) BOOL tapModalDismiss;
@end



@interface ATModalView : UIView
@property (nonatomic,strong,readonly) UIView * modalView;
@property (nonatomic,strong,readonly) ATModalViewConfig * config;

- (instancetype)initWithFrame:(CGRect)frame config:(ATModalViewConfig *)config;

- (void)defaultInit;  //默认设置流程 - 可重写为空实现，再调用resetSetup
- (void)resetInit;    //重置设置流程 - 不需要重写

- (void)setupData;      //初始化数据 - 重写
- (void)setupSubviews;  //初始化视图 - 重写
- (void)setupLayout;    //初始化布局 - 重写
- (void)didSetup;       //完成设置流程 - 重写

- (void)layoutForShowAnimation;  //布局 - 显示时 - 重写
- (void)layoutForHideAnimation;  //布局 - 隐藏时 - 重写

- (void)show:(ATModalBlock _Nullable)completion;
- (void)dismiss:(ATModalBlock _Nullable)completion;

@end


@interface ATModalView(ExtAnimation)

- (void)viewShowAnimationBlock:(ATModalBlock _Nullable)animationBlock
                    completion:(ATModalBlock _Nullable)completion;

- (void)viewHideAnimationBlock:(ATModalBlock _Nullable)animationBlock
                    completion:(ATModalBlock _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
