//
//  HintView.m
//  1word2pics
//
//  Created by Hoang le on 4/5/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import "HintsView.h"
#import "FreeCoinModel.h"
#import "FreecoinCollectionViewCell.h"
#import "ApActivityData.h"


#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

@implementation HintsView
@synthesize delegate,  bigView, bodyView, backBtn, freeCoinCollectionView, fbView;

- (void)removeLetter:(UITapGestureRecognizer *)_sender
{
    [delegate removeALetterFromHintsView];
}

- (void)revealLetter:(UITapGestureRecognizer *)_sender
{
    [delegate revealALetterFromHintsView];
}

- (void)showLeftTitle:(UITapGestureRecognizer *)_sender
{
    [delegate revealLeftWordFromHintsView];
}

- (void)showRightTitle:(UITapGestureRecognizer *)_sender
{
    [delegate revealRightWordFromHintsView];
}

- (IBAction)askFriendAction:(id)sender {
}


- (IBAction)freeCoinAction:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.bodyView setFrame:CGRectOffset(self.bodyView.frame, -self.bodyView.frame.size.width, 0)];
        [self.freeCoinCollectionView setFrame:CGRectOffset(self.freeCoinCollectionView.frame, -self.bodyView.frame.size.width, 0)];
        [self.fbView setFrame:CGRectOffset(self.fbView.frame, -self.bodyView.frame.size.width, 0)];
        backBtn.alpha = 1;
    }];
}



- (void)createSmallViews
{
    // Create navigation
    
//    int heightOfNaviBar = kCheckIfIphone ? 14 : 32;
    
//    UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, bigView.frame.size.width, heightOfNaviBar)];
//    
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"CANCEL"
//                                                                    style:UIBarButtonItemStyleDone target:nil action:nil];
//    
//    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"HINTS"];
//    item.rightBarButtonItem = rightButton;
//    item.hidesBackButton = NO;
//    [naviBar pushNavigationItem:item animated:NO];
//    
//    NSDictionary *settings = @{
//                               UITextAttributeFont                 :  [UIFont systemFontOfSize:<#(CGFloat)#>],
//                               UITextAttributeTextColor            :  [UIColor whiteColor],
//                               UITextAttributeTextShadowColor      :  [UIColor clearColor],
//                               UITextAttributeTextShadowOffset     :  [NSValue valueWithUIOffset:UIOffsetZero]};
//    
//    [[UINavigationBar appearance] setTitleTextAttributes:settings];
//    
//    [bigView addSubview:naviBar];
    
    //
    UIView *removeLetterView = [[UIView alloc]initWithFrame:CGRectMake(3, 24, 27, 30)];
    [removeLetterView setBackgroundColor:[UIColor redColor]];
    if (![CommonFunction getCanRemoveALetter]){
        removeLetterView.alpha = 0.5;
    }else{
        UITapGestureRecognizer *_tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeLetter:)];
        [removeLetterView addGestureRecognizer:_tap1];
    }
    [bigView addSubview:removeLetterView];
    
    UIView *showLetterView = [[UIView alloc]initWithFrame:CGRectMake(31, 24, 28 , 30)];
    [showLetterView setBackgroundColor:[UIColor redColor]];
    if (![CommonFunction getCanRevealALetter]){
        showLetterView.alpha = 0.5;
    }else{
        UITapGestureRecognizer *_tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(revealLetter:)];
        [showLetterView addGestureRecognizer:_tap2];
    }

    [bigView addSubview:showLetterView];
    
    UIView *showLeftTitle = [[UIView alloc]initWithFrame:CGRectMake(60, 24, 27 , 30)];
    [showLeftTitle setBackgroundColor:[UIColor redColor]];
    if ([CommonFunction getShowLeftTitle]){
        showLeftTitle.alpha = 0.5;
    }else{
        UITapGestureRecognizer *_tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showLeftTitle:)];
        [showLeftTitle addGestureRecognizer:_tap3];
    }

    [bigView addSubview:showLeftTitle];
    
    UIView *showRightTitle = [[UIView alloc]initWithFrame:CGRectMake(3, 64, 27 , 30)];
    [showRightTitle setBackgroundColor:[UIColor redColor]];
    if ([CommonFunction getShowRightTitle]){
        showRightTitle.alpha = 0.5;
    }else{
        UITapGestureRecognizer *_tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showRightTitle:)];
        [showRightTitle addGestureRecognizer:_tap4];
    }
    
    [bigView addSubview:showRightTitle];
    


}

