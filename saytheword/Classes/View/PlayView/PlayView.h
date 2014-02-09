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


@protocol PlayViewProtocol <NSObject>

- (void)backBtnPressFromPlayView;
- (void)showWinScreenFromPlayView;
- (void)hintBtnTapped;
- (void)coinViewTappedFromPlayView;

@end

@interface PlayView : UIView <TypingViewDelegate, AnswerViewDelegate, FBLoginViewDelegate>
{
    UILabel *coinLabel;
    UIImageView *coinImageView;
    UIView *coinView;
}

@property (nonatomic, retain) UILabel *coinLabel;
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) PlayModel *playModel;
@property (nonatomic, retain) TypingView *typingView;
@property (nonatomic, retain) AnswerView *answerView;

- (id)initWithModel:(PlayModel *)_model;
- (int)checkNumOfRemoveableChars;
- (void)removeALetterFromController;
- (int)checkNumOfEmptyLabelInResultView;
- (int)getIndexOfRevealLabel:(int)numOfEmptyLB;
- (void)revealALetterFromController:(int)r;

@end
