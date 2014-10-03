//
//  PlayController.h
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayModel.h"
#import "PlayView.h"
#import "StoreController.h"
//#import "HintView.h"
#import "HintsView.h"
#import <FacebookSDK/FacebookSDK.h>
#import "IAPViewController.h"

@class IAPViewController;

@protocol PlayControllerProtocol <NSObject>

- (void)backBtnPressFromPlayController;
- (void)showWinScreen;



@end

@interface PlayController : UIViewController <PlayViewProtocol, StoreControllerDelegate, HintsViewDelegate, UIAlertViewDelegate, FBLoginViewDelegate, IAPControllerDelegate>

@property (nonatomic, strong) IAPViewController *iapVC;
@property (nonatomic, strong) PlayModel *playModel;
@property (nonatomic, assign) PlayView *playView;
@property (nonatomic, unsafe_unretained) id delegate;

-(id)initWithPosition:(int)_pos;

@end
