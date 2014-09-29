//
//  FreeCoinView.m
//  saytheword
//
//  Created by Hoang Le on 7/22/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//
#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT
#import "FreeCoinView.h"

@implementation FreeCoinView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
        
        
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    CGRect frameHintView;
    if( IS_IPHONE_5 )
    {
        frameHintView =  CGRectMake(115, 200, 90, 100);
    }
    else
    {
        //        frameHintView =  CGRectMake(20, 50, 280, 400);
        frameHintView =  CGRectMake(115, 200, 90, 100);
    }
    bigView = [[UIView alloc]initWithFrame:frameHintView];
    [bigView setBackgroundColor:[UIColor purpleColor]];
    
    [self createSmallViews];
    
    
    [self addSubview:bigView];
    [self bloat];
}

- (void)likeBtnPress:(UITapGestureRecognizer *)_sender
{
    if (!FBSession.activeSession.isOpen)
    {
        FBLoginView *loginview = [[FBLoginView alloc] init];
        
        for (id obj in loginview.subviews)
        {
            if ([obj isKindOfClass:[UIButton class]])
            {
//                [_sender.view setBackgroundColor:[UIColor clearColor]];
                [obj setFrame:CGRectMake(0, 0, 60, 18)];
                
//                UIButton * loginButton =  obj;
//                UIImage *loginImage = [UIImage imageNamed:@"nav_nau.png"];
//                [loginButton setBackgroundImage:loginImage forState:UIControlStateNormal];
//                [loginButton setBackgroundImage:nil forState:UIControlStateSelected];
//                [loginButton setBackgroundImage:nil forState:UIControlStateHighlighted];
//                [loginButton sizeToFit];
            }
            if ([obj isKindOfClass:[UILabel class]])
            {
                UILabel * loginLabel =  obj;
                loginLabel.text = @"a";
                loginLabel.textAlignment = UITextAlignmentCenter;
                loginLabel.frame = CGRectMake(0, 0, 271, 37);
            }
        }
    
        loginview.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
        [_sender.view addSubview:loginview];
        [loginview sizeToFit];
    }else
    {
        
        NSURL *url = [NSURL URLWithString:@"fb://profile/172415879600587"];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)shareApp:(UITapGestureRecognizer *)_sender
{
    if( [UIActivityViewController class] )
    {
        APActivityProvider *ActivityProvider = [[APActivityProvider alloc] init];
        UIImage *ImageAtt = [UIImage imageNamed:@"bg1136.jpg"];
        NSArray *Items = @[ActivityProvider, ImageAtt];
        
        
        UIActivityViewController *aVC = [[UIActivityViewController alloc] initWithActivityItems:Items applicationActivities:nil];
        NSMutableArray *listDisableItems = [[NSMutableArray alloc] initWithObjects:UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll, UIActivityTypePostToWeibo,UIActivityTypeAirDrop, nil];
        
        
        
        if ([[NSDate date] compare:[[CommonFunction getLastFBShare] dateByAddingTimeInterval:[CommonFunction timeToNextShare]]]==NSOrderedAscending)
        {
            [listDisableItems addObject:UIActivityTypePostToFacebook];
        }
        if ([[NSDate date] compare:[[CommonFunction getLastSendEmail] dateByAddingTimeInterval:[CommonFunction timeToNextShare]]]==NSOrderedAscending)
        {
            [listDisableItems addObject:UIActivityTypeMail];
        }
        if ([[NSDate date] compare:[[CommonFunction getLastTwitterShare] dateByAddingTimeInterval:[CommonFunction timeToNextShare]]]==NSOrderedAscending)
        {
            [listDisableItems addObject:UIActivityTypePostToTwitter];
        }
        if ([[NSDate date] compare:[[CommonFunction getLastSendSMS] dateByAddingTimeInterval:[CommonFunction timeToNextShare]]]==NSOrderedAscending)
        {
            [listDisableItems addObject:UIActivityTypeMessage];
        }
        
        [aVC setExcludedActivityTypes:listDisableItems];
        
        [aVC setCompletionHandler:^(NSString *activityType, BOOL completed){
            NSLog(@"activity Type : %@", activityType);
            if (completed)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Great" message:[NSString stringWithFormat:@"You got %d coins, thank you very much :> ",kRewardCoinsForSharingApp] delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                [CommonFunction setCoin:[CommonFunction getCoin]+kRewardCoinsForSharingApp];
                
                SWITCH (activityType) {
                    CASE (@"com.apple.UIKit.activity.Message") {
                        [CommonFunction setLastSendSMS:[NSDate date]];
                        break;
                    }
                    CASE (@"com.apple.UIKit.activity.Mail") {
                        [CommonFunction setLastSendEmail:[NSDate date]];
                        break;
                    }
                    CASE (@"com.apple.UIKit.activity.PostToTwitter") {
                        [CommonFunction setLastTwitterShare:[NSDate date]];
                        break;
                    }
                    CASE (@"com.apple.UIKit.activity.PostToFacebook") {
                        [CommonFunction setLastFBShare:[NSDate date]];
                        break;
                    }
                    DEFAULT {
                        break;
                    }
                }
            }
        }];
        
        [self.delegate presentViewController:aVC animated:YES completion:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"We are sorry. This feature can only available in IOS 6, please upgrade IOS to get free coins" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)create1Button
{
    UIView *shareAppView = [[UIView alloc] initWithFrame:CGRectMake(22, 60, 45, 30)];
    [shareAppView setBackgroundColor:[UIColor whiteColor]];
    UITapGestureRecognizer *_tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareApp:)];
    [shareAppView addGestureRecognizer:_tap2];
    [bigView addSubview:shareAppView];

}

