//
//  RootController.m
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "RootController.h"

@interface RootController ()

@end

@implementation RootController

@synthesize fVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    getCoinsForRating = NO;
    
    [Appirater setAppId:@"654642608"];
    [Appirater setDaysUntilPrompt:-1];
    [Appirater setUsesUntilPrompt:-1];
    [Appirater setSignificantEventsUntilPrompt:1];
    [Appirater setTimeBeforeReminding:-1];
    [Appirater setDebug:NO];
    [Appirater setDelegate:self];
    
    [super viewDidLoad];
    RootView *rootView = [[RootView alloc]initWithFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
    [self.view addSubview:rootView];
    [rootView release];
    
   
    MenuController *menuController = [[MenuController alloc]initWithPosition:0];
    menuController.delegate = self;
    [self addChildViewController:menuController];
    [self.view addSubview:menuController.view];
    fVC = menuController;
    [menuController release];
    [CommonFunction playBGSound];
    
      
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"root view appear !!!!");
    if (getCoinsForRating)
    {
        return;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Thank you for rating" message:[NSString stringWithFormat:@"You got %d for rating app",kRewardCoinsForRatingApp] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        getCoinsForRating = NO;
    }
}

#pragma mark playcontroller delegate method

- (void)backBtnPressFromPlayController
{
    MenuController *menuController = [[MenuController alloc]initWithPosition:-1];
    menuController.delegate = self;
    [self presentNewVCFromTheLeft:menuController];
}

#pragma mark setting controller delegate method

- (void)backBtnPressFromSettingController 
{
    MenuController *menuController = [[MenuController alloc]initWithPosition:1];
    menuController.delegate = self;
    [self presentNewVCFromTheRight:menuController];
}


- (void)showWinScreen
{

    WinController *winController = [[WinController alloc]initWithPosition:1];
    winController.delegate = self;
    [self presentNewVCFromTheRight:winController];
    
//    PlayController *playController = [[PlayController alloc]initWithPosition:1];
//    playController.delegate = self;
//    [self presentNewVCFromTheRight:playController];
}

#pragma mark menucontroller delegate method

- (void)settingActionFromMenuController
{
    SettingViewController *settingController = [[SettingViewController alloc]initWithPosition:-1];
    settingController.delegate = self;
    [self presentNewVCFromTheLeft:settingController];
}


- (void)playActionFromMenuController
{
    PlayController *playController = [[PlayController alloc]initWithPosition:1];
    playController.delegate = self;
    [self presentNewVCFromTheRight:playController];
}

#pragma mark WinController delegate method

- (void)nextLevelFromWinView
{
    PlayController *playController = [[PlayController alloc]initWithPosition:1];
    playController.delegate = self;
    [self presentNewVCFromTheRight:playController];
    [Appirater userDidSignificantEvent:YES];
}

#pragma mark local method

- (void)presentNewVCFromTheLeft:(UIViewController *)newVC
{

    [self addChildViewController:newVC];
    [self.view addSubview:newVC.view];
    
    [UIView animateWithDuration:kTimeToPresentVC animations:^{
        [fVC.view  setFrame:CGRectMake(+kWidthOfScreen, 0, kWidthOfScreen, kHeightOfScreen)];
        [newVC.view setFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
    } completion:^(BOOL finished) {
        [fVC.view removeFromSuperview];
        [fVC dismissViewControllerAnimated:NO completion:nil];
        fVC = newVC;
    }];
    
}

- (void)presentNewVCFromTheRight:(UIViewController *)newVC
{
//    MenuController *playController = [[MenuController alloc]initWithPosition:1];
//    vc.delegate = self;
    [self addChildViewController:newVC];
    [self.view addSubview:newVC.view];

    [UIView animateWithDuration:kTimeToPresentVC animations:^{
        [fVC.view  setFrame:CGRectMake(-kWidthOfScreen, 0, kWidthOfScreen, kHeightOfScreen)];
        [newVC.view setFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
    } completion:^(BOOL finished) {
        [fVC.view removeFromSuperview];
        [fVC dismissViewControllerAnimated:NO completion:nil];
        
        fVC = newVC;
    }];
//    [newVC.view release];
    [newVC release];
    
    
    
}

#pragma mark appirate delegate

- (void)appiraterWillPresentModalView:(Appirater *)appirater animated:(BOOL)animated
{
    getCoinsForRating = YES;    
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     
    if ([alertView.title isEqualToString:@"Thank you for rating"])
    {
        [CommonFunction setCoin:([CommonFunction getCoin]+kRewardCoinsForRatingApp)];
        
        PlayController *VC = (PlayController *)[self.childViewControllers lastObject];
        if ([VC respondsToSelector:@selector(updateCoininVIew)])
        {
            [VC updateCoininVIew];
        }
    }else if ([alertView.title isEqualToString:@"Thank you for liking our page"])
    {
        [CommonFunction setCoin:([CommonFunction getCoin]+kRewardCoinsForLikingFB)];
        
        PlayController *VC = (PlayController *)[self.childViewControllers lastObject];
        if ([VC respondsToSelector:@selector(updateCoininVIew)])
        {
            [VC updateCoininVIew];
        }
    }
    
}


#pragma mark default method

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
