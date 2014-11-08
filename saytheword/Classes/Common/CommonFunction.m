//
//  CommonFunction.m
//  saytheword
//
//  Created by Hoang Le on 6/23/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "CommonFunction.h"

#import <Parse/Parse.h>
#import <sys/utsname.h>
#import "ApActivityData.h"

@implementation CommonFunction

+ (UIImage *)getScreenShot
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return app.screenShot;
}

+ (NSURL *)getAppURL
{
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        return [NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=930826001"];
    }else
    {
        
        return [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id930826001"];
        
    }
}

+ (RootController *)getRootController{
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] getRootController];
}

+ (NSNumber *)gettimeBetweenUpdate
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"timeBetweenUpdate"];
}

+ (void)setTimeBetweenUpdate:(NSNumber*)num
{
    [[NSUserDefaults standardUserDefaults] setObject:num forKey:@"timeBetweenUpdate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)checkNoAds
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"noAds"];
}


+ (void)setNoAds:(BOOL)noAds
{
    [[NSUserDefaults standardUserDefaults] setBool:noAds forKey:@"noAds"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (BOOL)checkPlayMusic
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"playMusicFlag"];
}

+ (void)setMusicFlag:(BOOL)flag
{
    [[NSUserDefaults standardUserDefaults] setBool:flag forKey:@"playMusicFlag"];
}


+ (BOOL)checkFBLogin
{
    return FBSession.activeSession.isOpen;
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        return YES;
    } else {
        // No, display the login page.
        return NO;
    }
}

+ (BOOL)getLikeFanPage
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"likeFanPage"];
}

+ (void)setLikeFanPage:(BOOL)_value
{
    return [[NSUserDefaults standardUserDefaults] setBool:_value forKey:@"likeFanPage"];
}


#pragma mark sound control

+ (float)getBGSoundVolume
{
   return [[NSUserDefaults standardUserDefaults] floatForKey:@"bgSoundVolume"];
}

+ (void)setBGSoundVolume:(float)vol
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:vol] forKey:@"bgSoundVolume"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] setBGSoundVolume:vol];
    
}

+ (void)playBGSound
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playBGSound];
}
+ (void)stopBGSound{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopBGSound];
}

+ (void)playFireworkSound
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playFireworkSoud];
}

+ (void)playLetterPickSound
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playLetterPickSound];
}

+ (void)playBtnClickSound
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playBtnClickSound];
}
+ (void)playSuccessSound
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSuccessSound];
}
+ (void)playSingleCoinSound
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSingleCoinSound];
}
+ (void)playManyCoinsSound
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playManyCoinsSound];
}
+ (void)playSweepSound
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSweepSound];
}


#pragma mark set get remove index

+ (int)getRemoveIndex
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"indexOfRemove"] intValue];
}

+ (void)setRemoveIndex:(int)_val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_val] forKey:@"indexOfRemove"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark set get IndexOfReveal


+ (int)getRevealIndex
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"indexOfReveal"] intValue];
}

+ (void)setRevealIndex:(int)_val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_val] forKey:@"indexOfReveal"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark set get Level

+ (int)getLevel
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"level"] intValue];
}

+ (void)setLevel:(int)_val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_val] forKey:@"level"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark set get Coin

+ (int)getCoin
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"coins"] intValue];  
}

+ (void)setCoin:(int)_val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_val] forKey:@"coins"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark set get removeALetterTime

+(void)setCanRemoveALetter:(BOOL)_val
{
    [[NSUserDefaults standardUserDefaults] setBool:_val forKey:@"canRemoveALetter"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (BOOL)getCanRemoveALetter
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"canRemoveALetter"];
}

#pragma mark set get revealALetterTime

+ (void)setCanRevealALetter:(BOOL)_val
{
    [[NSUserDefaults standardUserDefaults] setBool:_val forKey:@"canRevealALetter"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (BOOL)getCanRevealALetter
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"canRevealALetter"];
}

#pragma mark set get time update to parse

