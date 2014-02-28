//
//  PlayController.m
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "PlayController.h"

@interface PlayController ()

@end

@implementation PlayController
@synthesize playView, playModel, delegate;

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
    StoreController *storeController = [[StoreController alloc]init];
    storeController.delegate = self;
    //    [self presentViewController:storeController animated:YES completion:nil];
    //    [storeController release];
    [self addChildViewController:storeController];
    
    [self.view addSubview:storeController.view];
//    [storeController.view release];
//    [storeController release];
    
}

- (void)hintBtnTapped
{
    NSLog(@"hint Tapped !!!!!");
    HintsView *hintsView = [[HintsView alloc] initWithFrame:self.view.bounds];
    hintsView.delegate = self;
    [hintsView setTag:kTagOfHintView];
    [self.view addSubview:hintsView];
    [hintsView release];
    [hintsView bloat];
    
//    HintView *hintView = [[HintView alloc]initWithFrame:self.view.bounds];
//    hintView.delegate = self;
//    [hintView setTag:kTagOfHintView];
//    [self.view addSubview:hintView];
//    [hintView release];
}

- (void)backBtnPressFromPlayView
{
    [delegate backBtnPressFromPlayController];
}


- (void)showWinScreenFromPlayView
{


    
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
    [playModel release];
    
    [self.view setFrame:playView.bounds];
    [self.view addSubview:playView];
    [playView release];

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
        [alertView release];
        return;
    }
    
    if ([CommonFunction getCoin]>=kPriceOfRemoveLetter){
        [CommonFunction setCanRemoveALetter:NO];
        [CommonFunction setCoin:([CommonFunction getCoin]-kPriceOfRemoveLetter)];
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
        [alertView release];
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
    if ([CommonFunction getCoin]>=kPriceOfLeftTitle){
        [CommonFunction setCoin:([CommonFunction getCoin]-kPriceOfLeftTitle)];
        
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
    if ([CommonFunction getCoin]>=kPriceOfRightTitle){
        [CommonFunction setCoin:([CommonFunction getCoin]-kPriceOfRightTitle)];
        
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

- (void)revealAnswerWordFromHintsView
{
    if ([CommonFunction getCoin]>=kPriceOfAnswerTitle){
        [CommonFunction setCoin:([CommonFunction getCoin]-kPriceOfAnswerTitle)];
        
        [self updateCoininVIew];
        [CommonFunction setShowAnswer:YES];
        [[playView viewWithTag:kTagOfAnswerTitle] setHidden:NO];
        
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

#pragma mark StoreController delegate method

- (void)updateCoininVIew
{
    
    playView.coinLabel.text = [NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"coins"] intValue]];
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
        NSLog(@"button pressed : %d", buttonIndex);
        [self coinViewTappedFromPlayView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
