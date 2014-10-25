//
//  AppDelegate.m
//  saytheword
//
//  Created by Hoang le on 5/27/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "AppDelegate.h"
#import "WordDatabase.h"
#import "WordInfo.h"
#import <Parse/Parse.h>
#import <Crashlytics/Crashlytics.h>

@implementation AppDelegate
@synthesize rootController;

- (RootController *)getRootController
{
    return rootController;
}

- (void)setBGSoundVolume:(float)vol
{
    player.volume = vol;
}

- (void)playBGSound
{
    player.volume = [CommonFunction getBGSoundVolume];
    [player play];
}

- (void)stopBGSound
{
    [player stop];
}

- (void)playBtnClickSound
{
   AudioServicesPlaySystemSound(btnClickSound);
}

- (void)playFireworkSoud
{
    AudioServicesPlaySystemSound(fireWorkSound);
}

- (void)playLetterPickSound
{
    AudioServicesPlaySystemSound(letterPickSound);
}

- (void)playSuccessSound
{
    AudioServicesPlaySystemSound(successSound);
}

- (void)playSingleCoinSound
{
    AudioServicesPlaySystemSound(singleCoin);
}

- (void)playManyCoinsSound
{
    AudioServicesPlaySystemSound(manyCoins);
}

- (void)playSweepSound
{
    AudioServicesPlaySystemSound(sweep);
}

#pragma mark In App Purchase Delegate

- (void)afterTransaction
{
    for (id vc in rootController.childViewControllers)
    {
        if ([vc respondsToSelector:@selector(updateCoininVIew)])
        {
            [vc updateCoininVIew];
        }
    }
}
- (void)dismissVC
{
    // no need
}
- (void)setListProducts:(NSArray *)listProducts
{
    listOfIAPs = [NSArray arrayWithArray:listProducts];
}
- (void)IAPFailed
{
    
}

- (void)requestIAP
{
    listOfIAPs = nil;
    iAPHelper = [[IAPHelper alloc]init];
    iAPHelper.delegate = self;
//    [iAPHelper performSelector:@selector(loadStore) withObject:nil afterDelay:3.0f];
    [iAPHelper loadStore];
}

- (NSArray *)getIAP
{
    return listOfIAPs;
}


- (void)checkFBLike
{
    if (FBSession.activeSession.isOpen)
    {
        [FBRequestConnection startWithGraphPath:@"/me/likes/172415879600587" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (error)
            {
                
                
            } else {
                if ([[result objectForKey:@"data"] count]>0)
                {
                    [CommonFunction setLikeFanPage:YES];
                }else{
                    
                }
            }
        }];
    }else
    {

    }
}


#pragma mark default functions

- (void)initSounds
{
    NSString *pathFW  = [[NSBundle mainBundle] pathForResource:@"firework_explode" ofType:@"mp3"];
    CFURLRef pathURLFW = (__bridge CFURLRef)[NSURL fileURLWithPath : pathFW];
    
    AudioServicesCreateSystemSoundID(pathURLFW, &fireWorkSound);
    
    
    
    NSString *pathBtnClick  = [[NSBundle mainBundle] pathForResource:@"btnClick" ofType:@"wav"];
    CFURLRef pathURLBtnClick = (__bridge CFURLRef)[NSURL fileURLWithPath : pathBtnClick];
    
    AudioServicesCreateSystemSoundID(pathURLBtnClick, &btnClickSound);
    
    NSString *pathLetterPick  = [[NSBundle mainBundle] pathForResource:@"poptounge" ofType:@"wav"];
    CFURLRef pathURLLetterPick = (__bridge CFURLRef)[NSURL fileURLWithPath : pathLetterPick];
    
    AudioServicesCreateSystemSoundID(pathURLLetterPick, &letterPickSound);
    
    
    
    NSString *pathSuccess  = [[NSBundle mainBundle] pathForResource:@"success" ofType:@"wav"];
    CFURLRef pathURLSuccess = (__bridge CFURLRef)[NSURL fileURLWithPath : pathSuccess];
    AudioServicesCreateSystemSoundID(pathURLSuccess, &successSound);
    
    
    NSString *pathSingleCoin  = [[NSBundle mainBundle] pathForResource:@"single_coin_drop" ofType:@"wav"];
    CFURLRef pathURLSingleCoin = (__bridge CFURLRef)[NSURL fileURLWithPath : pathSingleCoin];
    AudioServicesCreateSystemSoundID(pathURLSingleCoin, &singleCoin);
    
    NSString *pathManyCoins  = [[NSBundle mainBundle] pathForResource:@"many_coin_drop" ofType:@"wav"];
    CFURLRef pathURLManyCoins = (__bridge CFURLRef)[NSURL fileURLWithPath : pathManyCoins];
    AudioServicesCreateSystemSoundID(pathURLManyCoins, &manyCoins);
    
    NSString *pathSweep  = [[NSBundle mainBundle] pathForResource:@"sweep" ofType:@"wav"];
    CFURLRef pathURLSweep = (__bridge CFURLRef)[NSURL fileURLWithPath : pathSweep];
    AudioServicesCreateSystemSoundID(pathURLSweep, &sweep);
    
    int k = arc4random()%10;
    NSString *song;
    if (k%2==0)
    {
        song = @"RiverFlowsInYou";
    }else
    {
        song = @"Kiss_The_Rain";
    }
    
    NSString *path  = [[NSBundle mainBundle] pathForResource:song ofType:@"mp3"];
    NSURL *pathURL = [NSURL fileURLWithPath : path];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:pathURL error:nil];
    player.numberOfLoops = -1; //Infinite
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if ([CommonFunction getWordInfoForLevel:1] == nil)
    {
        [[WordDatabase database] insertDatabaseIntoNSUserDefault];
    }
    self.screenShot = nil;
    [self requestIAP];
    [FBLoginView class];
