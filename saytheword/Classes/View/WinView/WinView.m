//
//  WinView.m
//  saytheword
//
//  Created by Hoang Le on 6/21/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "WinView.h"

@implementation WinView

@synthesize playModel, delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {


    }
    return self;
}

- (id)initWithModel:(PlayModel *)_playModel
{
    self = [super init];
    if (self)
    {
        tapped = NO;
        playModel = [_playModel retain];
    }
    [self setFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
    [self createSubViews];
    return self;
}

- (void)createSubViews
{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [btn setTag:111];
//    [btn setFrame:CGRectMake(60, 80, 200, 80)];
//    [btn addTarget:self action:@selector(move) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self addSubview:btn];
    
    [NSTimer scheduledTimerWithTimeInterval:kTimeToPresentVC-1 target:self selector:@selector(move) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:kTimeToPresentVC target:self selector:@selector(addTransView) userInfo:nil repeats:NO];
    
}

- (void)addTransView
{

    UIView *transView = [[UIView alloc] initWithFrame:self.bounds];
    [transView setBackgroundColor:[UIColor clearColor]];
    
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToNextLevel:)];
    [transView addGestureRecognizer:_tap];
    [_tap release];
    
    [self addSubview:transView];
    [transView release];
    
    RootController *rootController = (RootController *)[CommonFunction getRootController];
    
    AnswerView *aV = (AnswerView *)[[rootController.view viewWithTag:kTagOfCopyAnswerView] retain];    
    UIView *leftViewTitle = [[rootController.view viewWithTag:kTagOfLeftTitle] retain];
    UIView *rightViewTitle = [[rootController.view viewWithTag:kTagOfRightTitle] retain];
    
    [self addSubview:leftViewTitle];
    [self sendSubviewToBack:leftViewTitle];
    [self addSubview:rightViewTitle];
    [self sendSubviewToBack:rightViewTitle];
    [self addSubview:aV];
    [self sendSubviewToBack:aV];
    
    


    
    [leftViewTitle release];
    [rightViewTitle release];

    
//    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    animation.fromValue = [NSNumber numberWithFloat:0.0f];
//    animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
//    animation.duration = 3.0f;
//    animation.repeatCount = HUGE_VAL;
//    [c1.layer addAnimation:animation forKey:@"MyAnimation"];
    
    listCoins = [[NSMutableArray alloc] init];
    
    for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
    {
        UIImageView *c1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coinngang.png"]];
        [c1 setFrame:CGRectMake(-50, 450, 32, 32)];
        [listCoins addObject:c1];
        [self addSubview:c1];
        [c1 release];
    }
    
    
//    UIImageView *c1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onecoin.png"]];
//    [c1 setFrame:CGRectMake(160, 300, 32, 32)];
    
    UILabel *congratLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 310, 320, 60)];
    congratLB.text = [[NSString stringWithFormat:@"You got %d coins",playModel.wordInfo.finalWord.length] uppercaseString];
    [congratLB setFont:[UIFont fontWithName:@"Arial-BoldMT" size:22]];
    congratLB.alpha = 0;
    [congratLB setTextAlignment:NSTextAlignmentCenter];
    [congratLB setBackgroundColor:[UIColor clearColor]];
    [congratLB setTextColor:[UIColor whiteColor]];
    [self addSubview:congratLB];
    [congratLB release];
    

    [UIView animateWithDuration:1.5 animations:^{
        [aV setFrame:CGRectMake(0, aV.frame.origin.y-100, 320, aV.frame.size.height)];
        
    } completion:^(BOOL finished) {
        for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
        {
            UIImageView *t = [listCoins objectAtIndex:i];
            [UIView animateWithDuration:1 delay:0.15*(playModel.wordInfo.finalWord.length-i) options:UIViewAnimationOptionCurveEaseInOut animations:^{
                int x = [aV viewWithTag:(i+kRandomNumber)].frame.origin.x;
                [t setFrame:CGRectMake(x, 270, 32, 32)];
            } completion:^(BOOL finished) {
                NSLog(@"i=%d",i);
                if (i==0){
                    [UIView animateWithDuration:1.0 animations:^{
                        congratLB.alpha = 1;
                    } completion:^(BOOL finished) {
                        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                    }];
                }
                
                
            }];
        }

        
        

    }];
    
    
//    [UIView animateWithDuration:0.3 delay:initTag*0.06 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        
//        [self viewWithTag:tagView].layer.transform = CATransform3DMakeRotation(M_PI_2, 0.0, 1.0, 0.0);
//        
//    } completion:^(BOOL finished) {
//        UILabel *lb = (UILabel *)[self viewWithTag:tagView];
//        [lb setTextColor:[UIColor yellowColor]];
//        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//            [self viewWithTag:tagView].layer.transform = CATransform3DMakeRotation(M_PI_2*4,0.0,1.0,0.0); //flip halfway
//        } completion:^(BOOL finished) {
//            if (tagView == kRandomNumber + playModel.wordInfo.finalWord.length-1)
//            {
//                NSLog(@"tag View : %d", tagView);
//                [delegate winEventFromAnswerView];
//            }
//            
//        }];
//        
//        
//    }];

    
    [aV release];
 

//    [[rootController.view viewWithTag:kTagOfCopyAnswerView] removeFromSuperview];
    
    }

#pragma mark Button press handle method

- (void)move
{

    [self genNewEV:0];
    [self genNewEV:1];
    [self genNewEV:2];
    [self genNewEV:3];

    
//    ExplodeView *stars = [[ExplodeView alloc] initWithFrame:CGRectMake(160, 70, 10, 10)];
//    [self addSubview:stars];
//    [stars release];
    
    
//    [self sendSubviewToBack:stars];
//    [UIView animateWithDuration:3 animations:^{
//        stars.center = CGPointMake(320, 70);
//    } completion:^(BOOL finished) {
//        [stars removeFromSuperview];
//        [stars release];
//        [delegate animationFinished];
//    }];
    
}

#pragma mark moveToNextlevel

- (void)moveToNextLevel:(UITapGestureRecognizer *)_tap
{
    if (!tapped)
    {
        tapped = YES;
        for (int i=0;i<[listCoins count];i++){
            [UIView animateWithDuration:1.0 delay:(playModel.wordInfo.finalWord.length-i)*0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
                UIView *coin = [listCoins objectAtIndex:i];
                [coin setFrame:CGRectMake(350, -40, coin.frame.size.width, coin.frame.size.height)];
            } completion:^(BOOL finished) {
                if (i==0){
                    [delegate performSelector:@selector(animationFinished) withObject:nil afterDelay:1.0];
                }
            }];
            
        }
    }
}

#pragma mark ExplodeView Delegate

- (void)genNewEV:(int)i
{
    int startX =  i*80+ arc4random()%80;
    UIImageView *fireBall = [[UIImageView alloc] initWithFrame:CGRectMake(startX, kHeightOfScreen, 10, 10)];
    [fireBall setImage:[UIImage imageNamed:@"particle.png"]];
    [self addSubview:fireBall];
    [fireBall release];
    int endY = 20+arc4random()%200;
    
    [UIView animateWithDuration:((kHeightOfScreen-endY)/350) delay:((arc4random()%30)/10) options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        fireBall.center = CGPointMake(startX, endY);
    } completion:^(BOOL finished) {
        [fireBall removeFromSuperview];
        ExplodeView *stars = [[ExplodeView alloc] initWithFrame:CGRectMake(fireBall.center.x, fireBall.center.y, 10, 10)];
        stars.range = i;
        stars.delegate = self;
        [self addSubview:stars];
        [stars release];
    }];
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