+(void)setLastUpdateInfo:(NSDate *)_val
{
    
    [[NSUserDefaults standardUserDefaults] setObject:_val forKey:@"lastUpdateInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDate *)getLastUpdateInfo
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastUpdateInfo"];
}


#pragma mark set get time share app

+ (void)setLastSendEmail:(NSDate *)_val
{
   
    [[NSUserDefaults standardUserDefaults] setObject:_val forKey:@"lastSendEmail"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDate *)getLastSendEmail
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastSendEmail"];  
}

+ (void)setLastSendSMS:(NSDate *)_val
{
    [[NSUserDefaults standardUserDefaults] setObject:_val forKey:@"lastSendSMS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDate *)getLastSendSMS
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastSendSMS"];
}

+ (void)setLastFBShare:(NSDate *)_val
{
    
    [[NSUserDefaults standardUserDefaults] setObject:_val forKey:@"lastFBShare"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDate *)getLastFBShare
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastFBShare"];
}

+ (void)setLastTwitterShare:(NSDate *)_val
{
    
    [[NSUserDefaults standardUserDefaults] setObject:_val forKey:@"lastTwitterShare"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDate *)getLastTwitterShare
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastTwitterShare"];
}

#pragma mark set get showtitles, show answer

+ (void)setShowLeftTitle:(BOOL)_val
{
    [[NSUserDefaults standardUserDefaults] setBool:_val forKey:@"showLeftTitle"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getShowLeftTitle
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"showLeftTitle"];
}

+ (void)setShowRightTitle:(BOOL)_val
{
    [[NSUserDefaults standardUserDefaults] setBool:_val forKey:@"showRightTitle"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getShowRightTitle
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"showRightTitle"];
}

+ (void)setShowAnswer:(BOOL)_val
{
    [[NSUserDefaults standardUserDefaults] setBool:_val forKey:@"showAnswer"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getShowAnswer
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"showAnswer"];
}

#pragma mark get set rate us

+ (void)setRateUs:(int)_val
{
    [[NSUserDefaults standardUserDefaults] setInteger:_val forKey:@"rateUs"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getRateUS
{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"rateUs"];
}

#pragma mark get set rate us text

+ (void)setTextRateUs:(NSString *)_val
{
    [[NSUserDefaults standardUserDefaults] setObject:_val forKey:@"textRateUs"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getTextRateUs
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"textRateUs"];
}


#pragma mark createGlobalVariable

+ (void)createGlobalVariable
{
    
    NSNumber *coin = [NSNumber numberWithInt:kInitialCoin];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"rewardCoinForEachLevel"] == nil){
        [self setRewardCoinForEachLevel:kInitialRewardCoinsForEachLevel];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"maxLevel"] == nil){
        [self setMaxLevel:10];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"dataVersion"] == nil){
        [self setDataVersion:-1];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"fullScreenAds"] == nil){
        [self setFullScreenAds:NO];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"numOfSharing"] == nil){
        [self setNumOfSharing:0];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"coinsSpended"] == nil){
        [self setCoinsSpended:0];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"brag"] == nil){
        [self setBrag:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"messageShareApp"] == nil){
        [self setMessageShareApp:kInitialShareMessage];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"messageHelp"] == nil){
        [self setMessageHelp:kInitialHelpMessage];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"messageBrag"] == nil){
        [self setMessageBrag:kInitialBragMessage];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"messageRateIt"] == nil){
        [self setMessageBrag:kInitialTitleOfRating];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"didAskFriendForCurrentLevel"] == nil){
        [self setDidAskFriendForCurrentLevel:NO];
    }    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"rewardCoinForSharingApp"] == nil){
        [self setRewardCoinForSharingApp:kInitialRewardCoinsForSharingApp];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"rewardCoinForLikingPage"] == nil){
        [self setRewardCoinForLikingPage:kInitialRewardCoinsForLikingFB];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"rewardCoinForRattingApp"] == nil){
        [self setRewardCoinForRattingApp:kInitialRewardCoinsForRatingApp];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"rewardCoinForAskingFriends"] == nil){
        [self setRewardCoinForAskingFriends:kInitialRewardCoinForAskingFriends];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"priceOfRemovingLetter"] == nil){
        [self setPriceOfRemovingLetter:kInitialPriceOfRemoveLetter];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"priceOfRevealingLetter"] == nil){
        [self setPriceOfRevealingLetter:kInitialPriceOfRevealLetter];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"priceOfRevealingLeftPic"] == nil){
        [self setPriceOfRevealingLeftPic:kInitialPriceOfRevealLeftPic];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"priceOfRevealingRightPic"] == nil){
        [self setPriceOfRevealingLRightPic:kInitialPriceOfRevealRightPic];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"FBLink"] == nil){
        [self setFBLink:@"N/A"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"rateForCoin"] == nil){
        [self setRateForCoin:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"msgShareNotAvail"] == nil){
        [self setMsgSharingNotAvail:@"You already shared this app"];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"doubleCoinInWinView"] == nil){
        [self setDoubleCoinInWinView:NO];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"showAdPlayView"] == nil){
        [self setShowAdPlayView:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"showAds"] == nil){
        [self setShowAds:YES];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TimeToNextShare"] == nil){
        [self setTimeToNextShare:3600*24];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"timeBetweenUpdate"] == nil){
        [self setTimeBetweenUpdate:[NSNumber numberWithInt:60]];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"noAds"] == nil){
        [self setNoAds:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"playMusicFlag"] == nil){
        [self setMusicFlag:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"bgSoundVolume"] == nil){
        [self setBGSoundVolume:1];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"showLeftTitle"] == nil){
        [self setShowLeftTitle:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"showRightTitle"] == nil){
        [self setShowRightTitle:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"likeFanPage"] == nil){
        [self setLikeFanPage:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastFBShare"] == nil){
        [self setLastFBShare:[NSDate dateWithTimeInterval:-60*60*24 sinceDate:[NSDate date]]];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastTwitterShare"] == nil){
        [self setLastTwitterShare:[NSDate dateWithTimeInterval:-60*60*24 sinceDate:[NSDate date]]];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastSendEmail"] == nil){
        [self setLastSendEmail:[NSDate dateWithTimeInterval:-60*60*24 sinceDate:[NSDate date]]];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastSendSMS"] == nil){
        [self setLastSendSMS:[NSDate dateWithTimeInterval:-60*60*24 sinceDate:[NSDate date]]];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"indexOfRemove"] == nil){
        [self setRemoveIndex:-1];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"indexOfReveal"] == nil){
        [self setRevealIndex:-1];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"coins"]==nil) {
        [self setCoin:[coin intValue]];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"level"]==nil) {
        [self setLevel:1];
    }
    

    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"canRemoveALetter"]==nil) {
        [self setCanRemoveALetter:YES];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"canRevealALetter"]==nil) {
        [self setCanRevealALetter:YES];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"showAnswer"] == nil){
        [self setShowAnswer:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"rateUs"] == nil){
        [self setRateUs:0];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"textRateUs"] == nil){
        [self setTextRateUs:@"RATE US"];
    }
}