- (void)createSubViews
{
    CGRect frameHintView;
    if (kCheckIfIphone)
    {
        if( IS_IPHONE_5 )
        {
            frameHintView =  CGRectMake(115, 200, 90, 100);
        }
        else
        {
            //        frameHintView =  CGRectMake(20, 50, 280, 400);
            frameHintView =  CGRectMake(115, 200, 90, 100);
        }
    }else
    {
        frameHintView = CGRectMake(300, 400, 150, 165);
    }
    
//    int k = kCheckIfIphone ? 5 : 15;
//    
//    
//    bigView = [[UIView alloc]initWithFrame:frameHintView];
//    bigView.layer.cornerRadius = k;
//    bigView.clipsToBounds = YES;
//    [bigView setBackgroundColor:[UIColor whiteColor]];
//    
//    [self createSmallViews];
//    
//
//    [self addSubview:bigView];
}

- (void)niceBorder:(UIView *)view
{
    view.layer.borderWidth = 2;
    if ((view == _view22) || (view == _view23))
    {
        view.layer.borderColor = [[UIColor redColor] CGColor];
    }else
    {
        
        view.layer.borderColor = [[UIColor yellowColor] CGColor];
    }
}

- (void)setUp
{
    [self createOptionGetFreeCoin];
    UINib *cellNib = [UINib nibWithNibName:@"FreecoinCollectionViewCell" bundle:nil];
    [self.freeCoinCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"FreeCoinCell"];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.45];
    
    int k = kCheckIfIphone ? 5 : 15;
    int t = kCheckIfIphone ? 2 : 5;
    
    
    self.askFriendIcon.layer.cornerRadius = k;
    self.freeCoinIcon.layer.cornerRadius = k;
    self.askFriendIcon.layer.borderWidth = 1;
    self.freeCoinIcon.layer.borderWidth = 1;
    self.askFriendIcon.layer.borderColor = [[UIColor yellowColor] CGColor];
    self.freeCoinIcon.layer.borderColor = [[UIColor yellowColor] CGColor];
    
    bigView.layer.cornerRadius = k;
    bigView.clipsToBounds = YES;
    bigView.layer.borderColor = [[UIColor yellowColor] CGColor];
    bigView.layer.borderWidth = 1;
    
    self.view11.layer.cornerRadius = t;
    self.view12.layer.cornerRadius = t;
    self.view13.layer.cornerRadius = t;
    self.view21.layer.cornerRadius = t;
    self.view22.layer.cornerRadius = t;
    self.view23.layer.cornerRadius = t;
    
    
    self.coinView11.layer.cornerRadius = t;
    self.coinView12.layer.cornerRadius = t;
    self.coinView13.layer.cornerRadius = t;
    self.coinView21.layer.cornerRadius = t;
    self.coinView22.layer.cornerRadius = t;
    self.coinView23.layer.cornerRadius = t;
    
    
    self.coinView11.layer.masksToBounds = YES;
    self.coinView12.layer.masksToBounds = YES;
    self.coinView13.layer.masksToBounds = YES;
    self.coinView21.layer.masksToBounds = YES;
    self.coinView22.layer.masksToBounds = YES;
    self.coinView23.layer.masksToBounds = YES;
    
    [self niceBorder:self.view11];
    [self niceBorder:self.view12];
    [self niceBorder:self.view13];
    [self niceBorder:self.view21];
    [self niceBorder:self.view22];
    [self niceBorder:self.view23];
    
    self.coinView11.text = [[NSString stringWithFormat:@"%d coins", [CommonFunction getPriceOfRemovingLetter]] uppercaseString];
    self.coinView12.text = [[NSString stringWithFormat:@"%d coins", [CommonFunction getPriceOfRevealingLetter]] uppercaseString];
    
    self.coinView13.text = [[NSString stringWithFormat:@"%d coins", [CommonFunction getPriceOfRevealingLeftPic]] uppercaseString];
    
    self.coinView21.text = [[NSString stringWithFormat:@"%d coins", [CommonFunction getPriceOfRevealingRightPic]] uppercaseString];
    
    if ([CommonFunction getRewardCoinForAskingFriends] > 0)
    {
        self.coinView22.text =[[NSString stringWithFormat:@"+%d coins", [CommonFunction getRewardCoinForAskingFriends]] uppercaseString];
    }else
    {
        self.coinView22.text = @"";
    }
    
    if (maxFreeCoin > 0)
    {
        self.coinView23.text =[[NSString stringWithFormat:@"+%d coins",maxFreeCoin] uppercaseString];
        
    }else
    {
        self.coinView23.text = @"";
    }
    
    
    bigView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
    
    if (![CommonFunction getCanRemoveALetter])
    {
        
        self.view11.alpha = 0;
    }
    
    
    if (![CommonFunction getCanRevealALetter])
    {
        
        self.view12.alpha = 0;
    }
    
    if ([CommonFunction getShowLeftTitle])
    {
        
        self.view13.alpha = 0;
    }
    if ([CommonFunction getShowRightTitle])
    {
        
        self.view21.alpha = 0;
    }
    

    

}

