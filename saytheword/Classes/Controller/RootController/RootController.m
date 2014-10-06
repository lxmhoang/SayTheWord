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
    
    
    [super viewDidLoad];
    RootView *rootView = [[RootView alloc]initWithFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
    [self.view addSubview:rootView];
    
   
    MenuController *menuController = [[MenuController alloc]initWithPosition:0];
    menuController.delegate = self;
    [self addChildViewController:menuController];
    [self.view addSubview:menuController.view];
    
    fVC = menuController;
//    [menuController.view release];
    
//    [menuController release];
    if ([CommonFunction checkPlayMusic])
    {
        [CommonFunction playBGSound];
    }else
    {
        
    }
    
      
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{

}

#pragma mark playcontroller delegate method

- (void)backBtnPressFromPlayController
{
    MenuController *menuController = [[MenuController alloc]initWithPosition:-1];
    menuController.delegate = self;
    [self presentNewVCFromTheLeft:menuController];
}


#pragma mark how to  controller delegate method

- (void)backBtnPressFromHowToController
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

- (void)howtoActionFromMenuController
{
    HowToPlayViewController *howtoController = [[HowToPlayViewController alloc]initWithPosition:-1];
    howtoController.delegate = self;
    [self presentNewVCFromTheLeft:howtoController];
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
    [CommonFunction setLevel:([CommonFunction getLevel]+1)];
    [CommonFunction setDidAskFriendForCurrentLevel:NO];
//    if ([CommonFunction getLevel]==100){
//        [CommonFunction setLevel:9];
//    }
    
    
    
    
    
    PlayController *playController = [[PlayController alloc]initWithPosition:1];
    playController.delegate = self;
    [self presentNewVCFromTheRight:playController];
}

#pragma mark local method

- (void)presentNewVCFromTheLeft: (UIViewController *)newVC
{
    
    [self addChildViewController:newVC];
    [self.view addSubview:newVC.view];
    [newVC didMoveToParentViewController:self];
    
//    [newVC.view release];
//    [newVC.view release];
    
    
    [UIView animateWithDuration:kTimeToPresentVC animations:^{
        [fVC.view  setFrame:CGRectMake(+kWidthOfScreen, 0, kWidthOfScreen, kHeightOfScreen)];
        [newVC.view setFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
    } completion:^(BOOL finished) {
        [fVC willMoveToParentViewController:nil];
        [fVC.view removeFromSuperview];
        [fVC removeFromParentViewController];
        fVC.view = nil;
        fVC = nil;
        
        fVC = newVC;
        
    }];
    
}

- (void)presentNewVCFromTheRight:(UIViewController *)newVC
{
//    MenuController *playController = [[MenuController alloc]initWithPosition:1];
//    vc.delegate = self;
    [self addChildViewController:newVC];
    [self.view addSubview:newVC.view];
    [newVC didMoveToParentViewController:self];
    
//    [newVC.view release];


    [UIView animateWithDuration:kTimeToPresentVC animations:^{
        [fVC.view  setFrame:CGRectMake(-kWidthOfScreen, 0, kWidthOfScreen, kHeightOfScreen)];
        [newVC.view setFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
    } completion:^(BOOL finished) {
        [fVC willMoveToParentViewController:nil];
        [fVC.view removeFromSuperview];
        [fVC removeFromParentViewController];
        fVC = newVC;
    }];
//    [newVC.view release];
    
    
    
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     
    if ([alertView.title isEqualToString:[NSString stringWithFormat:kMsgThankForRating]])
    {
        [CommonFunction setCoin:([CommonFunction getCoin]+[CommonFunction getRewardCoinForRattingApp])];
        
        for (id VC in self.childViewControllers)
        {
            if ([VC respondsToSelector:@selector(updateCoininVIew)])
            {
                [VC updateCoininVIew];
                break;
            }
        }
        
//        PlayController *VC = (PlayController *)[self.childViewControllers lastObject];
//        if ([VC respondsToSelector:@selector(updateCoininVIew)])
//        {
//            [VC updateCoininVIew];
//        }
    }else if ([alertView.title isEqualToString:@"Thank you for liking our page"])
    {
        [CommonFunction setCoin:([CommonFunction getCoin]+[CommonFunction getRewardCoinForLikingPage])];
        
        id lastVC = [self.childViewControllers lastObject];
        
        if ([lastVC isKindOfClass:[PlayController class]])
        {
            PlayController *VC = (PlayController *)lastVC;
            if ([VC respondsToSelector:@selector(updateCoininVIew)])
            {
                [VC updateCoininVIew];
            }
        }else if ([lastVC isKindOfClass:[MenuController class]])
        {
            MenuController *VC = (MenuController *)lastVC;
            if ([VC respondsToSelector:@selector(updateCoininVIew)])
            {
                [VC updateCoininVIew];
            }
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
