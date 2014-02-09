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

@protocol PlayControllerProtocol <NSObject>

- (void)backBtnPressFromPlayController;
- (void)showWinScreen;



@end

@interface PlayController : UIViewController <PlayViewProtocol, StoreControllerDelegate, HintsViewDelegate, UIAlertViewDelegate, FBLoginViewDelegate>

@property (nonatomic, retain) PlayModel *playModel;
@property (nonatomic, retain) PlayView *playView;
@property (nonatomic, assign) id delegate;

-(id)initWithPosition:(int)_pos;

@end
