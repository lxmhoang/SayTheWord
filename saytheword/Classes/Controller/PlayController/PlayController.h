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
//#import "HintView.h"
#import "HintsView.h"
#import "IAPViewController.h"

@class IAPViewController;

@protocol PlayControllerProtocol <NSObject>

- (void)backBtnPressFromPlayController;
- (void)showWinScreen;
- (void)initFullScreenAds;



@end

@interface PlayController : UIViewController <PlayViewProtocol, HintsViewDelegate, UIAlertViewDelegate, TypingViewDelegate, IAPControllerDelegate, UIAlertViewDelegate>
{
    HintsView *hintsView;
    NSString *msg;
    int pos;
}

@property (nonatomic, strong) UIImage *screenShot;
@property (nonatomic, strong) IAPViewController *iapVC;
@property (nonatomic, strong) PlayModel *playModel;
@property (nonatomic, strong) PlayView *playView;
@property (nonatomic, unsafe_unretained) id delegate;

-(id)initWithPosition:(int)_pos;

@end
