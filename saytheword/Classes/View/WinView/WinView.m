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
        numOfFW = kCheckIfIphone ? 5 : 8;
        tapped = NO;
        playModel = _playModel;
        endYLimit = kCheckIfIphone ? 200 : 500;
        sizeOfFW = kCheckIfIphone ? 10 : 20;
        widthOfFireWork = round(kWidthOfScreen/numOfFW);
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
    
    [self addSubview:transView];
    
    RootController *rootController = (RootController *)[CommonFunction getRootController];
    
    AnswerView *aV = (AnswerView *)[rootController.view viewWithTag:kTagOfCopyAnswerView];
    UIView *leftViewTitle = [rootController.view viewWithTag:kTagOfLeftTitle];
    UIView *rightViewTitle = [rootController.view viewWithTag:kTagOfRightTitle];
    
    [self addSubview:leftViewTitle];
    [self sendSubviewToBack:leftViewTitle];
    [self addSubview:rightViewTitle];
    [self sendSubviewToBack:rightViewTitle];
    [self addSubview:aV];
    [self sendSubviewToBack:aV];
    
    


    

    
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
    }
    
    
    int yOfCongrat = kCheckIfIphone ? 310 : 600;
    int fontSize = kCheckIfIphone ? 22 : 35;
    
    UILabel *congratLB = [[UILabel alloc] initWithFrame:CGRectMake(0, yOfCongrat, kWidthOfScreen, 60)];
    congratLB.text = [[NSString stringWithFormat:@"You got %lu coins",playModel.wordInfo.finalWord.length*kRewardCoinsForEachLetter] uppercaseString];
    [congratLB setFont:[UIFont fontWithName:@"Arial-BoldMT" size:fontSize]];
    congratLB.alpha = 0;
    [congratLB setTextAlignment:NSTextAlignmentCenter];
    [congratLB setBackgroundColor:[UIColor clearColor]];
    [congratLB setTextColor:[UIColor whiteColor]];
    [self addSubview:congratLB];
    
    int dstMoveUp = kCheckIfIphone ? 100 : 200;
    
    int yOfCoins = kCheckIfIphone ? 270 : 660;
    int sizeOfCoins = kCheckIfIphone ? 32 : 64;

    [UIView animateWithDuration:1.5 animations:^{
        [aV setFrame:CGRectMake(0, aV.frame.origin.y-dstMoveUp, kWidthOfScreen, aV.frame.size.height)];
        
    } completion:^(BOOL finished) {
        for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
        {
            UIImageView *t = [listCoins objectAtIndex:i];
            [UIView animateWithDuration:0.6 delay:0.1*(playModel.wordInfo.finalWord.length-i) options:UIViewAnimationOptionCurveEaseInOut animations:^{
                int x = [aV viewWithTag:(i+kRandomNumber)].frame.origin.x;
                [t setFrame:CGRectMake(x, yOfCoins, sizeOfCoins, sizeOfCoins)];
            } completion:^(BOOL finished) {
//                NSLog(@"i=%d",i);
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
    


    
    if (![CommonFunction checkNoAds] && [CommonFunction checkIfShowAds])
    {
        adbanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, kWidthOfScreen, 50)];
        adbanner.delegate = self;
        
        _bannerIsVisible = NO;
        [self addSubview:adbanner];
    }
    }

#pragma mark Button press handle method

- (void)move
{
    for (int i = 0;i<numOfFW; i++)
    {
        [self genNewEV:i];
    }


    
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
        [CommonFunction setCoin:[CommonFunction getCoin]+(int)playModel.wordInfo.finalWord.length*kRewardCoinsForEachLetter];
        tapped = YES;
        for (int i=0;i<[listCoins count];i++){
            [UIView animateWithDuration:0.6 delay:(playModel.wordInfo.finalWord.length-i)*0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
                UIView *coin = [listCoins objectAtIndex:i];
                [coin setFrame:CGRectMake(kWidthOfScreen + coin.frame.size.width, -coin.frame.size.height, coin.frame.size.width, coin.frame.size.height)];
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
//    NSLog(@"get new ev %@", self);
    int startX =  i*widthOfFireWork+ arc4random()%widthOfFireWork;
    UIImageView *fireBall = [[UIImageView alloc] initWithFrame:CGRectMake(startX, kHeightOfScreen, sizeOfFW, sizeOfFW)];
    [fireBall setImage:[UIImage imageNamed:@"particle.png"]];
    [self addSubview:fireBall];
    int endY = 20+arc4random()%endYLimit;
    
    [UIView animateWithDuration:((kHeightOfScreen-endY)/350) delay:((arc4random()%30)/10) options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        fireBall.center = CGPointMake(startX, endY);
    } completion:^(BOOL finished) {
        [fireBall removeFromSuperview];
        [CommonFunction playFireworkSound];
        ExplodeView *stars = [[ExplodeView alloc] initWithFrame:CGRectMake(fireBall.center.x, fireBall.center.y, sizeOfFW, sizeOfFW)];
        stars.range = i;
        stars.delegate = self;
        [self addSubview:stars];
    }];
}

- (void)dealloc
{
    for (id tmp in self.subviews)
    {
        if ([tmp isKindOfClass:[ExplodeView class]])
        {
            ExplodeView *t = (ExplodeView *)tmp;
            t.delegate = nil;
        }
    }
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!_bannerIsVisible)
    {
        // If banner isn't part of view hierarchy, add it
        if (adbanner.superview == nil)
        {
            [self addSubview:adbanner];
        }
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
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
