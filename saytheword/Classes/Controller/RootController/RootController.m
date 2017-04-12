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
    
      
    [self initFullScreenAds];
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

- (void)initGA
{
    
}

- (void)initFullScreenAds
{
    [self requestFullScreenIAd];
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
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
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
    });
    
}

- (void)presentNewVCFromTheRight:(UIViewController *)newVC
{
//    MenuController *playController = [[MenuController alloc]initWithPosition:1];
//    vc.delegate = self;
    [self addChildViewController:newVC];
    [self.view addSubview:newVC.view];
    [newVC didMoveToParentViewController:self];
    
//    [newVC.view release];

    NSLog(@"ffffff  %@  %@", fVC.view, newVC.view);
    
//    [UIView animatewi]

    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kTimeToPresentVC animations:^{
            [fVC.view  setFrame:CGRectMake(-kWidthOfScreen, 0, kWidthOfScreen, kHeightOfScreen)];
            [newVC.view setFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
        } completion:^(BOOL finished) {
            
            NSLog(@"111111");
            [fVC willMoveToParentViewController:nil];
            [fVC.view removeFromSuperview];
            [fVC removeFromParentViewController];
            fVC = newVC;
        }];
    });
    

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

#pragma mark iAd Interstitial

- (void)requestFullScreenIAd
{
    
    self.gaInterstitial = [self createAndLoadInterstitial];
    
    self.interstitial = [[ADInterstitialAd alloc] init];
    self.interstitial.delegate = self;
    self.interstitialPresentationPolicy = ADInterstitialPresentationPolicyManual;
}


-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    _interstitial = nil;
    NSLog(@"Ad didFailWithERROR");
    NSLog(@"%@", error);
}

-(void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd {
    NSLog(@"Ad DidLOAD");

}

-(void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
    _interstitial = nil;
    NSLog(@"Ad DidUNLOAD");
}

-(void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd {
    _interstitial = nil;
    NSLog(@"Ad DidFINISH");
}

#pragma mark GAD Interstitial


- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *localInterstitial = [[GADInterstitial alloc] init];
    localInterstitial.adUnitID = @"ca-app-pub-1616883244249130/9582987201";
    localInterstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ GAD_SIMULATOR_ID, @"77e210185429e6defb358e3cc5c1378c63226103" ];
    [localInterstitial loadRequest:request];
    
    return localInterstitial;
}

- (void)runInterstitial
{
    if (![self requestInterstitialAdPresentation])
    {
        if ([self.gaInterstitial isReady]) {
            [self.gaInterstitial presentFromRootViewController:self];
        }else
        {
            // Neither is working
        }
    }

}


#pragma mark interstitial Delegate

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    self.gaInterstitial = [self createAndLoadInterstitial];
}

#pragma mark default method

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
