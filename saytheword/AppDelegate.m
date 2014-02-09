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

@implementation AppDelegate
@synthesize rootController;

- (RootController *)getRootController
{
    return rootController;
}

- (void)playBGSound
{
    player.volume = 0.2;
    [player play];
}

- (void)stopBGSound
{
    [player stop];
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    WordInfo *info = [[WordDatabase database] wordInfoWithLevel:6];
//    NSLog(@"%d: %@, %@, %@",info.level, info.leftWord, info.rightWord, info.finalWord);
//    NSArray *wordInfos = [WordDatabase database].WordsInfo;
//    for (WordInfo *info in wordInfos) {
//        NSLog(@"%d: %@, %@, %@",info.level, info.leftWord, info.rightWord, info.finalWord);
//    }
    
    [FBLoginView class];

   
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"RiverFlowsInYou" ofType:@"mp3"];
    NSURL *pathURL = [NSURL fileURLWithPath : path];
    
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:pathURL error:nil];
    player.numberOfLoops = -1; //Infinite

    [CommonFunction createGlobalVariable];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    rootController = [[RootController alloc]init];
    [self.window setRootViewController:rootController];
    [rootController release];
    [Appirater appLaunched:YES];
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
    if (FBSession.activeSession.isOpen)
    {
        [FBRequestConnection startWithGraphPath:@"/me/likes/172415879600587" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (error) {

                NSLog(@"FB_UD %@", error.userInfo);
            } else {
                if ([[result objectForKey:@"data"] count]>0)
                {
                    if (![CommonFunction getLikeFanPage]){
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thank you for liking our page" message:[NSString stringWithFormat:@"You get %d coins", kRewardCoinsForLikingFB] delegate:rootController cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alertView show];
                        [alertView release];
                    }
                    
                    [CommonFunction setLikeFanPage:YES];
                }
                NSLog(@"FB_LIKES: %@:", result);
            }
        }];
    }else
    {
        
    }
    [Appirater appEnteredForeground:YES];
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



#pragma mark - FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // first get the buttons set for login mode
    loginView.hidden = YES;
    NSLog(@"loginView showwww");
    
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"logged out");
    // test to see if we can use the share dialog built into the Facebook application
    FBShareDialogParams *p = [[FBShareDialogParams alloc] init];
    p.link = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
#ifdef DEBUG
    [FBSettings enableBetaFeatures:FBBetaFeaturesShareDialog];
#endif
    //    BOOL canShareFB = [FBDialogs canPresentShareDialogWithParams:p];
    //    BOOL canShareiOS6 = [FBDialogs canPresentOSIntegratedShareDialogWithSession:nil];
    //
    
    // "Post Status" available when logged on and potentially when logged off.  Differentiate in the label.
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}




@end
