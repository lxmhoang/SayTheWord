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
        menuModel = [_model retain]; 
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
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidthOfScreen, 44)];
//    [navBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kNavBarImg]]];
    
    [navBar setBackgroundColor:[UIColor colorWithRed:203/255.0f green:122/255.0f blue:38/255.0f alpha:1.0f]];
    navBar.layer.masksToBounds = NO;
    navBar.layer.cornerRadius = 5; // if you like rounded corners
    navBar.layer.shadowOffset = CGSizeMake(4, 5);
    navBar.layer.shadowRadius = 5;
    navBar.layer.shadowOpacity = 0.5;
    coinView = [[UIView alloc]init];
    [coinView setBackgroundColor:[UIColor clearColor]];
    
    
    coinLabel = [[UILabel alloc]init];
    coinLabel.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"coins"]];
    [coinLabel setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:16]];
    
    [coinLabel setTextAlignment:NSTextAlignmentRight];
    [coinLabel sizeToFit];
    [coinLabel setFrame:CGRectMake(0, 5, 75, 33)];
    [coinLabel setBackgroundColor:[UIColor clearColor]];
    [coinLabel setTextColor:[UIColor yellowColor]];
    [coinLabel setTag:1111];
    [coinView addSubview:coinLabel];
    [coinLabel release];
    
    coinImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"coins.png"]];
    [coinImageView setBackgroundColor:[UIColor clearColor]];
    [coinImageView setFrame:CGRectMake(120-43, 5, 33, 33)];
    coinImageView.userInteractionEnabled = YES;
    coinImageView.layer.zPosition = 9999;
    
    
    [coinView addSubview:coinImageView];
    [coinImageView release];
    
    [coinView setFrame:CGRectMake(kWidthOfScreen - 120, 0, 120, 44)];
    //    [coinView setBackgroundColor:[UIColor redColor]];
    
    coinView.userInteractionEnabled = YES;
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coinViewTapped:)];
    [coinView addGestureRecognizer:_tap];
    [_tap release];
    
    [navBar addSubview:coinView];
    [coinView release];
    
//
//    
//    navBar.layer.shadowOffset = CGSizeMake(0, 1);
//    navBar.layer.shadowRadius = 2;
//    navBar.layer.shadowOpacity = 0.8;
//    
//    navBar.layer.cornerRadius = 10;
//    

    
    
    [self addSubview:navBar];
    [navBar release];
    
    // Create Level label
    UILabel *levelLabel = [[UILabel alloc]init];
    levelLabel.text = [NSString stringWithFormat:@"Level %d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"level"] intValue]];
    [levelLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
    [levelLabel sizeToFit];
    
    [levelLabel setFrame:CGRectMake((kWidthOfScreen - levelLabel.frame.size.width)/2, (44 - levelLabel.frame.size.height)/2, levelLabel.frame.size.width, levelLabel.frame.size.height)];
    [levelLabel setBackgroundColor:[UIColor clearColor]];
    [levelLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:levelLabel];
    [levelLabel release];
}

- (void)goToFBFanPage:(id)_sender
{
    NSURL *url = [NSURL URLWithString:@"fb://profile/172415879600587"];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)createSubViews
{
    UIImageView *fbIcon = [[UIImageView alloc] initWithFrame:CGRectMake(280, 50, 32, 32)];
    [fbIcon setImage:[UIImage imageNamed:@"fb_icon.png"]];
    fbIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToFBFanPage:)];
    [fbIcon addGestureRecognizer:_tap];
    [_tap release];
    [self addSubview:fbIcon];
    [fbIcon release];
    
    [self createNavigationBar];
    [self setFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playBtn setFrame:CGRectMake(40, 320, 240, 40)];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"playbtn.png"] forState:UIControlStateNormal];
    [playBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:23.0f]];
    [playBtn addTarget:delegate action:@selector(playBtnPressFromMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:playBtn];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [settingBtn setFrame:CGRectMake(40, 320+80, 240, 40)];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"playbtn.png"] forState:UIControlStateNormal];
    [settingBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:23.0f]];
    [settingBtn addTarget:delegate action:@selector(settingBtnPressFromMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingBtn];
//    [playBtn release];
    
//    UIButton *playBtn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [playBtn2 setFrame:CGRectMake(40, 420, 240, 40)];    
//    [playBtn2 setBackgroundImage:[UIImage imageNamed:@"playbtntest.jpg"] forState:UIControlStateNormal];
//    [playBtn2.titleLabel setFont:[UIFont boldSystemFontOfSize:23.0f]];
//    [self addSubview:playBtn2];
//    [playBtn2 release];
    
    UIImageView *chars = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1word2pics.png"]];
    [chars setFrame:CGRectMake(30, 40, 260, 260)];
    [self addSubview:chars];
    [chars release];
}

- (void)coinViewTapped:(UITapGestureRecognizer *)_sender
{
    [delegate coinViewTappedFromMenuView];
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
