//
//  PlayController.m
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "PlayController.h"
#import "IAPViewController.h"

@interface PlayController ()

@end

@implementation PlayController
@synthesize playView, playModel, delegate, iapVC;

- (id)initWithPosition:(int)_pos
{
    self = [super init];
    if (self)
    {
        playModel = [[PlayModel alloc] initWithPosition:_pos andLevel:[[[NSUserDefaults standardUserDefaults] objectForKey:@"level"] intValue]];
        [self.view setFrame:CGRectMake(_pos*kWidthOfScreen + _pos*kShortDisTanceOf2View, 0, kWidthOfScreen, kHeightOfScreen)];
        
    }

    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark playview delegate method

- (void)coinViewTappedFromPlayView
{
    if (iapVC)
    {
        return;
    }
    NSString *nibName = kCheckIfIphone ? @"IAPViewController" : @"IAPViewController_iPad";
    iapVC = [[IAPViewController alloc] initWithNibName:nibName bundle:nil];
    iapVC.delegate = self;
    
    RootController *rootVC = [CommonFunction getRootController];
    
    [rootVC addChildViewController:iapVC];
    [iapVC didMoveToParentViewController:rootVC];
    [rootVC.view addSubview:iapVC.view];
    
    
}

- (void)hintBtnTapped
{
    HintsView *hintsView = [[[NSBundle mainBundle] loadNibNamed:@"HintsView_iPad" owner:nil options:nil] objectAtIndex:0];
    hintsView.delegate = self;
    [hintsView setUp];
    [self.view addSubview:hintsView];
    [hintsView setTag:kTagOfHintView];
    int y = hintsView.bigView.frame.origin.y;
    CGRect frame = hintsView.bigView.frame;
    [hintsView.bigView setFrame:CGRectMake(hintsView.bigView.frame.origin.x, -hintsView.bigView.frame.size.height, hintsView.bigView.frame.size.width, hintsView.bigView.frame.size.height)];
    int dy = kCheckIfIphone ? 25 : 50;
//    [UIView animateWithDuration:0.2 animations:^{
//        [hintsView.bigView setFrame:CGRectOffset(frame, 0, -dy)];
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.1 animations:^{
//            
//            [hintsView.bigView setFrame:frame];
//        }];
//    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [hintsView.bigView setFrame:CGRectMake(frame.origin.x, y+dy, frame.size.width, frame.size.height)];
    } completion:^(BOOL finished) {
        if (finished)
        {
        
        [UIView animateWithDuration:0.1 animations:^{
                    [hintsView.bigView setFrame:CGRectMake(frame.origin.x, frame.origin.y-dy, frame.size.width, frame.size.height)];
        } completion:^(BOOL finished) {
        }];
        }
        
        
    }
     ];
    
  //  [hintsView bloat];

    
//    NSLog(@"hint Tapped !!!!!");
//    HintsView *hintsView = [[HintsView alloc] initWithFrame:self.view.bounds];
//    hintsView.delegate = self;
//    [hintsView setTag:kTagOfHintView];
//    [self.view addSubview:hintsView];
//    [hintsView bloat];
//    

}

- (void)backBtnPressFromPlayView
{
    [playView deactiveTimer];
    [delegate backBtnPressFromPlayController];
}


- (void)showWinScreenFromPlayView
{


    [playView deactiveTimer];
    [delegate showWinScreen];
    
    NSLog(@"aaa");
}

#pragma mark 

#pragma mark default method

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    playView = [[PlayView alloc]initWithModel:playModel];
    [playView setDelegate:self];
    
    [self.view setFrame:playView.bounds];
    [self.view addSubview:playView];

    // Do any additional setup after loading the view.
}


#pragma mark Hint Delegate methods

- (void)shareFBFromHint
{
    
}

- (void)removeALetterFromHintsView
{
    int numOfRemoveableChars = [playView checkNumOfRemoveableChars];
    if (numOfRemoveableChars == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"There is no removeable char remain in Typing View" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if ([CommonFunction getCoin]>=[CommonFunction getPriceOfRemovingLetter]){
        [CommonFunction setCanRemoveALetter:NO];
        [CommonFunction setCoin:([CommonFunction getCoin]-[CommonFunction getPriceOfRemovingLetter])];
        [self updateCoininVIew];
        [self removeALetter];
        
    }else
    {
        [self coinViewTappedFromPlayView];
    }
    
}


- (void)revealALetterFromHintsView
{
    int numOfEmptyLB = [playView checkNumOfEmptyLabelInResultView];
    if (numOfEmptyLB==0){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"The answer view must have at least 1 empty label" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    

    if ([CommonFunction getCoin]>=kPriceOfRevealLetter){
        [CommonFunction setCoin:([CommonFunction getCoin]-kPriceOfRevealLetter)];

        [self updateCoininVIew];
        [self revealALetter:numOfEmptyLB];
        
    }else{
        [self coinViewTappedFromPlayView];
    }
}

- (void)revealLeftWordFromHintsView
{
    if ([CommonFunction getCoin]>=[CommonFunction getPriceOfRevealingLeftPic]){
        [CommonFunction setCoin:([CommonFunction getCoin]-[CommonFunction getPriceOfRevealingLeftPic])];
        
        [self updateCoininVIew];
        [CommonFunction setShowLeftTitle:YES];
        [[playView viewWithTag:kTagOfLeftTitle] setAlpha:1.0];
        
        for (UIView *tmp in self.view.subviews){
            if ([tmp isKindOfClass:[HintsView class]])
            {
                [tmp removeFromSuperview];
                break;
                
            }
        }
        
    }else{
        [self coinViewTappedFromPlayView];
    }
}

- (void)revealRightWordFromHintsView
{
    if ([CommonFunction getCoin]>=[CommonFunction getPriceOfRevealingRightPic]){
        [CommonFunction setCoin:([CommonFunction getCoin]-[CommonFunction getPriceOfRevealingRightPic])];
        
        [self updateCoininVIew];
        [CommonFunction setShowRightTitle:YES];
        [[playView viewWithTag:kTagOfRightTitle] setAlpha:1.0];
        
        for (UIView *tmp in self.view.subviews){
            if ([tmp isKindOfClass:[HintsView class]])
            {
                [tmp removeFromSuperview];
                break;
                
            }
        }
    }else{
        [self coinViewTappedFromPlayView];
    }
}

#pragma mark IAPViewController delegate method

- (void)updateCoininVIew
{
    
    playView.coinLabel.text = [NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"coins"] intValue]];
}


- (void)dismissIAPVC
{
    iapVC = nil;
}

- (void)shareFB:(UIGestureRecognizer *)_tap
{
    
}

#pragma mark functions

- (void)removeALetter
{
    [playView removeALetterFromController];
    NSLog(@"A LETTER HAS BEEN REMOVED");
    for (UIView *tmp in self.view.subviews){
        if ([tmp isKindOfClass:[HintsView class]])
        {
            [tmp removeFromSuperview];
            break;
            
        }
    }
}

- (void)revealALetter:(int)numOfEmptyLB
{
    int r = [playView getIndexOfRevealLabel:numOfEmptyLB];
    
    [CommonFunction setRevealIndex:r];
    [CommonFunction setCanRevealALetter:NO];
    

    
    [playView revealALetterFromController:r];
    for (UIView *tmp in self.view.subviews){
        if ([tmp isKindOfClass:[HintsView class]])
        {
            [tmp removeFromSuperview];
            break;
            
        }
    }
}

#pragma mark UIALertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1){
        NSLog(@"button pressed : %ld", (long)buttonIndex);
        [self coinViewTappedFromPlayView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