- (void)create2Button
{
//    [bigView setBackgroundColor:[UIColor redColor]];
    UIView *likeFBView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 60 , 18)];
    [likeFBView setBackgroundColor:[UIColor whiteColor]];
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeBtnPress:)];
    [likeFBView addGestureRecognizer:_tap];
    [bigView addSubview:likeFBView];
    
    UIView *shareAppView = [[UIView alloc] initWithFrame:CGRectMake(15, 60, 60, 18)];
    [shareAppView setBackgroundColor:[UIColor whiteColor]];
    UITapGestureRecognizer *_tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareApp:)];
    [shareAppView addGestureRecognizer:_tap2];
    [bigView addSubview:shareAppView];
}

- (void)createSmallViews
{
    if ([CommonFunction getLikeFanPage])
    {
        [self create1Button];
    }
    else
    {
        if (FBSession.activeSession.isOpen)
        {
            [FBRequestConnection startWithGraphPath:@"/me/likes/172415879600587" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (error) {
                    if (![CommonFunction getLikeFanPage])
                    {
                        [self create2Button];
                    }
                    NSLog(@"FB_UD %@", error.userInfo);
                } else {
                    if ([[result objectForKey:@"data"] count]>0)
                    {
                        [CommonFunction setLikeFanPage:YES];
                        [self create1Button];
                    }else{
                        [self create2Button];
                    }
                    
                    
                    NSLog(@"FB_LIKES: %@:", result);
                }
            }];
        }else
        {
            [self create2Button];
        }
    }
       

}

- (void)closeBigView:(id)_sender
{
        [self removeFromSuperview];
}

- (void)bloat
{
    //    return;
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        [bigView setTransform:CGAffineTransformMakeScale(3.4, 3.4)];
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            [bigView setTransform:CGAffineTransformMakeScale(3.0, 3.0)];
        } completion:^(BOOL finished) {
            UIImageView *closeIcon = [[UIImageView alloc]initWithFrame:CGRectMake(bigView.frame.origin.x-12, bigView.frame.origin.y-12, 32, 32)];
            [closeIcon setImage:[UIImage imageNamed:@"Close-icon.png"]];
            closeIcon.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeBigView:)];
            [closeIcon addGestureRecognizer:_tap];
            [self addSubview:closeIcon];
        }];
        
        
    }
     ];
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
