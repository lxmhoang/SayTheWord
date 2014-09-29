//
//  MenuView.h
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"
#import <QuartzCore/QuartzCore.h>
#import "GradientButton.h"

#import <iAd/iAd.h>

@protocol MenuViewProtocol <NSObject>

- (void)playBtnPressFromMenuView;
- (void)coinViewTappedFromMenuView;

@end

@interface MenuView : UIView <ADBannerViewDelegate>
{
    UILabel *coinLabel;
    UIImageView *coinImageView;
    UIView *coinView;
    UIImageView *musicIcon;
    
    ADBannerView *adbanner;
    BOOL _bannerIsVisible;
}


@property (nonatomic, unsafe_unretained) id delegate;
@property (nonatomic, strong) MenuModel *menuModel;
@property (nonatomic, strong) UILabel *coinLabel;


- (id)initWithModel:(MenuModel *)_model;

@end
