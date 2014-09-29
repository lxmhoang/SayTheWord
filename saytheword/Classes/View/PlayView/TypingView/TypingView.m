//
//  TypingView.m
//  saytheword
//
//  Created by Hoang Le on 6/16/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "TypingView.h"



@implementation TypingView

@synthesize playModel, delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andModel:(PlayModel *)_playModel
{
    self = [super initWithFrame:frame];
    if (self)
    {
        yOfChar = kCheckIfIphone ? 15:30;
        padding = kCheckIfIphone ? 12 : 76;
        sizeOfChar = kCheckIfIphone ? 48 : 96;
        dstBetweenChars = kCheckIfIphone ? 2 : 8;
        playModel = _playModel;
//        [self setBackgroundColor:[UIColor blackColor]];
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//        self.alpha = 0.3;
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews
{
    int bp=padding;
    


    bp+=sizeOfChar+dstBetweenChars;
    
    for (int i=0;i<5;i++)
    {
        InputButtonView *btn = [[InputButtonView alloc]initWithText:[playModel.wordInfo.dummyString substringWithRange:NSMakeRange(i, 1)] andFrame:CGRectMake(bp, yOfChar, sizeOfChar, sizeOfChar) andTag:i+kRandomNumber];
        [btn setTag:(i+kRandomNumber)];
        UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickCharPress:)];
        [btn addGestureRecognizer:_tap];
        
        [self addSubview:btn];
        bp+=sizeOfChar+dstBetweenChars;
        if (i==[CommonFunction getRemoveIndex])
        {
            [btn removeFromSuperview];
        }
    }
    bp=padding;
    for (int i=5;i<11;i++)
    {
        InputButtonView *btn = [[InputButtonView alloc]initWithText:[playModel.wordInfo.dummyString substringWithRange:NSMakeRange(i, 1)] andFrame:CGRectMake(bp, yOfChar+sizeOfChar+dstBetweenChars, sizeOfChar, sizeOfChar) andTag:i+kRandomNumber];
        
        UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickCharPress:)];
        [btn addGestureRecognizer:_tap];
        [btn setTag:(i+kRandomNumber)];
        
        [self addSubview:btn];
        bp+=sizeOfChar+dstBetweenChars;
        if (i==[CommonFunction getRemoveIndex])
        {
            [btn removeFromSuperview];
        }
        
    }
}

#pragma mark Gesture handle

- (void)pickCharPress:(UITapGestureRecognizer *)_sender
{
    [_sender.view setHidden:YES];
    InputButtonView *tappedView = (InputButtonView *)_sender.view;
    [delegate pickCharPress:tappedView.lb.text];
}


#pragma mark method from Playview

- (void)returnTextFromPlayView:(NSString *)_text
{
    for (int i=0;i<playModel.wordInfo.dummyString.length;i++)
    {
        InputButtonView *tmpButton = (InputButtonView *)[self viewWithTag:(i+kRandomNumber)];
        if ([tmpButton isHidden]&&([tmpButton.lb.text isEqualToString:_text]))
        {
            [tmpButton setHidden:NO];
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
