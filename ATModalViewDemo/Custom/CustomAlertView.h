//
//  CustomAlertView.h
//  ATModalViewDemo
//
//  Created by liyebiao on 2021/6/21.
//

#import <UIKit/UIKit.h>
#import "ATModalCustomPopView.h"

NS_ASSUME_NONNULL_BEGIN
@interface CustomAlertViewConfig : NSObject

@property (nonatomic,copy) NSAttributedString * title;
@property (nonatomic,copy) NSAttributedString * message;
@property (nonatomic,copy) NSArray<NSAttributedString *> * items;
@property (nonatomic,copy) NSArray<UIColor *> * itemBackgroundColors;
@property (nonatomic,copy) UIColor * itemBackgroundColor;

@property (nonatomic,assign) CGFloat titleMinHeight;
@property (nonatomic,assign) CGFloat messageMinHeight;
@property (nonatomic,assign) CGFloat bottomMinHeight;

@property (nonatomic,assign) CGFloat itemInterval;

@property (nonatomic,assign) UIEdgeInsets topInsets;
@property (nonatomic,assign) UIEdgeInsets contentInsets;
@property (nonatomic,assign) UIEdgeInsets bottomInsets;

@property (nonatomic,assign) CGFloat popMarginLeft;
@property (nonatomic,assign) CGFloat popMarginRight;
@property (nonatomic,assign) CGFloat popCornerRadius;

@property (nonatomic,assign) NSTextAlignment titleAlignment;
@property (nonatomic,assign) NSTextAlignment messageAlignment;

- (NSMutableAttributedString *)defaultTitleAttributed:(NSString *)text;
- (NSMutableAttributedString *)defaultMessageAttributed:(NSString *)text;
- (NSMutableAttributedString *)defaultItemAttributed:(NSString *)text;

@property (nonatomic,copy) void (^onClickItemBlock)(NSUInteger index, BOOL * canDismiss);

@end

typedef void (^ATModalAlertConfigBlock)(CustomAlertViewConfig * config);


@interface CustomAlertView : UIView<ATModalCustomViewProtocol>

@property (nonatomic,strong,readonly) UIView * topView;
@property (nonatomic,strong,readonly) UIView * contentView;
@property (nonatomic,strong,readonly) UIView * bottomView;
- (instancetype)initWithFrame:(CGRect)frame config:(nonnull CustomAlertViewConfig *)config;

@end

@interface CustomAlertView(ExtShow)

+ (void)showAlertInView:(UIView *)view configBlock:(ATModalAlertConfigBlock)configBlock;

@end


NS_ASSUME_NONNULL_END
