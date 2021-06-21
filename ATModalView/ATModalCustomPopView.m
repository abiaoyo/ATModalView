//
//  ATModalCustomPopView.m
//  GoveeHome
//
//  Created by liyebiao on 2021/6/4.
//  Copyright © 2021 ihoment. All rights reserved.
//

#import "ATModalCustomPopView.h"


@implementation ATModalCustomPopViewConfig

@end

@interface ATModalCustomPopView()
@property (nonatomic,strong) UIView<ATModalCustomViewProtocol> * customView;
@end

@implementation ATModalCustomPopView

+ (ATModalCustomPopView *)showInView:(UIView *)view
                          customView:(UIView<ATModalCustomViewProtocol> *)customView
                         configBlock:(ATModalPopConfigBlock _Nullable)configBlock{
        
    ATModalCustomPopViewConfig * config = [ATModalCustomPopViewConfig new];
    if(configBlock){
        configBlock(config);
    }
    
    ATModalCustomPopView * modalView = [[self.class alloc] initWithFrame:view.bounds config:config];
    modalView.customView = customView;
    [view addSubview:modalView];
    
    [modalView resetInit];
    [modalView show:nil];
    return modalView;
}

- (void)setupSubviews{
    [super setupSubviews];
    [self.popView addSubview:self.customView];
    
    ATModalCustomPopViewConfig * config = (ATModalCustomPopViewConfig *)self.config;
    
    if(config.initLayoutBlock){
        config.initLayoutBlock(self, self.customView, config);
    }
    if([self.customView respondsToSelector:@selector(customViewInitLayout:config:)]){
        [self.customView customViewInitLayout:self config:config];
    }
}

- (void)layoutForShowAnimation{
    ATModalCustomPopViewConfig * config = (ATModalCustomPopViewConfig *)self.config;
    if(config.showLayoutBlock){
        config.showLayoutBlock(self, self.customView, config);
    }
    if([self.customView respondsToSelector:@selector(customViewShowLayout:config:)]){
        [self.customView customViewShowLayout:self config:config];
    }
    [super layoutForShowAnimation];
}

- (void)layoutForHideAnimation{
    ATModalCustomPopViewConfig * config = (ATModalCustomPopViewConfig *)self.config;
    if(config.hideLayoutBlock){
        config.hideLayoutBlock(self, self.customView, config);
    }
    if([self.customView respondsToSelector:@selector(customViewHideLayout:config:)]){
        [self.customView customViewHideLayout:self config:config];
    }
    [super layoutForHideAnimation];
}

- (void)show:(ATModalBlock)completion{
    UIView<ATModalCustomViewProtocol> * customView = self.customView;
    if([customView respondsToSelector:@selector(customViewWillShow:)]){
        [customView customViewWillShow:self];
    }
    ATModalCustomPopView * customPopView = self;
    void (^onDidShowBlock)(void) = ^{
        if([customView respondsToSelector:@selector(customViewDidShow:)]){
            [customView customViewDidShow:customPopView];
        }
    };
    ATModalCustomPopViewConfig * config = (ATModalCustomPopViewConfig *)self.config;
    if(config.willShowBlock){
        config.willShowBlock();
    }
    [super show:^(){
        if(completion){
            completion();
        }
        if(config.didShowBlock){
            config.didShowBlock();
        }
        onDidShowBlock();
    }];
}

- (void)dismiss:(ATModalBlock)completion{
    UIView<ATModalCustomViewProtocol> * customView = self.customView;
    if([customView respondsToSelector:@selector(customViewWillDismiss:)]){
        [customView customViewWillDismiss:self];
    }
    ATModalCustomPopView * customPopView = self;
    void (^onDidDismissBlock)(void) = ^{
        if([customView respondsToSelector:@selector(customViewDidDismiss:)]){
            [customView customViewDidDismiss:customPopView];
        }
    };
    
    ATModalCustomPopViewConfig * config = (ATModalCustomPopViewConfig *)self.config;
    if(config.willDismissBlock){
        config.willDismissBlock();
    }
    [super dismiss:^(){
        if(completion){
            completion();
        }
        if(config.didDismissBlock){
            config.didDismissBlock();
        }
        onDidDismissBlock();
    }];
    
}

@end
