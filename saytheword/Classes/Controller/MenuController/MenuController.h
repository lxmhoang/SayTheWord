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
#import "StoreController.h"

@protocol MenuControllerProtocol <NSObject>

- (void)playActionFromMenuController;

@end


@interface MenuController : UIViewController<MenuViewProtocol, StoreControllerDelegate>

@property (nonatomic, retain) MenuView *menuView;
@property (nonatomic, retain) MenuModel *menuModel;
@property (nonatomic, assign) id delegate;

- (id)initWithPosition:(int)_pos;

@end
