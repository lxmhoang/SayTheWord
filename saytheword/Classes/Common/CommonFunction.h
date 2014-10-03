//
//  CommonFunction.h
//  saytheword
//
//  Created by Hoang Le on 6/23/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//
//iap

@class PFObject;

/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



#define kTitleOfFacebookLike @"LIKE US"
#define kTitleOfSharing @"SHARE THE APP"
#define kTitleOfRating @"RATE IT"

#define kTagOfCopyAnswerView 669

#define kMsgThankForRating @"Thank you for rating"

#define kRewardCoinsForRatingApp 70

#define kRewardCoinsForLikingFB 70

#define kRewardCoinsForSharingApp 15

#define kRewardCoinsForEachLetter 3

#define kNavBarImg @"nav_nau.png"
#define kProductIDOf200  @"com.lxmhoang.sayitloud.iap.200coins"
#define kProductIDOf420  @"com.lxmhoang.sayitloud.iap.420coins"
#define kProductIDOf1100  @"com.lxmhoang.sayitloud.iap.1100coins"
#define kProductIDOf2400  @"com.lxmhoang.sayitloud.iap.2400coins"
#define kProductIDOf7800  @"com.lxmhoang.sayitloud.iap.7800coins"
//#define kProductIDOf50000  @"com.lxmhoang.saytheword.iap.50000coins"

#define kHeightOfScreen [ [ UIScreen mainScreen ] bounds ].size.height
#define kWidthOfScreen [ [ UIScreen mainScreen ] bounds ].size.width
#define kHeightOfNavigationBar (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) ? 44 : 64
#define kCheckIfIphone (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
#define kTimeToPresentVC 0.5
#define kInitialCoin 10000

#define kRandomNumber 33

// Animate betweenVC

#define kShortDisTanceOf2View 50

//PlayView
//#define kTagOfCoinLabel 80



#define kTagOfHintView 454
#define kTagOfHintButton 654


#define kTagOfNewView 11
#define kTagOfDarkView 12

#define kTagOfLeftTitle 61
#define kTagOfRightTitle 62
#define kTagOfAnswerTitle 63

#define kTagOfLeftView 71
#define kTagOfRightView 72


// AnswerView

#define kTagOfEraseIcon 9

// store controller
#define kHeightOfTopBarPopUpIAP 60
#define kHeightOfRowStoreItem 56


//prices of products

#define kPriceOfRemoveLetter 10
#define kPriceOfRevealLetter 35
#define kPriceOfLeftTitle 70
#define kPriceOfRightTitle 70
#define kPriceOfAnswerTitle 150



// check Model

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//#if IS_IPHONE_5
//#define kFrameHintView  CGRectMake(20,70,280,400) 
//#else
//#define kFrameHintView  CGRectMake(20,40,280,400)
//#endif

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>


@interface CommonFunction : NSObject

+ (NSURL *)getAppURL;

+ (RootController *)getRootController;

+ (NSNumber *)gettimeBetweenUpdate;
+ (void)setTimeBetweenUpdate:(NSNumber*)num;

+ (BOOL)checkNoAds;
+ (void)setNoAds:(BOOL)noAds;

+ (BOOL)checkPlayMusic;
+ (void)setMusicFlag:(BOOL)flag;

+ (BOOL)checkFBLogin;

+ (BOOL)getLikeFanPage;
+ (void)setLikeFanPage:(BOOL)_value;

+ (int)getRemoveIndex;
+ (void)setRemoveIndex:(int)_val;

+ (int)getRevealIndex;
+ (void)setRevealIndex:(int)_val;

+ (int)getLevel;
+ (void)setLevel:(int)_val;

+ (int)getCoin;
+ (void)setCoin:(int)_val;

+ (float)getBGSoundVolume;
+ (void)setBGSoundVolume:(float)vol;

+ (void)playBGSound;
+ (void)stopBGSound;

+ (void)playFireworkSound;


+ (void)setCanRemoveALetter:(BOOL)_val;
+ (BOOL)getCanRemoveALetter;

+ (void)setCanRevealALetter:(BOOL)_val;
+ (BOOL)getCanRevealALetter;


+ (void)createGlobalVariable;
+ (void)reSetGlobalData;

+ (void)setLastUpdateInfo:(NSDate *)_val;
+ (NSDate *)getLastUpdateInfo;

+ (void)setLastSendEmail:(NSDate *)_val;
+ (NSDate *)getLastSendEmail;

+ (void)setLastSendSMS:(NSDate *)_val;
+ (NSDate *)getLastSendSMS;

+ (void)setLastFBShare:(NSDate *)_val;
+ (NSDate *)getLastFBShare;

+ (void)setLastTwitterShare:(NSDate *)_val;
+ (NSDate *)getLastTwitterShare;

+ (void)setShowLeftTitle:(BOOL)_val;
+ (BOOL)getShowLeftTitle;

+ (void)setShowRightTitle:(BOOL)_val;
+ (BOOL)getShowRightTitle;

+ (void)setShowAnswer:(BOOL)_val;
+ (BOOL)getShowAnswer;

+ (void)setRateUs:(int)_val;
+ (int)getRateUS;

+ (void)setTextRateUs:(NSString *)_val;
+ (NSString *)getTextRateUs;

+ (void)alert:(NSString *)str delegate:(id)delegate;

+ (NSString *)machineName;

+ (void)updateInstallationInfoWithObject:(PFObject *)obj andDeviceToken:(NSString *)token;

+ (void)updateConfigurationInfo;

+ (NSString *)msgSharingNotAvail;

+ (void)setMsgSharingNotAvail:(NSString *)str;

+ (BOOL)checkIfDoubleCoinInWinView;

+ (void)setDoubleCoinInWinView:(BOOL)val;

+ (BOOL)checkIfRateForCoin;
+ (void)setRateForCoin:(BOOL)val;

+ (double)timeToNextShare;
+ (void)setTimeToNextShare:(double)val;

+ (BOOL)checkIfShowAds;
+ (void)setShowAds:(BOOL)val;

+ (NSString *)getFBLink;
+ (void)setFBLink:(NSString *)str;

@end