+ (void)reSetGlobalData
{
    [self setRemoveIndex:-1];
    [self setRevealIndex:-1];
    
    [self setShowAnswer:NO];
    [self setShowLeftTitle:NO];
    [self setShowRightTitle:NO];

    [self setCanRevealALetter:YES];
    [self setCanRemoveALetter:YES];

}

#pragma mark AlertView

+ (void)alert:(NSString *)str delegate:(id)_delegate
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:str delegate:_delegate cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
        
    });
}

#pragma mark Device Name

+ (NSString*) machineName
{
    /*
     @"i386"      on the simulator
     @"iPod1,1"   on iPod Touch
     @"iPod2,1"   on iPod Touch Second Generation
     @"iPod3,1"   on iPod Touch Third Generation
     @"iPod4,1"   on iPod Touch Fourth Generation
     @"iPhone1,1" on iPhone
     @"iPhone1,2" on iPhone 3G
     @"iPhone2,1" on iPhone 3GS
     @"iPad1,1"   on iPad
     @"iPad2,1"   on iPad 2
     @"iPad3,1"   on 3rd Generation iPad
     @"iPhone3,1" on iPhone 4
     @"iPhone4,1" on iPhone 4S
     @"iPhone5,1" on iPhone 5 (model A1428, AT&T/Canada)
     @"iPhone5,2" on iPhone 5 (model A1429, everything else)
     @"iPad3,4" on 4th Generation iPad
     @"iPad2,5" on iPad Mini
     
     */
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

#pragma mark Parse.com

+ (void)updateInstallationInfoWithObject:(PFObject *)obj andDeviceToken:(NSString *)token
{
    
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    obj[@"timeZone"] = [timeZone name];
    obj[@"deviceToken"] = token;
    obj[@"app_version"] = version;
    obj[@"ios_version"] = [[UIDevice currentDevice] systemVersion];
    obj[@"coin"] = [NSNumber numberWithInt:[CommonFunction getCoin]];
    
    obj[@"level"] = [NSNumber numberWithInt:[CommonFunction getLevel]];
    obj[@"device"] = [CommonFunction machineName];
    obj[@"FBLink"] = [CommonFunction getFBLink];
    
    obj[@"numOfSharing"] =  [NSNumber numberWithInt:[CommonFunction getNumOfSharing]];
    
    obj[@"coinsSpended"] = [NSNumber numberWithInt:[CommonFunction getCoinsSpended]];
    
    obj[@"rateUS"] = [NSNumber numberWithInt:[CommonFunction getRateUS]];
    
    obj[@"dataVersion"] = [NSNumber numberWithInt:[CommonFunction getDataVersion]];
    
    obj[@"likeFB"] = [CommonFunction getLikeFanPage] ? @"Liked" : @"Not yet";
    
    [CommonFunction setLastUpdateInfo:[NSDate date]];
//    [CommonFunction alert:[NSString stringWithFormat:@"%@",[CommonFunction getLastUpdateInfo]] delegate:nil];
    NSLog(@"last update : %@", [NSDate date]);
    [obj saveEventually];
    
}

+ (void)updateConfigurationInfo
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"app_version = %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    PFQuery *query = [PFQuery queryWithClassName:@"ConfigurationInfo" predicate:predicate];
    
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
         // shit happen
        }else
        {
            if (objects.count == 0)
            {
                // no coressponding app version
            }else
            {
                PFObject *obj = [objects firstObject];
                for (id key in [obj allKeys])
                {
                    NSString *strKey = key;
                    if ([obj objectForKey:strKey])
                    {
                        NSLog(@"object and key : %@    %@", [obj objectForKey:strKey], strKey);
                        
                        
                        if ([strKey isEqualToString:@"versionExpired"])
                        {
                            BOOL versionExpired = [[obj objectForKey:strKey] boolValue];
                            if (versionExpired)
                            {
                                
                                NSString *msg = @"New version is available on App Store. Please update now !";
                                [CommonFunction alert:msg delegate:[[UIApplication sharedApplication] delegate]];
                            }
                        }else
                        {
                            [[NSUserDefaults standardUserDefaults] setObject:[obj objectForKey:strKey] forKey:strKey];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                        }
                    }
                }
                
                // check data version
                if
                    (
                    ([CommonFunction getDataVersion] != [[obj objectForKey:@"data_version"] intValue])
                    )
                {
                    NSPredicate *predicateDataVersion = [NSPredicate predicateWithFormat:
                                                         @"version = %@", [obj objectForKey:@"data_version"]];
                    PFQuery *queryData = [PFQuery queryWithClassName:@"Data" predicate:predicateDataVersion];
                    queryData.cachePolicy = kPFCachePolicyNetworkElseCache;
                    [queryData findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        if (error)
                        {
                            // shit happen
                        }else
                        {
                            
                            
                            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,    NSUserDomainMask, YES);
                            NSString *documentsPath = [paths objectAtIndex:0];
                            documentsPath = [documentsPath stringByAppendingString:@"/"];
                            
                            
                            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
                            queue.maxConcurrentOperationCount = 4;
                            
                            NSBlockOperation *totalCompletion = [NSBlockOperation blockOperationWithBlock:^{
                                NSLog(@"finish all data migration, now update data_version");
                                [CommonFunction setDataVersion:[[obj objectForKey:@"data_version"] intValue]];
                                
                            }];
                            
                            for (PFObject *wordObj in objects)
                            {
                                NSURL *urlLeftPic = nil;
                                NSURL *urlRightPic = nil;
                                NSString *leftPicName = nil;
                                NSString *rightPicName = nil;
                                
                                if ([wordObj objectForKey:@"leftPicURL"] != nil)
                                {
                                    urlLeftPic = [[NSURL alloc] initWithString:[wordObj objectForKey:@"leftPicURL"]];
                                    leftPicName = [urlLeftPic lastPathComponent];
                                    
                                    
                                }else
                                {
                                    // get local image which named is ...
                                    if ([wordObj objectForKey:@"leftPicFileName"] != nil)
                                    {
                                        leftPicName = [wordObj objectForKey:@"leftPicFileName"];
                                    }else
                                    {
                                        // wtf !!!!!
                                    }
                                }
                                
                                if ([wordObj objectForKey:@"rightPicURL"])
                                {
                                    
                                    urlRightPic = [[NSURL alloc] initWithString:[wordObj objectForKey:@"rightPicURL"]];
                                    
                                    rightPicName = [urlRightPic lastPathComponent];
                                }else
                                {
                                    // get local image which named is ...
                                    if ([wordObj objectForKey:@"rightPicFileName"] != nil)
                                    {
                                        rightPicName = [wordObj objectForKey:@"rightPicFileName"];
                                    }else
                                    {
                                        // wtf !!!!!
                                    }
                                }
                                
                                
                                
                                NSBlockOperation *completionOperation = [NSBlockOperation blockOperationWithBlock:^{
                                    NSLog(@"finish downloading %@, now save data to local", [wordObj objectForKey:@"answer"]);
                                    NSString *leftWord = [wordObj objectForKey:@"leftword"];
                                    NSString *rightWord = [wordObj objectForKey:@"rightword"];
                                    NSString *initialString = [wordObj objectForKey:@"initialString"];
                                    NSString *answer = [wordObj objectForKey:@"answer"];
                                    NSString *leftPic = leftPicName;
                                    NSString *rightPic = rightPicName;
                                    
                                    
                                    
                                    // set level for this set
                                    int level = [[wordObj objectForKey:@"level"] intValue];
                                    
                                    if (level == -1)
                                    {
                                        level = 1;
                                        while (
                                               (![[[CommonFunction getWordInfoForLevel:level] finalWord] isEqualToString:answer])
                                               &&
                                               
                                               (level<= [CommonFunction getMaxLevel])
                                               
                                               
                                               )
                                        {
                                            level ++;
                                        }
                                    }
                                    

                                    
                                    if  (![[[CommonFunction getWordInfoForLevel:level] finalWord] isEqualToString:answer])
                                    {
                                        // can't find a level which have the same answer with this set, so this will be new max level
                                        level = [CommonFunction getMaxLevel]+1;
                                    }else
                                    {
                                        // keep it, gonna replace that level
                                    }
                                    
                                    
                                    WordInfo *info = [[WordInfo alloc] initWithUniqueLevel:level leftWord:leftWord leftImg:leftPic rightWord:rightWord rightImg:rightPic finalWord:answer initString:initialString];
                                    [CommonFunction setWordInfo:info];
                                    
                                }];
                                
                                NSBlockOperation *operationLeft = [NSBlockOperation blockOperationWithBlock:^{
                                    NSData *data = [NSData dataWithContentsOfURL:urlLeftPic];
                                    NSString *filename = [documentsPath stringByAppendingString:leftPicName];
                                    
                                    NSLog(@"begin download left pic %@",leftPicName);
                                    [data writeToFile:filename atomically:YES];
                                    NSLog(@"finish write %@ to file %@", [urlLeftPic absoluteString], filename);
                                }];
                                
                                [completionOperation addDependency:operationLeft];
                                
                                
                                
                                NSBlockOperation *operationRight = [NSBlockOperation blockOperationWithBlock:^{
                                    
                                    NSData *data = [NSData dataWithContentsOfURL:urlRightPic];
                                    NSString *filename = [documentsPath stringByAppendingString:rightPicName];
                                    
                                    NSLog(@"begin download right pic %@", rightPicName);
                                    [data writeToFile:filename atomically:YES];
                                    NSLog(@"finish write %@ to file %@", [urlRightPic absoluteString], filename);
                                }];
                                
                                [completionOperation addDependency:operationRight];
                                
                                [totalCompletion addDependency:completionOperation];
                                
                                [queue addOperations:completionOperation.dependencies waitUntilFinished:NO];
                                [queue addOperation:completionOperation];
                                
                                
                            }
                            
                            
                            [queue addOperation:totalCompletion];
                            
                            
                        }
                    }];
                }else
                {
                    NSLog(@"no data change");
                }
            }
        }
    }];
    
}

