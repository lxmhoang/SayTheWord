//
//  AppDelegate.h
//  saytheword
//
//  Created by Hoang le on 5/27/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootController.h"
#import "Appirater.h"
#import <FacebookSDK/FacebookSDK.h>




@interface AppDelegate : NSObject <UIApplicationDelegate, FBLoginViewDelegate >
{
    AVAudioPlayer *player;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) RootController *rootController;

- (RootController *)getRootController;
- (void)setBGSoundVolume:(float)vol;

- (void)playBGSound;
- (void)stopBGSound;



@end