- (IBAction)backBtnAction:(id)sender {
    BOOL hideBackBtn = bodyView.frame.origin.x == - bodyView.frame.size.width ? YES : NO;
    [UIView animateWithDuration:0.3 animations:^{
        [self.bodyView setFrame:CGRectOffset(self.bodyView.frame, +self.bodyView.frame.size.width, 0)];
        [self.freeCoinCollectionView setFrame:CGRectOffset(self.freeCoinCollectionView.frame, +self.bodyView.frame.size.width, 0)];
        [self.fbView setFrame:CGRectOffset(self.fbView.frame, +self.bodyView.frame.size.width, 0)];
    } completion:^(BOOL finished) {
        if (hideBackBtn)
        {
            backBtn.alpha = 0;
        }else
        {
            backBtn.alpha = 1;
        }
    }];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        hintString = [[NSUserDefaults standardUserDefaults] stringForKey:@"hintString"];
        // Initialization code
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];

        
//        [self createSubViews];
    }
    return self;
}



- (IBAction)closeBigView:(id)sender {
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
        }];
        

    }
    ];
}

- (void)createOptionGetFreeCoin
{
    maxFreeCoin = -1;
    optionsGetFreeCoin = [[NSMutableArray alloc] init];
    
    
    if ([CommonFunction checkIfRateForCoin] && [CommonFunction getRateUS] == 0)
    {
        FreeCoinModel *rate = [[FreeCoinModel alloc] init];
        rate.imgName = @"star_rate.png";
        rate.title = kTitleOfRating;
        rate.rewardCoin = [NSNumber numberWithInt:kRewardCoinsForRatingApp];
        [optionsGetFreeCoin addObject:rate];
        
        maxFreeCoin = (maxFreeCoin < [rate.rewardCoin intValue]) ? [rate.rewardCoin intValue] : maxFreeCoin;
    }
    
    FreeCoinModel *share = [[FreeCoinModel alloc] init];
    share.imgName = @"fbicon.png";
    share.title = kTitleOfSharing;
    share.rewardCoin = [NSNumber numberWithInt:kRewardCoinsForSharingApp];

    [optionsGetFreeCoin addObject:share];
    maxFreeCoin = (maxFreeCoin < [share.rewardCoin intValue]) ? [share.rewardCoin intValue] : maxFreeCoin;
    
    if (![CommonFunction getLikeFanPage])
    {
        FreeCoinModel *fb = [[FreeCoinModel alloc] init];
        
        fb.imgName = @"fblike.png";
        fb.title = kTitleOfFacebookLike;
        fb.rewardCoin = [NSNumber numberWithInt:kRewardCoinsForLikingFB];
        [optionsGetFreeCoin addObject:fb];
        
        maxFreeCoin = (maxFreeCoin < [fb.rewardCoin intValue]) ? [fb.rewardCoin intValue] : maxFreeCoin;
    }
    
    [self.freeCoinCollectionView reloadData];
}