#pragma mark message sharing is not available

// if time from last sharing to present is less than timetonextshare, then user is unable to share, and this message will appear

+ (NSString *)msgSharingNotAvail
{
   return [[NSUserDefaults standardUserDefaults] stringForKey:@"msgShareNotAvail"];
}

+ (void)setMsgSharingNotAvail:(NSString *)str
{
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"msgShareNotAvail"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark Double Coin In win View

+ (BOOL)checkIfDoubleCoinInWinView
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"doubleCoinInWinView"];
}


+ (void)setDoubleCoinInWinView:(BOOL)val
{
    [[NSUserDefaults standardUserDefaults] setBool:val forKey:@"doubleCoinInWinView"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark rateforcoin
// 1. rate this app will appear in free coin options
// 2. user will get coin for rating app

+ (BOOL)checkIfRateForCoin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"rateForCoin"];
}


+ (void)setRateForCoin:(BOOL)val
{
    [[NSUserDefaults standardUserDefaults] setBool:val forKey:@"rateForCoin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark time to next share

//1. time to next share, to disable repeat sharing, set it max 99999 on parse.com

+ (double)timeToNextShare
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"TimeToNextShare"] doubleValue];
}

+ (void)setTimeToNextShare:(double)val
{
    [[NSUserDefaults standardUserDefaults] setDouble:val forKey:@"TimeToNextShare"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark show ad playview

+ (BOOL)getShowAdPlayView
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"showAdPlayView"];
}