//    WordInfo *info = [[WordDatabase database] wordInfoWithLevel:6];
//    NSLog(@"%d: %@, %@, %@",info.level, info.leftWord, info.rightWord, info.finalWord);
//    NSArray *wordInfos = [WordDatabase database].WordsInfo;
//    for (WordInfo *info in wordInfos) {
//        NSLog(@"%d: %@, %@, %@",info.level, info.leftWord, info.rightWord, info.finalWord);
//    }
    
    
    
    [Parse setApplicationId:@"7Rx018E0kJKkmON2WF5pSCWLxa5u0mR8boHcHCc5"
                  clientKey:@"cQijJMLIqBiUCcNkaN1m4K7NbEyBhLCC0ZxM8BPA"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [Crashlytics startWithAPIKey:@"36b3007e0a0f53cf00825f195fc7f17a5e8db471"];

    
    //-- Set Notification
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
//
    
    [self initSounds];
 
    
    [CommonFunction class];
    


    [CommonFunction createGlobalVariable];
    
    if ([CommonFunction getRateUS] == 2)// app is rated before
    {
        if ([CommonFunction getRatedVersion] == nil)
        {
            // it's weird
        }else
        {
            if (![[CommonFunction getRatedVersion] isEqualToString:
                [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]])
            {
                [CommonFunction setRateUs:0];
            }
        }
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    rootController = [[RootController alloc]init];
    [self.window setRootViewController:rootController];
    

    // check coin reward for rateus
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    if ([CommonFunction checkIfRateForCoin] && ([CommonFunction getRateUS] == 1) && [CommonFunction getRewardCoinForRattingApp] > 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:kMsgThankForRating] message:[NSString stringWithFormat:@" You have claimed %d coins", [CommonFunction getRewardCoinForRattingApp]] delegate:rootController cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [CommonFunction setRateUs:2];
        [CommonFunction setRatedVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    }
    
    
    if (FBSession.activeSession.isOpen)
    {
        [FBRequestConnection startWithGraphPath:@"/me/likes/172415879600587" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (error) {

                NSLog(@"FB_UD %@", error.userInfo);
            } else {
                if ([[result objectForKey:@"data"] count]>0)
                {
                    if (![CommonFunction getLikeFanPage]){
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thank you for liking our page" message:[NSString stringWithFormat:@"You get %d coins", [CommonFunction getRewardCoinForLikingPage]] delegate:rootController cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alertView show];
                        
                    }
                    
                    [CommonFunction setLikeFanPage:YES];
                }
                NSLog(@"FB_LIKES: %@:", result);
            }
        }];
    }else
    {
//        [FBSession ope]
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppCall handleDidBecomeActive];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                    fallbackHandler:^(FBAppCall *call) {
                        NSLog(@"In fallback handler");
                    }];
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *str =
    [NSString stringWithFormat:@"%@",deviceToken];
    str = [[str stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
           stringByReplacingOccurrencesOfString:@" "
           withString:@""];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"] == nil)
    {

//        [CommonFunction alert:@"first time" delegate:nil];
        // first time or not ?
        
        PFObject *obj = [[PFObject alloc] initWithClassName:@"Installation"];
        
        [CommonFunction updateInstallationInfoWithObject:obj andDeviceToken:str];
        [CommonFunction updateConfigurationInfo];
        
    }else         if ([[NSDate date] compare:[[CommonFunction getLastUpdateInfo] dateByAddingTimeInterval:[[CommonFunction gettimeBetweenUpdate] doubleValue]]]==NSOrderedDescending)
    {
//        NSDate *dateToUpdate = [[CommonFunction getLastUpdateInfo] dateByAddingTimeInterval:[[CommonFunction gettimeBetweenUpdate] doubleValue]];
//        NSString *str222 = [NSString stringWithFormat:@"WILL update \n, current time : %@ , \n last update : %@, \n time until next update : %d  ,\n  time to update : %@", [NSDate date], [CommonFunction getLastUpdateInfo], [[CommonFunction gettimeBetweenUpdate] intValue], dateToUpdate];
//        [CommonFunction alert:str222 delegate:nil];
//        [CommonFunction alert:@"long enough, let's update" delegate:nil];
        PFQuery *query = [PFQuery queryWithClassName:@"Installation"];
        
        [query whereKey:@"deviceToken" equalTo:str];
//        NSLog(@"device token searching for : %@",str);
        query.cachePolicy = kPFCachePolicyNetworkElseCache;
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                PFObject *obj = [objects firstObject];
                if (obj)
                {
                    [CommonFunction updateInstallationInfoWithObject:obj andDeviceToken:str];
                    
                    [CommonFunction updateConfigurationInfo];
                }else
                {
                    // no obj with this devicetoken on parse, may be first update has not completed yet, so we do nothing, wait for first update to be completed
                }
            } else {
                // Log details of the failure
//                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }else
    {
        
//        NSDate *dateToUpdate = [[CommonFunction getLastUpdateInfo] dateByAddingTimeInterval:[[CommonFunction gettimeBetweenUpdate] doubleValue]];
//        NSString *str = [NSString stringWithFormat:@"no update \n, current time : %@ , \n last update : %@, \n time until next update : %d  ,\n  time to update : %@", [NSDate date], [CommonFunction getLastUpdateInfo], [[CommonFunction gettimeBetweenUpdate] intValue], dateToUpdate];
//        [CommonFunction alert:str delegate:nil];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    

    
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}



@end