#pragma mark UICollectionView


#pragma mark UI Collection View


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return optionsGetFreeCoin.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FreecoinCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FreeCoinCell" forIndexPath:indexPath];
    
    cell.bgImg.layer.cornerRadius = 10;
    cell.bgImg.clipsToBounds = YES;
    cell.bgImg.layer.borderWidth = 2;
    cell.bgImg.layer.borderColor = [[UIColor yellowColor] CGColor];
    cell.priceLabel.layer.cornerRadius = 10;
    cell.priceLabel.clipsToBounds = YES;
    
    
    FreeCoinModel *model = [optionsGetFreeCoin objectAtIndex:indexPath.row];
    cell.imgView.image = [UIImage imageNamed:model.imgName];
    cell.coinLabel.text = model.title;
    cell.saveLabel.text = @"";
    cell.priceLabel.text = [NSString stringWithFormat:@"%d COINS", [model.rewardCoin intValue]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FreeCoinModel *model = [optionsGetFreeCoin objectAtIndex:indexPath.row];
    if ([model.title isEqualToString:kTitleOfFacebookLike])
    {
        if (!FBSession.activeSession.isOpen)
        {
            
            [UIView animateWithDuration:0.3 animations:^{
                [bodyView setFrame:CGRectOffset(bodyView.frame, -bodyView.frame.size.width, 0)];
                [freeCoinCollectionView setFrame:CGRectOffset(freeCoinCollectionView.frame, -bodyView.frame.size.width, 0)];
                [fbView setFrame:CGRectOffset(fbView.frame, -bodyView.frame.size.width, 0)];
                self.backBtn.alpha = 1;
            } completion:^(BOOL finished) {
                if (finished)
                {
                    
                }
            }];
        }else
        {
            [self closeBigView:nil];
            NSURL *url = [NSURL URLWithString:@"fb://profile/172415879600587"];
            [[UIApplication sharedApplication] openURL:url];
        }
    }else if ([model.title isEqualToString:kTitleOfSharing])
    {
        
        
        if( [UIActivityViewController class])
        {
            if ([[NSDate date] compare:[[CommonFunction getLastFBShare] dateByAddingTimeInterval:[CommonFunction timeToNextShare]]]==NSOrderedAscending)
            {
                [CommonFunction alert:[CommonFunction msgSharingNotAvail] delegate:nil];
            }else
            {
                APActivityProvider *ActivityProvider = [[APActivityProvider alloc] init];
                UIImage *ImageAtt = [UIImage imageNamed:@"fblike.png"];
                NSArray *Items = @[ActivityProvider, ImageAtt];
                
                
                UIActivityViewController *aVC = [[UIActivityViewController alloc] initWithActivityItems:Items applicationActivities:nil];
                NSMutableArray *listDisableItems = [[NSMutableArray alloc] initWithObjects:UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll, UIActivityTypePostToWeibo, UIActivityTypeMessage, UIActivityTypeMail,UIActivityTypeAirDrop ,nil];
                
                
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
                    //                    NSLog(@"activity Type : %@", activityType);
                    if (completed)
                    {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"You have claimed %d coins",kRewardCoinsForSharingApp] delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alertView show];
                        [CommonFunction setCoin:[CommonFunction getCoin]+kRewardCoinsForSharingApp];
                        
                        PlayController *play = (PlayController *)delegate;
                        [play updateCoininVIew];
                        
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
                if (kCheckIfIphone)
                {
                    
                }else
                {
                    FreecoinCollectionViewCell *cell = (FreecoinCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
                    aVC.popoverPresentationController.sourceView = cell;
                }
                PlayController *play = (PlayController *)delegate;
                [play presentViewController:aVC animated:YES completion:nil];
            }
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"We are sorry. This feature can only available in IOS 6 or above, please upgrade IOS to get free coins" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }
    else if ([model.title isEqualToString:kTitleOfRating])
    {
        
        [[UIApplication sharedApplication] openURL:[CommonFunction getAppURL]];
        [CommonFunction setRateUs:1];
    }
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
