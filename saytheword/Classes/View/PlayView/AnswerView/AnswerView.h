//
//  AnswerView.h
//  saytheword
//
//  Created by Hoang Le on 6/16/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayModel.h"
#import <QuartzCore/QuartzCore.h>

@protocol AnswerViewDelegate <NSObject>

- (void)winEventFromAnswerView;
- (void)answerViewFilled;
- (void)tapToTextFromAnswerView:(NSString *)_text;

@end

@interface AnswerView : UIView
{
    int index, distanceBwChars, widthOfChar, yOfLine, thickOfLine, yOfChar;
    float leftPoint;
}

@property (nonatomic, strong) PlayModel *playModel;
@property (nonatomic, unsafe_unretained) id delegate;

- (id)initWithFrame:(CGRect)_frame andModel:(PlayModel *)_model;
- (void)setNewChar:(NSString *)_newChar;
- (BOOL)ifAnswerIsCorrect;
- (void)setTextToRed;
- (void)removeAllText;
- (void)winEvent;
- (void)setNewIndex:(int)_newIndex;

@end
