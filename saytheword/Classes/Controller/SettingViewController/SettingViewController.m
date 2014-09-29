//
//  SettingViewController.m
//  saytheword
//
//  Created by StarHub Imac Admin on 28/2/14.
//  Copyright (c) 2014 Hoang Le. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

@synthesize delegate;

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
        [self.view setFrame:CGRectMake(_pos*kWidthOfScreen + _pos*kShortDisTanceOf2View, 0, kWidthOfScreen, kHeightOfScreen)];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createSubViews];
    
	// Do any additional setup after loading the view.
}


- (void)createNavigationBar
{
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidthOfScreen, 44)];
    //    [navBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kNavBarImg]]];
    
    [navBar setBackgroundColor:[UIColor colorWithRed:203/255.0f green:122/255.0f blue:38/255.0f alpha:1.0f]];
    [navBar setBackgroundColor:navColor];
    navBar.layer.masksToBounds = NO;
    //    navBar.layer.cornerRadius = 5; // if you like rounded corners
    navBar.layer.shadowOffset = CGSizeMake(4, 5);
    navBar.layer.shadowRadius = 5;
    navBar.layer.shadowOpacity = 0.5;
    
    [self createNavigationBar];
    //Create MenuBtn
    UIButton *menuBackBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [menuBackBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    //    [menuBackBtn setTitle:@"Menu" forState:UIControlStateNormal];
    [menuBackBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [menuBackBtn setTintColor:[UIColor blueColor]];
    [menuBackBtn setFrame:CGRectMake(kWidthOfScreen - 80, 5, 70, 34)];
    [menuBackBtn addTarget:delegate action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:menuBackBtn];
    
    [self.view addSubview:navBar];
    
    
    
}

- (void)createSubViews
{
    [self createNavigationBar];
    
    //Create MenuBtn
//    UIButton *menuBackBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [menuBackBtn setTitle:@"Menu" forState:UIControlStateNormal];
//    [menuBackBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
//    [menuBackBtn setTintColor:[UIColor magentaColor]];
//    [menuBackBtn setFrame:CGRectMake(kWidthOfScreen - 120, 0, 120, 44)];
//    [menuBackBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:menuBackBtn];
    

}



#pragma mark UISlider Value Changed

- (void)bgMusicSliderChanged:(UISlider *)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setBGSoundVolume:bgMusicVolumSilder.value];
    
}

#pragma mark Menu Btn Pressed

- (void)backBtnPressed:(id)sender
{
    [CommonFunction setBGSoundVolume:bgMusicVolumSilder.value];
    if ([delegate respondsToSelector:@selector(backBtnPressFromSettingController)])
    {
        [delegate backBtnPressFromSettingController];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