+ (void)setShowAdPlayView:(BOOL)val
{
    [[NSUserDefaults standardUserDefaults] setBool:val forKey:@"showAdPlayView"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

#pragma mark show ads

+ (BOOL)checkIfShowAds
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"showAds"];
}

+ (void)setShowAds:(BOOL)val
{
    [[NSUserDefaults standardUserDefaults] setBool:val forKey:@"showAds"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark FBLink

+ (NSString *)getFBLink
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"FBLink"];
}

+ (void)setFBLink:(NSString *)val
{
    [[NSUserDefaults standardUserDefaults] setObject:val forKey:@"FBLink"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark Hints Price

+ (void)setPriceOfRemovingLetter:(int)val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:val] forKey:@"priceOfRemovingLetter"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getPriceOfRemovingLetter
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"priceOfRemovingLetter"] intValue];
}

+ (void)setPriceOfRevealingLetter:(int)val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:val] forKey:@"priceOfRevealingLetter"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getPriceOfRevealingLetter
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"priceOfRevealingLetter"] intValue];
}


+ (void)setPriceOfRevealingLeftPic:(int)val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:val] forKey:@"priceOfRevealingLeftPic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getPriceOfRevealingLeftPic
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"priceOfRevealingLeftPic"] intValue];
}


+ (void)setPriceOfRevealingLRightPic:(int)val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:val] forKey:@"priceOfRevealingRightPic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getPriceOfRevealingRightPic
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"priceOfRevealingRightPic"] intValue];
}

