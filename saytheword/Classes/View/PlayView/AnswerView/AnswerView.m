//
//  AnswerView.m
//  saytheword
//
//  Created by Hoang Le on 6/16/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "AnswerView.h"

@implementation AnswerView
@synthesize playModel, delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)_frame andModel:(PlayModel *)_model
{
    self = [super initWithFrame:_frame];
    if (self)
    {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        playModel = [_model retain];
        [self createSubViews];
        index = 0;
    }
    return self;
}

- (void)createSubViews
{
    float length = (playModel.wordInfo.finalWord.length+0)*(kWidthOfCharInAnswerView+kDistanceBwCharsInAnswerView)-kDistanceBwCharsInAnswerView;
    leftPoint = (320-length)/2;
    float moc = leftPoint;
    for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
    {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(moc, 45, kWidthOfCharInAnswerView, 3)];
        [line setTag:i+kRandomNumber*2];
        [line setBackgroundColor:[UIColor whiteColor]];
        if (i==0)
            [line setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:line];
        [line release];
        
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(moc+14, 29, 2, 2)];
        [lb setFont:[UIFont fontWithName:@"Arial-BoldMT" size:25]];
        [lb setTextAlignment:NSTextAlignmentCenter];
        [lb setText:@""];
        [lb setTag:i+kRandomNumber];
        [lb setBackgroundColor:[UIColor clearColor]];
        [lb setTextColor:[UIColor whiteColor]];
        [lb setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabel:)];
        [lb addGestureRecognizer:_tap];
        [_tap release];
        
        
        [self addSubview:lb];
        [lb release];
        
        moc+=kWidthOfCharInAnswerView+kDistanceBwCharsInAnswerView;
    }
    
    UIImageView *eraseIcon = [[UIImageView alloc]initWithFrame:CGRectMake(moc, 15, kWidthOfCharInAnswerView, kWidthOfCharInAnswerView)];
    eraseIcon.userInteractionEnabled = YES;
    [eraseIcon setImage:[UIImage imageNamed:@"clear.png"]];
    [eraseIcon setTag:kTagOfEraseIcon];
    
    UITapGestureRecognizer *clearTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeAllText)];
    [eraseIcon addGestureRecognizer:clearTap];
    [clearTap release];
    
    [self addSubview:eraseIcon];
    [eraseIcon release];
    
}

- (void)setNewChar:(NSString *)_newChar
{
    UILabel *indexLb = (UILabel *)[self viewWithTag:(index+kRandomNumber)];
    [indexLb setText:_newChar];

    
//    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [indexLb setFrame:CGRectMake(leftPoint+index*(kWidthOfCharInAnswerView+kDistanceBwCharsInAnswerView),15, kWidthOfCharInAnswerView, kWidthOfCharInAnswerView)];
        indexLb.alpha = 1;
        
    } completion:^(BOOL finished) {
//        [[UIApplication sharedApplication] endIgnoringInteractionEvents];

    }];
    //*****************************************************************************************
    // check if full
    //*****************************************************************************************
    BOOL check = YES;
    for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
    {
        UILabel *tmpLB = (UILabel *)[self viewWithTag:kRandomNumber+i];
        if ([tmpLB.text isEqualToString:@""])
        {
            check = NO;
            break;
        }
    }
    if (check){
        [delegate answerViewFilled];
    }
    
    //*****************************************************************************************
    // set new index
    //*****************************************************************************************
    int newIndex=0;
    
    while (newIndex<playModel.wordInfo.finalWord.length) {
        UILabel *tmpLabel = (UILabel *)[self viewWithTag:(newIndex+kRandomNumber)];
        if ([tmpLabel.text isEqualToString:@""])
            break;
        newIndex++;
    }
    
    if (newIndex<playModel.wordInfo.finalWord.length)
    {
        [self setNewIndex:newIndex];
    }

//    if (newIndex>=playModel.wordInfo.finalWord.length){
//        
//    }
    
    
}

- (void)setNewIndex:(int)_newIndex
{
    [[self viewWithTag:(index+kRandomNumber*2)] setBackgroundColor:[UIColor whiteColor]];
    index = _newIndex;
    [[self viewWithTag:(index+kRandomNumber*2)] setBackgroundColor:[UIColor blackColor]];
}

