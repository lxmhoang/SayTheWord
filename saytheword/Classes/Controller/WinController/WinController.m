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
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    winView = [[WinView alloc]initWithModel:playModel];

    
    winView.delegate = self;
    [playModel release];

    [self.view setFrame:winView.bounds];
    [self.view addSubview:winView];
    [winView release];
    
    [CommonFunction setLevel:([CommonFunction getLevel]+1)];
    if ([CommonFunction getLevel]==100){
        [CommonFunction setLevel:9];
    }
    


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
