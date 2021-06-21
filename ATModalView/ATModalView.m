//
//  ATModalView.m
//  GoveeHome
//
//  Created by liyebiao on 2021/6/4.
//  Copyright © 2021 ihoment. All rights reserved.
//

#import "ATModalView.h"

@implementation ATModalViewConfig

- (instancetype)init{
    self = [super init];
    if (self) {
        self.showAnimationDuration = 0.45;
        self.hideAnimationDuration = 0.45;
        self.showAnimationSpringDamping = 1.0;
        self.hideAnimationSpringDamping = 1.0;
        self.showAnimationSpringVelocity = 0.1;
        self.hideAnimationSpringVelocity = 0.1;
        self.showAnimationDelay = 0;
        self.hideAnimationDelay = 0;
        self.showAnimationOptions = UIViewAnimationOptionCurveEaseOut;
        self.hideAnimationOptions = UIViewAnimationOptionCurveEaseIn;
        self.tapModalDismiss = YES;
    }
    return self;
}

@end



@interface ATModalView()
@property (nonatomic,strong) UIView * modalView;
@property (nonatomic,strong) ATModalViewConfig * config;
@end

@implementation ATModalView

- (void)dealloc{
    NSLog(@"--- dealloc %@ ---",self.class);
}

- (instancetype)initWithFrame:(CGRect)frame config:(ATModalViewConfig *)config{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = config;
        [self _setupSubviews];
        [self _setupLayout];
        [self defaultInit];
    }
    return self;
}

- (void)_setupSubviews{
    self.modalView = [[UIView alloc] initWithFrame:self.bounds];
    self.modalView.alpha = 0.0f;
    self.modalView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35];
    [self addSubview:self.modalView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapModalView:)];
    [self.modalView addGestureRecognizer:tap];
}

- (void)_setupLayout{
    self.modalView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)_tapModalView:(UITapGestureRecognizer *)tapGes{
    if(self.config.tapModalDismiss){
        [self dismiss:nil];
    }
}

- (void)defaultInit{
    [self setupData];
    [self setupSubviews];
    [self setupLayout];
    [self layoutIfNeeded];
    [self didSetup];
}

- (void)resetInit{
    [self setupData];
    [self setupSubviews];
    [self setupLayout];
    [self layoutIfNeeded];
    [self didSetup];
}



- (void)didSetup{
    
}

- (void)setupData{
    
}

- (void)setupSubviews{
    
}

- (void)setupLayout{
    
}

- (void)layoutForShowAnimation{
    
}

- (void)layoutForHideAnimation{
    
}

- (void)show:(ATModalBlock)completion{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self viewShowAnimationBlock:^{
            weakSelf.modalView.alpha = 1;
            [weakSelf layoutForShowAnimation];
            [weakSelf layoutIfNeeded];
        } completion:completion];
    });
}
- (void)dismiss:(ATModalBlock)completion{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self viewHideAnimationBlock:^{
            weakSelf.modalView.alpha = 0;
            [weakSelf layoutForHideAnimation];
            [weakSelf layoutIfNeeded];
        } completion:^{
            [weakSelf removeFromSuperview];
            if(completion){
                completion();
            }
        }];
    });
}

@end


@implementation ATModalView(ExtAnimation)

- (void)viewShowAnimationBlock:(ATModalBlock)animationBlock completion:(ATModalBlock)completion{
    
    [UIView animateWithDuration:self.config.showAnimationDuration
                          delay:self.config.showAnimationDelay
         usingSpringWithDamping:self.config.showAnimationSpringDamping
          initialSpringVelocity:self.config.showAnimationSpringVelocity
                        options:self.config.showAnimationOptions
                     animations:^{
        if(animationBlock){
            animationBlock();
        }
    } completion:^(BOOL finished) {
        if(completion){
            completion();
        }
    }];
}
- (void)viewHideAnimationBlock:(ATModalBlock)animationBlock completion:(ATModalBlock)completion{
    [UIView animateWithDuration:self.config.hideAnimationDuration
                          delay:self.config.hideAnimationDelay
         usingSpringWithDamping:self.config.hideAnimationSpringDamping
          initialSpringVelocity:self.config.hideAnimationSpringVelocity
                        options:self.config.hideAnimationOptions
                     animations:^{
        if(animationBlock){
            animationBlock();
        }
    } completion:^(BOOL finished) {
        if(completion){
            completion();
        }
    }];
}

@end
