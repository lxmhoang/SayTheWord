//
//  CommonFunction.h
//  saytheword
//
//  Created by Hoang Le on 6/23/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//
//iap

@class PFObject, WordInfo;

/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



#define kTitleOfFacebookLike @"LIKE US"
#define kTitleOfSharing @"SHARE IT"
#define kInitialTitleOfRating @"RATE IT"

#define kInitialHelpMessage @"Help me guess this word by combining first syllabel of left pic with last syllabel of right pic. E.g: STUdio+presiDENT = STUDENT. Download it FREE at http://goo.gl/GgWVAL "


#define kInitialShareMessage @"Help me guess this word by combining first syllabel of left pic with last syllabel of right pic. E.g: STUdio+presiDENT = STUDENT. Download it FREE at http://goo.gl/GgWVAL "


#define kInitialBragMessage @"I'm an expert at #Say2picsGuessTheWord. Try it FREE http://goo.gl/GgWVAL "

#define kTagOfCopyAnswerView 669

#define kMsgThankForRating @"Thank you for rating"

#define kInitialRewardCoinsForRatingApp 70

#define kInitialRewardCoinsForLikingFB 70

#define kInitialRewardCoinsForSharingApp 15

#define kInitialRewardCoinForAskingFriends 10

#define kInitialRewardCoinsForEachLevel 2

#define kNavBarImg @"nav_nau.png"
#define kProductIDOf200  @"new.com.lxmhoang.say2picsguesstheword.iap.200coins"
#define kProductIDOf420  @"new.com.lxmhoang.say2picsguesstheword.iap.420coins"
#define kProductIDOf1100  @"new.com.lxmhoang.say2picsguesstheword.iap.1100coins"
#define kProductIDOf2400  @"new.com.lxmhoang.say2picsguesstheword.iap.2400coins"
#define kProductIDOf7800  @"new.com.lxmhoang.say2picsguesstheword.iap.7800coins"
//#define kProductIDOf50000  @"com.lxmhoang.saytheword.iap.50000coins"

#define kHeightOfScreen [ [ UIScreen mainScreen ] bounds ].size.height
#define kWidthOfScreen [ [ UIScreen mainScreen ] bounds ].size.width
#define kHeightOfNavigationBar (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) ? 44 : 64
#define kCheckIfIphone (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
#define kTimeToPresentVC 0.5
#define kInitialCoin 100

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

#define kInitialPriceOfRemoveLetter 10
#define kInitialPriceOfRevealLetter 35
#define kInitialPriceOfRevealLeftPic 70
#define kInitialPriceOfRevealRightPic 70



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


@interface CommonFunction : NSObject

+ (UIImage *)getScreenShot;

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
+ (void)playLetterPickSound;
+ (void)playBtnClickSound;


+ (void)playSuccessSound;
+ (void)playSingleCoinSound;
+ (void)playManyCoinsSound;
+ (void)playSweepSound;

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

+ (BOOL)getShowAdPlayView;
+ (void)setShowAdPlayView:(BOOL)val;

+ (BOOL)checkIfShowAds;
+ (void)setShowAds:(BOOL)val;

+ (NSString *)getFBLink;
+ (void)setFBLink:(NSString *)str;

+ (int)getPriceOfRemovingLetter;
+ (void)setPriceOfRemovingLetter:(int)val;

+ (int)getPriceOfRevealingLetter;
+ (void)setPriceOfRevealingLetter:(int)val;

+ (int)getPriceOfRevealingLeftPic;
+ (void)setPriceOfRevealingLeftPic:(int)val;

+ (int)getPriceOfRevealingRightPic;
+ (void)setPriceOfRevealingLRightPic:(int)val;

#pragma mark reward points

+ (int)getRewardCoinForRattingApp;
+ (void)setRewardCoinForRattingApp:(int)val;

+ (int)getRewardCoinForLikingPage;
+ (void)setRewardCoinForLikingPage:(int)val;

+ (int)getRewardCoinForSharingApp;
+ (void)setRewardCoinForSharingApp:(int)val;

+ (int)getRewardCoinForAskingFriends;
+ (void)setRewardCoinForAskingFriends:(int)val;


#pragma mark did ask friend for current level

+ (BOOL)getDidAskFriendForCurrentLevel;
+ (void)setDidAskFriendForCurrentLevel:(BOOL)val;

#pragma mark sharing app

+ (void)shareWithImage:(UIImage *)img andMessage:(NSString *)msg withArchorPoint:(UIView *)ap inViewController:(UIViewController *)vc completion:(void (^)(void))completion;

#pragma mark message share app

+ (NSString *)getMessageShareApp;
+ (void)setMessageShareApp:(NSString *)msg;

#pragma mark message help

+ (NSString *)getMessageHelp;
+ (void)setMessageHelp:(NSString *)msg;

#pragma mark message brag

+ (NSString *)getMessageBrag;
+ (void)setMessageBrag:(NSString *)msg;

#pragma mark set full screen ads + brag

+ (BOOL)getFullScreenAds;
+ (void)setFullScreenAds:(BOOL)val;

+ (BOOL)getBrag;
+ (void)setBrag:(BOOL)val;

#pragma mark message rate it

+ (NSString *)getMessageRateIt;
+ (void)setMessageRateIt:(NSString *)val;

#pragma mark user analytic

+ (int)getCoinsSpended;
+ (void)setCoinsSpended:(int)val;

+ (int)getNumOfSharing;
+ (void)setNumOfSharing:(int)val;

#pragma mark Data

+ (void)setWordInfo:(WordInfo *)wordInfo;
+ (WordInfo *)getWordInfoForLevel:(int)level;

#pragma mark Reward Coin for each letter

+ (int)getRewardCoinForEachLevel;

+ (void)setRewardCoinForEachLevel:(int)val;

#pragma mark data version

+ (void)setDataVersion:(int)dataVersion;
+ (int)getDataVersion;

#pragma mark Rated Version
+ (void)setRatedVersion:(NSString *)ver;
+ (NSString *)getRatedVersion;

#pragma mark rule

+ (void)setRule:(NSString *)rule;
+ (NSString *)getRule;

#pragma mark max level

+ (void)setMaxLevel:(int)level;
+ (int)getMaxLevel;

@end
