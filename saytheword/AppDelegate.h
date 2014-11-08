//
//  AppDelegate.h
//  saytheword
//
//  Created by Hoang le on 5/27/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootController.h"
//#import <FacebookSDK

@class IAPHelper;




@interface AppDelegate : NSObject <UIApplicationDelegate, FBLoginViewDelegate, UIAlertViewDelegate , IAPHelperDelegate >
{
    AVAudioPlayer *player;
    SystemSoundID fireWorkSound;
    SystemSoundID letterPickSound, successSound, singleCoin, manyCoins, sweep, btnClickSound;
    NSArray *listOfIAPs;
    IAPHelper *iAPHelper;
    
    
}

@property (strong, nonatomic) UIImage *screenShot;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) RootController *rootController;

- (RootController *)getRootController;
- (void)setBGSoundVolume:(float)vol;

- (void)playBGSound;
- (void)stopBGSound;

- (void)playBtnClickSound;

- (void)playFireworkSoud;
- (void)playLetterPickSound;
- (void)playSuccessSound;
- (void)playSingleCoinSound;
- (void)playManyCoinsSound;
- (void)playSweepSound;

- (NSArray *)getIAP;



@end
