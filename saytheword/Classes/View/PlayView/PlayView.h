//
//  PlayView.h
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayModel.h"
#import <QuartzCore/QuartzCore.h>
#import "AnswerView.h"
#import "TypingView.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ExplodeView.h"

#import <iAd/iAd.h>


@protocol PlayViewProtocol <NSObject>

- (void)backBtnPressFromPlayView;
- (void)showWinScreenFromPlayView;
- (void)hintBtnTapped;
- (void)coinViewTappedFromPlayView;

@end

@interface PlayView : UIView <TypingViewDelegate, AnswerViewDelegate, FBLoginViewDelegate, ADBannerViewDelegate>
{
    UILabel *coinLabel;
    UIImageView *coinImageView;
    UIView *coinView;
    NSTimer *timer;
    int hintInternal;
    UIButton *hintBtn;
    
    BOOL _bannerIsVisible;
    int yOfImages, paddingLeftImg, sizeOfImg, distanceFromImgToTitle, heightOftitle, yOfAnswerView, heightOfAnswerView, distanceFromAnswerViewToAnswerLabel, yOfTypingView,heightOfTypingView;
}
@property (nonatomic, strong) ADBannerView *adbanner;

@property (nonatomic, strong) UIView *leftView,*rightView;
@property (nonatomic, strong) UILabel *coinLabel;
@property (nonatomic, unsafe_unretained) id delegate;
@property (nonatomic, strong) PlayModel *playModel;
@property (nonatomic, strong) TypingView *typingView;
@property (nonatomic, strong) AnswerView *answerView;

- (id)initWithModel:(PlayModel *)_model;
- (int)checkNumOfRemoveableChars;
- (void)removeALetterFromController;
- (int)checkNumOfEmptyLabelInResultView;
- (int)getIndexOfRevealLabel:(int)numOfEmptyLB;
- (void)revealALetterFromController:(int)r;

- (void)deactiveTimer;

@end
