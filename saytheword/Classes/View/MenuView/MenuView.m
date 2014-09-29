//
//  MenuView.m
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView



@synthesize menuModel, delegate, coinLabel;

- (id)initWithModel:(MenuModel *)_model
{
    self = [super init];
    if (self)
    {
        menuModel = _model; 
    }
    [self createSubViews];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




- (void)createNavigationBar
{
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfNavigationBar)];

    [navBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_nau_new.png"]]];
    
//    [navBar setBackgroundColor:[UIColor colorWithRed:203/255.0f green:122/255.0f blue:38/255.0f alpha:1.0f]];
    [navBar setBackgroundColor:navColor];
    navBar.layer.masksToBounds = NO;
//    navBar.layer.cornerRadius = 5; // if you like rounded corners
    navBar.layer.shadowOffset = CGSizeMake(4, 5);
    navBar.layer.shadowRadius = 5;
    navBar.layer.shadowOpacity = 0.5;
    
    
//    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [v1 setBackgroundColor:[UIColor colorWithRed:203/255.0f green:122/255.0f blue:38/255.0f alpha:1.0f]];
//    [self addSubview:v1];
    
    coinView = [[UIView alloc]init];
    [coinView setFrame:CGRectMake(kWidthOfScreen - (kCheckIfIphone ? 120 : 220), 0, (kCheckIfIphone ? 120 : 220), kHeightOfNavigationBar)];
    [coinView setBackgroundColor:[UIColor clearColor]];
    
    int fontSize = kCheckIfIphone ? 16 : 28;
    
    coinLabel = [[UILabel alloc]init];
    coinLabel.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"coins"]];
    [coinLabel setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:fontSize]];
    
    [coinLabel setTextAlignment:NSTextAlignmentRight];
    [coinLabel sizeToFit];
    [coinLabel setFrame:CGRectMake(0, kCheckIfIphone ? 5 : 10, kCheckIfIphone ? 75 : 150, kCheckIfIphone ? 33 : 44 )];
    [coinLabel setBackgroundColor:[UIColor clearColor]];
    [coinLabel setTextColor:[UIColor yellowColor]];
    [coinView addSubview:coinLabel];
    
    coinImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"coins.png"]];
    [coinImageView setBackgroundColor:[UIColor clearColor]];
    int size = kCheckIfIphone ? 33 : 44;
    [coinImageView setFrame:CGRectMake(coinLabel.frame.size.width+10, (coinView.frame.size.height-size)/2, size, size)];
    coinImageView.userInteractionEnabled = YES;
    coinImageView.layer.zPosition = 9999;
    
    
    [coinView addSubview:coinImageView];
    

    
    coinView.userInteractionEnabled = YES;
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coinViewTapped:)];
    [coinView addGestureRecognizer:_tap];
    
    [navBar addSubview:coinView];
    
    
    [self addSubview:navBar];
    
    // Create Level label
    fontSize = kCheckIfIphone ? 20 : 40;
    UILabel *levelLabel = [[UILabel alloc]init];
    levelLabel.text = [NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"level"] intValue]];
    [levelLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:fontSize]];
    [levelLabel sizeToFit];
    
    [levelLabel setFrame:CGRectMake((kWidthOfScreen - levelLabel.frame.size.width)/2, (kHeightOfNavigationBar - levelLabel.frame.size.height)/2, levelLabel.frame.size.width, levelLabel.frame.size.height)];
    [levelLabel setBackgroundColor:[UIColor clearColor]];
    [levelLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:levelLabel];
}

- (void)goToFBFanPage:(id)_sender
{
    NSURL *url = [NSURL URLWithString:@"fb://profile/172415879600587"];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)tapOnMusicIcon:(id)_sender
{
    BOOL playMusic = [CommonFunction checkPlayMusic];
    if (playMusic)
    {
        [musicIcon setImage:[UIImage imageNamed:@"musicoff.png.png"]];
        [CommonFunction stopBGSound];
        
    }else
    {
        [musicIcon setImage:[UIImage imageNamed:@"musicon.png.png"]];
        [CommonFunction playBGSound];
        
    }
    
    [CommonFunction setMusicFlag:!playMusic];
}

- (void)createSubViews
{
    CGRect tmpRect = kCheckIfIphone ? CGRectMake(280, 50, 32, 32) : CGRectMake((kWidthOfScreen+480)/2, 100, 64, 64);
    UIImageView *fbIcon = [[UIImageView alloc] initWithFrame:tmpRect];
    [fbIcon setImage:[UIImage imageNamed:@"fb_icon.png"]];
    fbIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToFBFanPage:)];
    [fbIcon addGestureRecognizer:_tap];
    [self addSubview:fbIcon];
    
    tmpRect = kCheckIfIphone ? CGRectMake(280, 90, 32, 32) : CGRectMake((kWidthOfScreen+480)/2, 200, 64, 64);
    musicIcon = [[UIImageView alloc] initWithFrame:tmpRect];
    if ([CommonFunction checkPlayMusic])
    {
        [musicIcon setImage:[UIImage imageNamed:@"musicon.png"]];
    }else
    {
        [musicIcon setImage:[UIImage imageNamed:@"musicoff.png.png"]];
    }
    musicIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *_taponmusicIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnMusicIcon:)];
    [musicIcon addGestureRecognizer:_taponmusicIcon];
    [self addSubview:musicIcon];
    
    
    
    [self createNavigationBar];
    [self setFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
    
    int y = kHeightOfScreen;
    
    tmpRect = kCheckIfIphone ? CGRectMake(40, y-50-80-80, 240, 50) :CGRectMake((kWidthOfScreen-480)/2, y-66-100-100-60-100, 480, 100);
    int fontSize = kCheckIfIphone ? 23 : 34;
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playBtn setFrame:tmpRect];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"playbtn.png"] forState:UIControlStateNormal];
    
    [playBtn setTitle:@"Guess          " forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [playBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
    [playBtn addTarget:delegate action:@selector(playBtnPressFromMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:playBtn];
    
    tmpRect = kCheckIfIphone ? CGRectMake(40, y-50-80, 240, 50) :CGRectMake((kWidthOfScreen-480)/2, y-66-100-100, 480, 100);
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [settingBtn setFrame:tmpRect];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"playbtn.png"] forState:UIControlStateNormal];
    [settingBtn setTitle:@"How to play" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [settingBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
    [settingBtn addTarget:delegate action:@selector(howtoBtnPressFromMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingBtn];
//    [playBtn release];
    
//    UIButton *playBtn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [playBtn2 setFrame:CGRectMake(40, 420, 240, 40)];    
//    [playBtn2 setBackgroundImage:[UIImage imageNamed:@"playbtntest.jpg"] forState:UIControlStateNormal];
//    [playBtn2.titleLabel setFont:[UIFont boldSystemFontOfSize:23.0f]];
//    [self addSubview:playBtn2];
//    [playBtn2 release];
    
//    UIImageView *chars = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1word2pics.png"]];

    if (![CommonFunction checkNoAds] && [CommonFunction checkIfShowAds])
    {
        adbanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, kCheckIfIphone ? 50 : 66)];
        adbanner.delegate = self;
        
        _bannerIsVisible = NO;
        [self addSubview:adbanner];
    }
}

- (void)coinViewTapped:(UITapGestureRecognizer *)_sender
{
    [delegate coinViewTappedFromMenuView];
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
