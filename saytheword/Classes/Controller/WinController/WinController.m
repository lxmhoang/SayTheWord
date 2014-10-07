//
//  WinController.m
//  saytheword
//
//  Created by Hoang Le on 6/21/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "WinController.h"

@interface WinController ()

@end

@implementation WinController

@synthesize winView, playModel, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [CommonFunction playBGSound];
    [CommonFunction reSetGlobalData];
    [CommonFunction setCoin:[CommonFunction getCoin]+(int)playModel.wordInfo.finalWord.length*kRewardCoinsForEachLetter];
    
    [CommonFunction setLevel:([CommonFunction getLevel]+1)];
    [CommonFunction setDidAskFriendForCurrentLevel:NO];
    
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    winView = [[WinView alloc]initWithModel:playModel];
    
    int i = arc4random() % 20;
    
    if (i%3==0)
    {
        winView.brag = YES;
        // brag
    }else if (i%3==1)
    {
        winView.fullscreenAds = YES;
        // full screen ads
    }else if (i%3 == 2)
    {
        // nothing
    }
    
    winView.fullscreenAds = YES;
    winView.brag = YES;

    
    winView.delegate = self;

    [self.view setFrame:winView.bounds];
    [self.view addSubview:winView];
    

    


	// Do any additional setup after loading the view.
}



#pragma mark WinViewDelegate methods

- (void)animationFinished
{

    [delegate nextLevelFromWinView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