- (BOOL)ifAnswerIsCorrect
{
    NSString *answer = @"";
    for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
    {
        UILabel *indexLb = (UILabel *)[self viewWithTag:(i+kRandomNumber)];
        answer = [answer stringByAppendingString:indexLb.text];
        
    }
    if ([answer isEqualToString:[playModel.wordInfo.finalWord uppercaseString]])
    {

        return YES;
    }
    else
        return NO;
}

- (void)flipChar:(int)initTag
{

    __block int tagView = kRandomNumber+initTag;
    
    [UIView animateWithDuration:0.3 delay:initTag*0.06 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [self viewWithTag:tagView].layer.transform = CATransform3DMakeRotation(M_PI_2, 0.0, 1.0, 0.0);
        
    } completion:^(BOOL finished) {
        UILabel *lb = (UILabel *)[self viewWithTag:tagView];
        [lb setTextColor:[UIColor yellowColor]];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self viewWithTag:tagView].layer.transform = CATransform3DMakeRotation(M_PI_2*4,0.0,1.0,0.0); //flip halfway
        } completion:^(BOOL finished) {
            if (tagView == kRandomNumber + playModel.wordInfo.finalWord.length-1)
            {
                NSLog(@"tag View : %d", tagView);
                [delegate winEventFromAnswerView];
            }

        }];
        

    }];
}

- (void)winEvent
{
    [[self viewWithTag:kTagOfEraseIcon] removeFromSuperview];
    for (int i=0;i<playModel.wordInfo.finalWord.length;i++){
        [self flipChar:i];
    }
//    [self flipChar:0];
}

#pragma mark answer is wrong

- (void)setTextToRed
{
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
    {
        UILabel *indexLb = (UILabel *)[self viewWithTag:(i+kRandomNumber)];
        [indexLb setTextColor:[UIColor redColor]];        
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2];
        for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
        {
            UILabel *tmpLB = (UILabel *)[self viewWithTag:(kRandomNumber+i)];
//            [tmpLB setTextColor:[UIColor whiteColor]];
            tmpLB.alpha = 0;
        }
    } completion:^(BOOL finished) {
       for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
       {
            UILabel *tmpLB = (UILabel *)[self viewWithTag:(kRandomNumber+i)];
//            [tmpLB setTextColor:[UIColor redColor]];
            tmpLB.alpha = 1;
        }
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
    }];
    

}

#pragma mark User Interactions

- (void)removeAllText
{
//    for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
//    {
//        UILabel *indexLb = (UILabel *)[self viewWithTag:(i+kRandomNumber)];
//        [indexLb setFrame:CGRectMake(leftPoint+i*(kWidthOfCharInAnswerView+kDistanceBwCharsInAnswerView)+14,15+14, 2, 2)];
//        indexLb.text = @"";
//        [indexLb setTextColor:[UIColor whiteColor]];
//    }
//    [self setNewIndex:0];
    for(int i=0;i<playModel.wordInfo.finalWord.length;i++)
    {
         UILabel *indexLb = (UILabel *)[self viewWithTag:(i+kRandomNumber)];
        [indexLb setTextColor:[UIColor whiteColor]];
        // tru truong hop label co duoc do reveal
        if ([indexLb.gestureRecognizers count]>0)
            [self tapLabel:[indexLb.gestureRecognizers lastObject]];
    }
}

#pragma mark Gesture handle

- (void)tapLabel:(UITapGestureRecognizer *)_sender
{
    UILabel *tappedLabel = (UILabel *)_sender.view;
    if ([tappedLabel.text isEqualToString:@""])
        return;
    if (index>tappedLabel.tag-kRandomNumber)
    {
        [self setNewIndex:tappedLabel.tag-kRandomNumber];
    }
    [delegate tapToTextFromAnswerView:tappedLabel.text];
    CGRect oldFrame = tappedLabel.frame;
    [tappedLabel setFrame:CGRectMake(oldFrame.origin.x+14, oldFrame.origin.y+14, 2, 2)];
    [tappedLabel setText:@""];
    
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
