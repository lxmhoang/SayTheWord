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

@implementation CommonFunction

+ (NSURL *)getAppURL
{
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        return [NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=901409937"];
    }else
    {
        
        return [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id901409937"];
        
    }
}

+ (RootController *)getRootController{
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] getRootController];
}

+ (NSNumber *)gettimeBetweenUpdate
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"timeToNextUpdate"];
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
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"rateUs"];
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
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"rateForCoin"] == nil){
        [self setRateForCoin:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"msgShareNotAvail"] == nil){
        [self setMsgSharingNotAvail:@"You already shared this app"];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"doubleCoinInWinView"] == nil){
        [self setDoubleCoinInWinView:NO];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"showAds"] == nil){
        [self setShowAds:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TimeToNextShare"] == nil){
        [self setTimeToNextShare:3600*24*30];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"timeBetweenUpdate"] == nil){
        [self setTimeBetweenUpdate:[NSNumber numberWithInt:60]];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"noAds"] == nil){
        [self setNoAds:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"playMusicFlag"] == nil){
        [self setMusicFlag:YES];
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
        [self setLevel:7];
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
    
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    obj[@"timeZone"] = [timeZone name];
    obj[@"deviceToken"] = token;
    obj[@"app_version"] = version;
    obj[@"ios_version"] = [[UIDevice currentDevice] systemVersion];
    obj[@"coin"] = [NSNumber numberWithInt:[CommonFunction getCoin]];
    
    obj[@"level"] = [NSNumber numberWithInt:[CommonFunction getLevel]];
    obj[@"device"] = [CommonFunction machineName];
    obj[@"FBLink"] = [CommonFunction getFBLink];
    
    [CommonFunction setLastUpdateInfo:[NSDate date]];
//    [CommonFunction alert:[NSString stringWithFormat:@"%@",[CommonFunction getLastUpdateInfo]] delegate:nil];
    NSLog(@"last update : %@", [NSDate date]);
    [obj saveEventually];
    
}

+ (void)updateConfigurationInfo
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"app_version = %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
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
                    [[NSUserDefaults standardUserDefaults] setObject:[obj objectForKey:strKey] forKey:strKey];
                    [[NSUserDefaults standardUserDefaults] synchronize];
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
    [[NSUserDefaults standardUserDefaults] setDouble:val forKey:@"dirty_sharing"];
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

@end