#pragma mark Reward Coin For Ratting app


+ (void)setRewardCoinForRattingApp:(int)val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:val] forKey:@"rewardCoinForRattingApp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getRewardCoinForRattingApp
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"rewardCoinForRattingApp"] intValue];
}

#pragma mark Reward Coin For liking page

+ (void)setRewardCoinForLikingPage:(int)val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:val] forKey:@"rewardCoinForLikingPage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getRewardCoinForLikingPage
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"rewardCoinForLikingPage"] intValue];
}


#pragma mark Reward Coin For sharing app

+ (void)setRewardCoinForSharingApp:(int)val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:val] forKey:@"rewardCoinForSharingApp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getRewardCoinForSharingApp
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"rewardCoinForSharingApp"] intValue];
}


#pragma mark Reward Coin For asking friend

+ (void)setRewardCoinForAskingFriends:(int)val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:val] forKey:@"rewardCoinForAskingFriends"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getRewardCoinForAskingFriends
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"rewardCoinForAskingFriends"] intValue];
}

#pragma mark Did Ask Friends For Current Level

+ (BOOL)getDidAskFriendForCurrentLevel
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"didAskFriendForCurrentLevel"];
}

+ (void)setDidAskFriendForCurrentLevel:(BOOL)val
{
    [[NSUserDefaults standardUserDefaults] setBool:val forKey:@"didAskFriendForCurrentLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark message

+ (NSString *)getMessageShareApp
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"messageShareApp"];
}

