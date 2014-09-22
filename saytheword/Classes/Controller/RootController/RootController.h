//
//  RootController.h
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuController.h"
#import "PlayController.h"
#import "RootView.h"
#import "WinController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppiraterDelegate.h"

#import "SettingViewController.h"

#import "SparklesViewController.h"  

#import "HowToPlayViewController.h"





@interface RootController : UIViewController<MenuControllerProtocol, PlayControllerProtocol, WinControllerProtocol, AppiraterDelegate, SettingControllerProtocol,UIAlertViewDelegate, HowToControllerProtocol>
{
    BOOL getCoinsForRating;
}

@property (nonatomic, retain) UIViewController *fVC;

@end
