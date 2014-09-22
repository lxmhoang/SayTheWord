//
//  HintView.m
//  1word2pics
//
//  Created by Hoang le on 4/5/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import "HintsView.h"

@implementation HintsView
@synthesize delegate;

- (void)removeLetter:(UITapGestureRecognizer *)_sender
{
    [delegate removeALetterFromHintsView];
}

- (void)revealLetter:(UITapGestureRecognizer *)_sender
{
    [delegate revealALetterFromHintsView];
}

- (void)showLeftTitle:(UITapGestureRecognizer *)_sender
{
    [delegate revealLeftWordFromHintsView];
}

- (void)showRightTitle:(UITapGestureRecognizer *)_sender
{
    [delegate revealRightWordFromHintsView];
}

- (void)showAnswer:(UITapGestureRecognizer *)_sender
{
    [delegate revealAnswerWordFromHintsView];
}

- (void)createSmallViews
{
    UIView *removeLetterView = [[UIView alloc]initWithFrame:CGRectMake(3, 24, 27, 30)];
    [removeLetterView setBackgroundColor:[UIColor redColor]];
    if (![CommonFunction getCanRemoveALetter]){
        removeLetterView.alpha = 0.5;
    }else{
        UITapGestureRecognizer *_tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeLetter:)];
        [removeLetterView addGestureRecognizer:_tap1];
        [_tap1 release];
    }
    [bigView addSubview:removeLetterView];
    [removeLetterView release];
    
    UIView *showLetterView = [[UIView alloc]initWithFrame:CGRectMake(31, 24, 28 , 30)];
    [showLetterView setBackgroundColor:[UIColor redColor]];
    if (![CommonFunction getCanRevealALetter]){
        showLetterView.alpha = 0.5;
    }else{
        UITapGestureRecognizer *_tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(revealLetter:)];
        [showLetterView addGestureRecognizer:_tap2];
        [_tap2 release];
    }

    [bigView addSubview:showLetterView];
    [showLetterView release];
    
    UIView *showLeftTitle = [[UIView alloc]initWithFrame:CGRectMake(60, 24, 27 , 30)];
    [showLeftTitle setBackgroundColor:[UIColor redColor]];
    if ([CommonFunction getShowLeftTitle]){
        showLeftTitle.alpha = 0.5;
    }else{
        UITapGestureRecognizer *_tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showLeftTitle:)];
        [showLeftTitle addGestureRecognizer:_tap3];
        [_tap3 release];
    }

    [bigView addSubview:showLeftTitle];
    [showLeftTitle release];
    
    UIView *showRightTitle = [[UIView alloc]initWithFrame:CGRectMake(3, 64, 27 , 30)];
    [showRightTitle setBackgroundColor:[UIColor redColor]];
    if ([CommonFunction getShowRightTitle]){
        showRightTitle.alpha = 0.5;
    }else{
        UITapGestureRecognizer *_tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showRightTitle:)];
        [showRightTitle addGestureRecognizer:_tap4];
        [_tap4 release];
    }
    
    [bigView addSubview:showRightTitle];
    [showRightTitle release];
    
//    UIView *showAnswer = [[UIView alloc]initWithFrame:CGRectMake(31, 64, 27 , 30)];
//    [showAnswer setBackgroundColor:[UIColor redColor]];
//    if ([CommonFunction getShowAnswer]){
//        showAnswer.alpha = 0.5;
//    }else{
//        UITapGestureRecognizer *_tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAnswer:)];
//        [showAnswer addGestureRecognizer:_tap5];
//        [_tap5 release];
//    }
//    
//    [bigView addSubview:showAnswer];
//    [showAnswer release];




}

- (void)createSubViews
{
    CGRect frameHintView;
    if( IS_IPHONE_5 )
    {
        frameHintView =  CGRectMake(115, 200, 90, 100);
    }
    else
    {
//        frameHintView =  CGRectMake(20, 50, 280, 400);
        frameHintView =  CGRectMake(115, 200, 90, 100);
    }
    bigView = [[UIView alloc]initWithFrame:frameHintView];
    [bigView setBackgroundColor:[UIColor yellowColor]];
    
    [self createSmallViews];
    

    [self addSubview:bigView];
    [bigView release];
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        hintString = [[NSUserDefaults standardUserDefaults] stringForKey:@"hintString"];
        // Initialization code
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];

        
        [self createSubViews];
    }
    return self;
}

- (void)closeBigView:(UITapGestureRecognizer *)_sender
{
    NSLog(@"Tap ....");
    [self removeFromSuperview];
}

- (void)bloat
{
//    return;
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
                [bigView setTransform:CGAffineTransformMakeScale(3.4, 3.4)];
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            [bigView setTransform:CGAffineTransformMakeScale(3.0, 3.0)];
        } completion:^(BOOL finished) {
            UIImageView *closeIcon = [[UIImageView alloc]initWithFrame:CGRectMake(bigView.frame.origin.x-12, bigView.frame.origin.y-12, 32, 32)];
            [closeIcon setImage:[UIImage imageNamed:@"Close-icon.png"]];
            closeIcon.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeBigView:)];
            [closeIcon addGestureRecognizer:_tap];
            [_tap release];
            [self addSubview:closeIcon];
            [closeIcon release];
        }];
        

    }
    ];
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
