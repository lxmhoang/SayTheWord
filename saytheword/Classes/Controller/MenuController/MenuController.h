//
//  MenuController.h
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuView.h"
#import "MenuModel.h"
#import "IAPViewController.h"

@protocol MenuControllerProtocol <NSObject>

- (void)playActionFromMenuController;

- (void)howtoActionFromMenuController;

@end


@interface MenuController : UIViewController<MenuViewProtocol, IAPControllerDelegate>

@property (nonatomic, strong) IAPViewController *iapVC;
@property (nonatomic, strong) MenuView *menuView;
@property (nonatomic, strong) MenuModel *menuModel;
@property (nonatomic, unsafe_unretained) id delegate;

- (id)initWithPosition:(int)_pos;

@end