+ (void)setMessageShareApp:(NSString *)msg
{
    [[NSUserDefaults standardUserDefaults] setObject:msg forKey:@"messageShareApp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getMessageHelp
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"messageHelp"];
}

+ (void)setMessageHelp:(NSString *)msg
{
    [[NSUserDefaults standardUserDefaults] setObject:msg forKey:@"messageHelp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getMessageBrag
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"messageBrag"];
}

+ (void)setMessageBrag:(NSString *)msg
{
    [[NSUserDefaults standardUserDefaults] setObject:msg forKey:@"messageBrag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getMessageRateIt
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"messageRateIt"];
}

+ (void)setMessageRateIt:(NSString *)msg
{
    [[NSUserDefaults standardUserDefaults] setObject:msg forKey:@"messageRateIt"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark set full screen ads + brag

+ (BOOL)getFullScreenAds
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"fullScreenAds"];
}

+ (void)setFullScreenAds:(BOOL)val
{
    [[NSUserDefaults standardUserDefaults] setBool:val forKey:@"fullScreenAds"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getBrag
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"brag"];
}

+ (void)setBrag:(BOOL)val
{
    [[NSUserDefaults standardUserDefaults] setBool:val forKey:@"brag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark user analytic

+ (void)setNumOfSharing:(int)val
{
    [[NSUserDefaults standardUserDefaults] setInteger:val forKey:@"numOfSharing"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getNumOfSharing
{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"numOfSharing"];
}

+ (void)setCoinsSpended:(int)val
{
    [[NSUserDefaults standardUserDefaults] setInteger:val forKey:@"coinsSpended"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getCoinsSpended
{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"coinsSpended"];
}


+ (void)setMaxLevel:(int)level
{
    [[NSUserDefaults standardUserDefaults] setInteger:level forKey:@"maxLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getMaxLevel
{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"maxLevel"];
}

#pragma mark Datas

+ (void)setWordInfo:(WordInfo *)wordInfo
{
    NSDictionary *wordDict = [NSDictionary  dictionaryWithObjectsAndKeys:
                              wordInfo.leftWord,@"leftWord",
                              wordInfo.leftImg,@"leftImg",
                              wordInfo.rightWord,@"rightWord",
                              wordInfo.rightImg,@"rightImg",
                              wordInfo.finalWord,@"finalWord",
                              wordInfo.dummyString,@"dummyString"
                              
                              , nil];
    NSString *str = [NSString stringWithFormat:@"level_%d", wordInfo.level];
    
    if (wordInfo.level > [CommonFunction getMaxLevel])
    {
        [CommonFunction setMaxLevel:wordInfo.level];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:wordDict forKey:str];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (WordInfo *)getWordInfoForLevel:(int)level
{
    NSString *str = [NSString stringWithFormat:@"level_%d", level];
    NSDictionary *wordDict = [[NSUserDefaults standardUserDefaults] objectForKey:str];
    if (wordDict == nil)
        return nil;
    
    WordInfo *info = [[WordInfo alloc] initWithUniqueLevel:level leftWord:[wordDict objectForKey:@"leftWord"] leftImg:[wordDict objectForKey:@"leftImg"] rightWord:[wordDict objectForKey:@"rightWord"] rightImg:[wordDict objectForKey:@"rightImg"] finalWord:[wordDict objectForKey:@"finalWord"] initString:[wordDict objectForKey:@"dummyString"]];
    return info;
}

#pragma mark Reward Coin for each letter

+ (int)getRewardCoinForEachLevel
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"rewardCoinForEachLevel"] intValue];
}

+ (void)setRewardCoinForEachLevel:(int)val
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:val] forKey:@"rewardCoinForEachLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark data version

+ (int)getDataVersion
{
   return [[[NSUserDefaults standardUserDefaults] objectForKey:@"dataVersion"] intValue];
}

+ (void)setDataVersion:(int)dataVersion
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:dataVersion] forKey:@"dataVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark rated version

+ (NSString *)getRatedVersion
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ratedVersion"];
}

