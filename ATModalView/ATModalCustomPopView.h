//
//  ATModalCustomPopView.h
//  GoveeHome
//
//  Created by liyebiao on 2021/6/4.
//  CopyriATt © 2021 ihoment. All riATts reserved.
//

#import "ATModalPopView.h"

NS_ASSUME_NONNULL_BEGIN

@class ATModalCustomPopView;
@class ATModalCustomPopViewConfig;
@protocol ATModalCustomViewProtocol;

typedef void (^ATModalPopCustomConfigBlock)(ATModalCustomPopView * customPopView, UIView<ATModalCustomViewProtocol> * customView, ATModalCustomPopViewConfig * config);


@interface ATModalCustomPopViewConfig : ATModalPopViewConfig
@property (nonatomic,copy) ATModalPopCustomConfigBlock initLayoutBlock;
@property (nonatomic,copy) ATModalPopCustomConfigBlock showLayoutBlock;
@property (nonatomic,copy) ATModalPopCustomConfigBlock hideLayoutBlock;
@property (nonatomic,copy) ATModalBlock willShowBlock;
@property (nonatomic,copy) ATModalBlock didShowBlock;
@property (nonatomic,copy) ATModalBlock willDismissBlock;
@property (nonatomic,copy) ATModalBlock didDismissBlock;
@end


@protocol ATModalCustomViewProtocol <NSObject>
@optional
- (void)customViewInitLayout:(ATModalCustomPopView *)customPopView config:(ATModalCustomPopViewConfig *)config;
- (void)customViewShowLayout:(ATModalCustomPopView *)customPopView config:(ATModalCustomPopViewConfig *)config;
- (void)customViewHideLayout:(ATModalCustomPopView *)customPopView config:(ATModalCustomPopViewConfig *)config;
- (void)customViewWillShow:(ATModalCustomPopView *)customPopView;
- (void)customViewDidShow:(ATModalCustomPopView *)customPopView;
- (void)customViewWillDismiss:(ATModalCustomPopView *)customPopView;
- (void)customViewDidDismiss:(ATModalCustomPopView *)customPopView;
@end



@interface ATModalCustomPopView : ATModalPopView

+ (ATModalCustomPopView *)showInView:(UIView *)view
                          customView:(UIView<ATModalCustomViewProtocol> *)customView
                         configBlock:(ATModalPopConfigBlock _Nullable)configBlock;

@end

NS_ASSUME_NONNULL_END
