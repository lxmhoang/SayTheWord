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
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    //Create MenuBtn
    UIButton *menuBackBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [menuBackBtn setTitle:@"Menu" forState:UIControlStateNormal];
    [menuBackBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [menuBackBtn setTintColor:[UIColor magentaColor]];
    [menuBackBtn setFrame:CGRectMake(kWidthOfScreen - 120, 0, 120, 44)];
    [menuBackBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuBackBtn];
    
    UILabel *bgMusicVolumLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, kWidthOfScreen-30-30, 30)];
    [bgMusicVolumLabel setTextColor:[UIColor whiteColor]];
    [bgMusicVolumLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    bgMusicVolumLabel.text = @"BackGround Music Volume";
    [self.view addSubview:bgMusicVolumLabel];
    
    bgMusicVolumSilder = [[UISlider alloc] initWithFrame:CGRectMake(30, 150, kWidthOfScreen-30-30, 30)];
    [bgMusicVolumSilder addTarget:self action:@selector(bgMusicSliderChanged:) forControlEvents:UIControlEventValueChanged];
    [bgMusicVolumSilder setValue:[CommonFunction getBGSoundVolume]];
    [self.view addSubview:bgMusicVolumSilder];
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
