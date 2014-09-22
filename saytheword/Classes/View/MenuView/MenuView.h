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

@protocol MenuViewProtocol <NSObject>

- (void)playBtnPressFromMenuView;
- (void)coinViewTappedFromMenuView;

@end

@interface MenuView : UIView
{
    UILabel *coinLabel;
    UIImageView *coinImageView;
    UIView *coinView;
    UIImageView *musicIcon;
}


@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) MenuModel *menuModel;
@property (nonatomic, retain) UILabel *coinLabel;


- (id)initWithModel:(MenuModel *)_model;

@end
