//
//  ATModalPopView.h
//  GoveeHome
//
//  Created by liyebiao on 2021/6/4.
//  Copyright © 2021 ihoment. All rights reserved.
//

#import "ATModalView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ATModalPopViewConfig: ATModalViewConfig
@property (nonatomic,assign) CGRect popFrameForInit;
@property (nonatomic,assign) CGRect popFrameForShow;
@property (nonatomic,assign) CGRect popFrameForHide;

@property (nonatomic,assign) CGFloat popAlphaForInit;
@property (nonatomic,assign) CGFloat popAlphaForShow;
@property (nonatomic,assign) CGFloat popAlphaForHide;

@property (nonatomic,assign) BOOL isTransformAnimated;  //默认为 YES， 注意：此属性如果打开为 YES，将不会再修改popFrame，只会用CGAffineTransform动画
@property (nonatomic) CGAffineTransform popTransformForInit;
@property (nonatomic) CGAffineTransform popTransformForShow;
@property (nonatomic) CGAffineTransform popTransformForHide;

@end


@class ATModalPopView;
typedef void (^ATModalPopConfigBlock)(ATModalPopViewConfig * config);

@interface ATModalPopView : ATModalView

@property (nonatomic,strong,readonly) UIView * popView;

+ (ATModalPopView *)showInView:(UIView *)view configBlock:(ATModalPopConfigBlock _Nullable)configBlock;

@end

NS_ASSUME_NONNULL_END
