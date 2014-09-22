//
//  CommonFunction.m
//  saytheword
//
//  Created by Hoang Le on 6/23/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "CommonFunction.h"

@implementation CommonFunction

+ (RootController *)getRootController{
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] getRootController];
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

+ (void)setRateUs:(BOOL)_val
{
    [[NSUserDefaults standardUserDefaults] setBool:_val forKey:@"rateUs"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getRateUS
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"rateUs"];
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
        [self setRateUs:NO];
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

@end
