//
//  AppDelegate.h
//  saytheword
//
//  Created by Hoang le on 5/27/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootController.h"
#import <FacebookSDK/FacebookSDK.h>





@interface AppDelegate : NSObject <UIApplicationDelegate, FBLoginViewDelegate >
{
    AVAudioPlayer *player;
    SystemSoundID fireWorkSound;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) RootController *rootController;

- (RootController *)getRootController;
- (void)setBGSoundVolume:(float)vol;

- (void)playBGSound;
- (void)stopBGSound;

- (void)playFireworkSoud;




@end
