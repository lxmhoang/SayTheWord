//
//  CommonFunction.h
//  saytheword
//
//  Created by Hoang Le on 6/23/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//
//iap

#define kTagOfCopyAnswerView 669

#define kRewardCoinsForRatingApp 300

#define kRewardCoinsForLikingFB 300

#define kRewardCoinsForSharingApp 99

#define kNavBarImg @"nav_nau.png"
#define kProductIDOf200  @"com.lxmhoang.saytheword.iap.200coins"
#define kProductIDOf420  @"com.lxmhoang.saytheword.iap.420coins"
#define kProductIDOf1085  @"com.lxmhoang.saytheword.iap.1085coins"
#define kProductIDOf2350  @"com.lxmhoang.saytheword.iap.2350coins"
#define kProductIDOf7150  @"com.lxmhoang.saytheword.iap.7150coins"
//#define kProductIDOf50000  @"com.lxmhoang.saytheword.iap.50000coins"

#define kHeightOfScreen [ [ UIScreen mainScreen ] bounds ].size.height
#define kWidthOfScreen 320
#define kTimeToPresentVC 0.5
#define kInitialCoin 100

#define kRandomNumber 33

// Animate betweenVC

#define kShortDisTanceOf2View 50

//PlayView
//#define kTagOfCoinLabel 80
#define kYOfImages 70
#define kYOfAnswerView 260
#define kYOfTyppingView 360
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

#define kWidthOfCharInAnswerView 30
#define kDistanceBwCharsInAnswerView 5
#define kTagOfEraseIcon 9

// store controller
#define kHeightOfTopBarPopUpIAP 60
#define kHeightOfRowStoreItem 56

//time to share again

#define kTimeToNextShare 150

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

+ (RootController *)getRootController;

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


+ (void)setCanRemoveALetter:(BOOL)_val;
+ (BOOL)getCanRemoveALetter;

+ (void)setCanRevealALetter:(BOOL)_val;
+ (BOOL)getCanRevealALetter;


+ (void)createGlobalVariable;
+ (void)reSetGlobalData;

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

+ (void)setRateUs:(BOOL)_val;
+ (BOOL)getRateUS;

+ (void)setTextRateUs:(NSString *)_val;
+ (NSString *)getTextRateUs;

@end