+ (void)setRatedVersion:(NSString *)ver
{
    [[NSUserDefaults standardUserDefaults] setObject:ver forKey:@"ratedVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark rule

+ (void)setRule:(NSString *)rule
{
    [[NSUserDefaults standardUserDefaults] setObject:rule forKey:@"Rule"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getRule
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"Rule"];
}

#pragma mark share

+ (void)shareWithImage:(UIImage *)img andMessage:(NSString *)msg withArchorPoint:(UIView *)ap inViewController:(UIViewController *)vc  completion:(void (^)(void))completion
{
    if( [UIActivityViewController class])
    {
        
        APActivityProvider *ActivityProvider = [[APActivityProvider alloc] init];
        
        NSArray *Items;
        if (img)
        {
            Items = @[ActivityProvider, img, msg];
        }else
        {
            Items = @[ActivityProvider, msg];
        }
        
        
        UIActivityViewController *aVC = [[UIActivityViewController alloc] initWithActivityItems:Items applicationActivities:nil];
        NSMutableArray *listDisableItems = [[NSMutableArray alloc] initWithObjects:UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll, UIActivityTypePostToWeibo, UIActivityTypeMessage, UIActivityTypeMail,UIActivityTypeAirDrop ,nil];
        
        
        if ([[NSDate date] compare:[[CommonFunction getLastSendEmail] dateByAddingTimeInterval:[CommonFunction timeToNextShare]]]==NSOrderedAscending)
        {
            [listDisableItems addObject:UIActivityTypeMail];
        }
        if ([[NSDate date] compare:[[CommonFunction getLastTwitterShare] dateByAddingTimeInterval:[CommonFunction timeToNextShare]]]==NSOrderedAscending)
        {
            [listDisableItems addObject:UIActivityTypePostToTwitter];
        }
        if ([[NSDate date] compare:[[CommonFunction getLastSendSMS] dateByAddingTimeInterval:[CommonFunction timeToNextShare]]]==NSOrderedAscending)
        {
            [listDisableItems addObject:UIActivityTypeMessage];
        }
        
        [aVC setExcludedActivityTypes:listDisableItems];
        
        [aVC setCompletionHandler:^(NSString *activityType, BOOL completed){
            //                    NSLog(@"activity Type : %@", activityType);
            if (completed)
            {
                
                
                SWITCH (activityType) {
                    CASE (@"com.apple.UIKit.activity.Message") {
                        [CommonFunction setLastSendSMS:[NSDate date]];
                        break;
                    }
                    CASE (@"com.apple.UIKit.activity.Mail") {
                        [CommonFunction setLastSendEmail:[NSDate date]];
                        break;
                    }
                    CASE (@"com.apple.UIKit.activity.PostToTwitter") {
                        [CommonFunction setLastTwitterShare:[NSDate date]];
                        break;
                    }
                    CASE (@"com.apple.UIKit.activity.PostToFacebook") {
                        [CommonFunction setLastFBShare:[NSDate date]];
                        break;
                    }
                    DEFAULT {
                        break;
                    }
                }
                
                int k = [CommonFunction getNumOfSharing];
                [CommonFunction setNumOfSharing:k+1];
                
                completion();
            }
        }];
        if (kCheckIfIphone)
        {
            
        }else
        {
            
            aVC.popoverPresentationController.sourceView = ap;
        }
        [vc presentViewController:aVC animated:YES completion:nil];
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"We are sorry. This feature can only available in IOS 6 or above, please upgrade IOS to get free coins" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}



@end
