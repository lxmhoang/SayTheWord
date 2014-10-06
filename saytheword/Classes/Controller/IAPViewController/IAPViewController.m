//
//  IAPViewController.m
//  saytheword
//
//  Created by Hoang Le on 9/24/14.
//  Copyright (c) 2014 Hoang Le. All rights reserved.
//

#import "IAPViewController.h"
#import "MBProgressHUD.h"
#import "IAPHelper.h"
#import "IAPTableViewCell.h"
#import "StoreModel.h"

#import "IAPCollectionViewCell.h"

#import "FreeCoinTableViewCell.h"
#import "FreecoinCollectionViewCell.h"
#import "FreeCoinModel.h"

#import "ApActivityData.h"

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT


@interface IAPViewController ()

@end

@implementation IAPViewController
@synthesize bigView, delegate, fbView, cancelBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *nibName = kCheckIfIphone ? @"IAPCollectionViewCell" : @"IAPCollectionViewCell_iPad";
    
    UINib *cellNib = [UINib nibWithNibName:nibName bundle:nil];
    [iapCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"IAPCell"];
    cellNib = [UINib nibWithNibName:@"FreecoinCollectionViewCell" bundle:nil];
    [freecoinCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"FreeCoinCell"];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
    bigView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];

    bigView.layer.cornerRadius = 15;
    bigView.clipsToBounds = YES;
    bigView.layer.borderWidth = 2;
    bigView.layer.borderColor = [[UIColor yellowColor] CGColor];
    
    storeModel = [[StoreModel alloc]init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *arr = [appDelegate getIAP];
    if (arr && arr.count>0)
    {
        [self bindIAPData:[appDelegate getIAP]];
    }else
    {
        NSLog(@"bitch");
        
        iAPHelper = [[IAPHelper alloc]init];
        iAPHelper.delegate = self;
        cancelBtn.enabled = NO;
        
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [iapCollectionView addSubview:HUD];
        
        HUD.delegate = self;
        HUD.detailsLabelText = @"Connecting to App Store ....";
        [HUD hide:YES];
        
        [iAPHelper loadStore];
    }
    
    int y = bigView.frame.origin.y;
    
    [bigView setFrame:CGRectMake(bigView.frame.origin.x, -bigView.frame.size.height, bigView.frame.size.width, bigView.frame.size.height)];
    
    int k = kCheckIfIphone ? 10 : 25;
    
//    [bigView setFrame:CGRectMake(bigView.frame.origin.x, y + k, bigView.frame.size.width, bigView.frame.size.height)];
    [UIView animateWithDuration:0.2 animations:^{
        
        [bigView setFrame:CGRectMake(bigView.frame.origin.x, y + k, bigView.frame.size.width, bigView.frame.size.height)];
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
                   [bigView setFrame:CGRectMake(bigView.frame.origin.x, y-k, bigView.frame.size.width, bigView.frame.size.height)];
        } completion:^(BOOL finished) {
        }];
        
        
    }
     ];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self createOptionGetFreeCoin];
    
    [freecoinCollectionView reloadData];

}

- (void)createOptionGetFreeCoin
{
    
    optionsGetFreeCoin = [[NSMutableArray alloc] init];
    
    
    if ([CommonFunction checkIfRateForCoin] && [CommonFunction getRateUS] == 0)
    {
        FreeCoinModel *rate = [[FreeCoinModel alloc] init];
        rate.imgName = @"star_rate.png";
        rate.title = kTitleOfRating;
        rate.rewardCoin = [NSNumber numberWithInt:[CommonFunction getRewardCoinForRattingApp]];
        [optionsGetFreeCoin addObject:rate];
    }
    
    FreeCoinModel *share = [[FreeCoinModel alloc] init];
    share.imgName = @"fbicon.png";
    share.title = kTitleOfSharing;
    share.rewardCoin = [NSNumber numberWithInt:[CommonFunction getRewardCoinForSharingApp]];
    [optionsGetFreeCoin addObject:share];
    
    if (![CommonFunction getLikeFanPage])
    {
        FreeCoinModel *fb = [[FreeCoinModel alloc] init];
        
        fb.imgName = @"fblike.png";
        fb.title = kTitleOfFacebookLike;
        fb.rewardCoin = [NSNumber numberWithInt:[CommonFunction getRewardCoinForLikingPage]];
        [optionsGetFreeCoin addObject:fb];
    }

    

}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.view.superview.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidUnload {
    [self setBigView:nil];
    coinTableView = nil;
    [self setFreeCoinView:nil];
    [self setBackBtn:nil];
    freeCoinTableView = nil;
    iAPHelper = nil;
    [self setFbView:nil];
    [super viewDidUnload];
    
}
- (IBAction)cancelBtnAction:(id)sender {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [delegate dismissIAPVC];
}

- (IBAction)backBtnAction:(id)sender {
    BOOL hideBackBtn = (iapCollectionView.frame.origin.x == -iapCollectionView.frame.size.width) ? YES : NO;
    [UIView animateWithDuration:0.3 animations:^{
        [iapCollectionView setFrame:CGRectOffset(iapCollectionView.frame, +iapCollectionView.frame.size.width, 0)];
        [freecoinCollectionView setFrame:CGRectOffset(freecoinCollectionView.frame, +iapCollectionView.frame.size.width, 0)];
        [fbView setFrame:CGRectOffset(fbView.frame, +iapCollectionView.frame.size.width, 0)];
        
        if (hideBackBtn)
        {
            self.backBtn.alpha = 0;
        }
        
    } completion:^(BOOL finished) {
        if (finished)
        {
        }
    }];
}

- (void)bindIAPData:(NSArray *)productList
{
    storeModel = [[StoreModel alloc] init];
    maxScale = 0.001;
    for (SKProduct *prod in productList)
    {
        
        if ([self scaleOfProduct:prod]>maxScale)
            maxScale = [self scaleOfProduct:prod];
    }
    [storeModel importData:productList];
//    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"shit");
        [iapCollectionView reloadData];
//    });
    cancelBtn.enabled = YES;
}

#pragma mark iaphelperDelegate

- (void)IAPFailed{
    [HUD hide:YES];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Unable to connect App Stores, please check Internet Connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)finishTransaction
{
    [self cancelBtnAction:nil];
    
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

- (float)scaleOfProduct:(SKProduct *)prod
{
    NSCharacterSet *charSet = [NSCharacterSet decimalDigitCharacterSet];
    NSScanner *scanner = [NSScanner scannerWithString:prod.productIdentifier];
    [scanner scanUpToCharactersFromSet:charSet intoString:nil];
    float coin;
    [scanner scanFloat:&coin];
    float scale = [prod.price floatValue]/coin;
    return scale;
}

- (void)setListProducts:(NSArray *)listProducts
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [HUD hide:YES];
        [HUD removeFromSuperview];
        
        [self bindIAPData:listProducts];
    });
    
}

#pragma  StoreView delegate method

- (void)buyItem:(NSString *)_productIdentifier
{
    if ([iAPHelper canMakePurchase])
    {
        [iAPHelper purchaseItem];
        
        //        NSLog(@"zzz");
    }else{
//        NSLog(@"this purchase is disable");
    }
}

- (void)afterTransaction
{
//    [CommonFunction alert:@"Thank you" delegate:self];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [delegate updateCoininVIew];
        
        [self dismissVC];
    });
    
}

- (void)dismissVC
{
    [self cancelBtnAction:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [delegate updateCoininVIew];
    [self dismissVC];
}

#pragma mark uitableview 


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int k;
    if (tableView == freeCoinTableView)
    {
        k = kCheckIfIphone ?  60 : 120;
        return k;
    }
    
    k = kCheckIfIphone ?  44 : 88;
    return k;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == coinTableView)
    {
        if (storeModel.listItems)
        {
            return storeModel.listItems.count+1;
        }else
        {
            return 0;
        }
    }else if (tableView == freeCoinTableView)
    {
        return optionsGetFreeCoin.count;
    }else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_tableView == coinTableView)
    {
        IAPTableViewCell *cell = (IAPTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:@"IAPCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell == nil)
        {
            NSString *nibName = kCheckIfIphone ? @"IAPTableViewCell" : @"IAPTableViewCell_iPad";
            [_tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:@"IAPCell"];
            cell =(IAPTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:@"IAPCell"];
            
        }
        
        cell.priceLabel.layer.cornerRadius = 10;
        cell.priceLabel.clipsToBounds = YES;
        if (indexPath.row >0)
        {
            SKProduct *product = [storeModel.listItems objectAtIndex:indexPath.row-1];
            
            NSString *title = product.localizedTitle;
            if ([product.productIdentifier isEqualToString:kProductIDOf1100]
                || [product.productIdentifier isEqualToString:kProductIDOf2400]
                || [product.productIdentifier isEqualToString:kProductIDOf7800]
                
                )
            {
                cell.noAdsView.alpha = 1;
                
            }else
            {
                cell.noAdsView.alpha = 0;
            }
            
            title = [title stringByReplacingOccurrencesOfString:@"coins" withString:@"Coins"];
            
            
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
            [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            [numberFormatter setLocale:product.priceLocale];
            NSString *formattedPrice = [numberFormatter stringFromNumber:product.price];
            
            cell.priceLabel.text = formattedPrice;
            //    cell.titleLabel.text = product.productIdentifier;
            
            float scale = [self scaleOfProduct:product];
            float save = 1/(scale/maxScale)-1;
            save =save*100+1;
            if (save > 2)
            {
                cell.saveLabel.text = [NSString stringWithFormat:@"Save %.0f %%",save];
                
                cell.titleLabel.text = title;
            }else
            {
                
                cell.titleAloneLabel.text = title;
            }
        }else
        {

            cell.titleAloneLabel.text = @"20 coins";
            cell.priceLabel.backgroundColor = [UIColor redColor];
            cell.priceLabel.textColor = [UIColor yellowColor];
            cell.priceLabel.text = @"FREE";
        }
        
        return cell;
    }else if (_tableView == freeCoinTableView)
    {
        FreeCoinTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"FreeCoinCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell == nil)
        {
            NSString *nibName = kCheckIfIphone ? @"FreeCoinTableViewCell" : @"FreeCoinTableViewCell_iPad";
            [_tableView registerNib:[UINib nibWithNibName:nibName bundle:nil ] forCellReuseIdentifier:@"FreeCoinCell"];
//            [_tableView registerNib:[UINib nibWithNibName:@"FreeCoinTableViewCell" bundle:nil] forCellReuseIdentifier:@"FreeCoinCell"];
            cell =(FreeCoinTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:@"FreeCoinCell"];
        }
        FreeCoinModel *model = [optionsGetFreeCoin objectAtIndex:indexPath.row];
        cell.imgView.image = [UIImage imageNamed:model.imgName];
        cell.titleLabel.text = model.title;
        cell.amountCoin.text = [NSString stringWithFormat:@"%d", [model.rewardCoin intValue]];
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableView == coinTableView)
    {
    if (indexPath.row == 0)// tap on free coin
    {
        [UIView animateWithDuration:0.3 animations:^{
            [coinTableView setFrame:CGRectOffset(coinTableView.frame, -coinTableView.frame.size.width, 0)];
            [freeCoinTableView setFrame:CGRectOffset(freeCoinTableView.frame, -coinTableView.frame.size.width, 0)];
            [fbView setFrame:CGRectOffset(fbView.frame, -coinTableView.frame.size.width, 0)];
             self.backBtn.alpha = 1;
        } completion:^(BOOL finished) {
            if (finished)
            {
               
            }
        }];
    }else
    {
        SKProduct *selectedProduct = [storeModel.listItems objectAtIndex:indexPath.row-1];
        SKPayment *payment = [SKPayment paymentWithProduct:selectedProduct];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    }else if (_tableView == freeCoinTableView)
    {
        FreeCoinModel *model = [optionsGetFreeCoin objectAtIndex:indexPath.row];
        if ([model.title isEqualToString:kTitleOfFacebookLike])
        {
            if (!FBSession.activeSession.isOpen)
            {
                
                [UIView animateWithDuration:0.3 animations:^{
                    [coinTableView setFrame:CGRectOffset(coinTableView.frame, -coinTableView.frame.size.width, 0)];
                    [freeCoinTableView setFrame:CGRectOffset(freeCoinTableView.frame, -coinTableView.frame.size.width, 0)];
                    [fbView setFrame:CGRectOffset(fbView.frame, -coinTableView.frame.size.width, 0)];
                    self.backBtn.alpha = 1;
                } completion:^(BOOL finished) {
                    if (finished)
                    {
                        
                    }
                }];
            }else
            {
                [self cancelBtnAction:nil];
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
                
                
                
//                if ([[NSDate date] compare:[[CommonFunction getLastFBShare] dateByAddingTimeInterval:[CommonFunction timeToNextShare]]]==NSOrderedAscending)
//                {
//                    [listDisableItems addObject:UIActivityTypePostToFacebook];
//                }
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
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"You have claimed %d coins",[CommonFunction getRewardCoinForSharingApp]] delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alertView show];
                        [CommonFunction setCoin:[CommonFunction getCoin]+[CommonFunction getRewardCoinForSharingApp]];
                        [delegate updateCoininVIew];
                        
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
                    FreeCoinTableViewCell *cell = (FreeCoinTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
                    aVC.popoverPresentationController.sourceView = cell.titleLabel;
                }
                [self presentViewController:aVC animated:YES completion:nil];
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
}

#pragma mark UI Collection View


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == iapCollectionView)
    {
        if (storeModel.listItems)
        {
            return storeModel.listItems.count+1;
        }else
        {
            return 0;
        }
    }else if (collectionView == freecoinCollectionView)
    {
        return optionsGetFreeCoin.count;
    }else
        return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == iapCollectionView)
    {
        
        IAPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IAPCell" forIndexPath:indexPath];
        
        if (cell!=nil)
        {
            cell.bgImg.layer.cornerRadius = 10;
            cell.bgImg.clipsToBounds = YES;
            cell.bgImg.layer.borderWidth = 2;
            if (indexPath.row >0)
            {
                cell.bgImg.layer.borderColor = [[UIColor yellowColor] CGColor];
            }else
            {
                cell.bgImg.layer.borderColor = [[UIColor redColor] CGColor];
                
            }
            cell.priceLabel.layer.cornerRadius = 10;
            cell.priceLabel.clipsToBounds = YES;
            if (indexPath.row >0)
            {
                SKProduct *product = [storeModel.listItems objectAtIndex:indexPath.row-1];
                
                long index = indexPath.row - 1;
                index = index*2+1;
                NSString *imgName = [NSString stringWithFormat:@"coin%ld.png",index];
                
                [cell.imgView setImage:[UIImage imageNamed:imgName]];
//                NSLog(@"indexpath : %ld-%ld  img name : %@ cell : %@", (long)indexPath.section, (long)indexPath.row,imgName, cell);
                NSString *title = product.localizedTitle;
                if ([product.productIdentifier isEqualToString:kProductIDOf1100]
                    || [product.productIdentifier isEqualToString:kProductIDOf2400]
                    || [product.productIdentifier isEqualToString:kProductIDOf7800]
                    
                    )
                {
                    cell.rmvAdsView.alpha = 1;
                    
                }else
                {
                    cell.rmvAdsView.alpha = 0;
                }
                
                cell.freeCoinLabel.alpha = 0;
                
                title = [title stringByReplacingOccurrencesOfString:@"coins" withString:@"Coins"];
                
                //    cell.titleLabel.text = product.productIdentifier;
                
                float scale = [self scaleOfProduct:product];
                float save = 1/(scale/maxScale)-1;
                save =save*100+1;
                if (save > 2)
                {
                    cell.saveLabel.text = [NSString stringWithFormat:@"Save %.0f %%",save];
                    
                    
                }else
                {
                    
                    cell.saveLabel.text = @"";
                }
                
                cell.coinLabel.text = title;
                
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
                [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                [numberFormatter setLocale:product.priceLocale];
                NSString *formattedPrice = [numberFormatter stringFromNumber:product.price];
                
                cell.priceLabel.text = formattedPrice;
                return cell;
                
            }else if (indexPath.row == 0)
            {
//                NSLog(@"indexpath : %ld-%ld  img name : %@ cell : %@", (long)indexPath.section, (long)indexPath.row,@"none",cell);
                cell.rmvAdsView.alpha = 0;
                cell.freeCoinLabel.alpha = 1;
                cell.freeCoinLabel.layer.cornerRadius = 10;
                cell.freeCoinLabel.layer.borderColor = [[UIColor yellowColor] CGColor];
                cell.freeCoinLabel.layer.borderWidth = 2;
                cell.imgView.alpha = 0;
                cell.coinLabel.text = @"20 coins";
                cell.priceLabel.backgroundColor = [UIColor redColor];
                cell.saveLabel.text = @"";
                cell.priceLabel.textColor = [UIColor yellowColor];
                cell.priceLabel.text = @"FREE";
                return cell;
            }
            return cell;
        }
        
        return cell;
    }else if (collectionView == freecoinCollectionView)
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
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == iapCollectionView)
    {
        if (indexPath.row == 0)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [iapCollectionView setFrame:CGRectOffset(iapCollectionView.frame, -iapCollectionView.frame.size.width, 0)];
                [freecoinCollectionView setFrame:CGRectOffset(freecoinCollectionView.frame, -iapCollectionView.frame.size.width, 0)];
                [fbView setFrame:CGRectOffset(fbView.frame, -iapCollectionView.frame.size.width, 0)];
                self.backBtn.alpha = 1;
            } completion:^(BOOL finished) {
                if (finished)
                {
                    
                }
            }];
        }else
        {
            SKProduct *selectedProduct = [storeModel.listItems objectAtIndex:indexPath.row-1];
            SKPayment *payment = [SKPayment paymentWithProduct:selectedProduct];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
    }else if (collectionView == freecoinCollectionView)
    {
        FreeCoinModel *model = [optionsGetFreeCoin objectAtIndex:indexPath.row];
        if ([model.title isEqualToString:kTitleOfFacebookLike])
        {
            if (!FBSession.activeSession.isOpen)
            {
                
                [UIView animateWithDuration:0.3 animations:^{
                    [iapCollectionView setFrame:CGRectOffset(iapCollectionView.frame, -iapCollectionView.frame.size.width, 0)];
                    [freecoinCollectionView setFrame:CGRectOffset(freecoinCollectionView.frame, -iapCollectionView.frame.size.width, 0)];
                    [fbView setFrame:CGRectOffset(fbView.frame, -iapCollectionView.frame.size.width, 0)];
                    self.backBtn.alpha = 1;
                } completion:^(BOOL finished) {
                    if (finished)
                    {
                        
                    }
                }];
            }else
            {
                [self cancelBtnAction:nil];
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
                    return;
                }else
                {

                    UIView *ap;
                    if (kCheckIfIphone)
                    {
                        ap = nil;
                    }else
                    {
                        ap = (UIView *)[collectionView cellForItemAtIndexPath:indexPath];
                    }
                    
                    UIImage *ImageAtt = [CommonFunction getScreenShot];
                    [CommonFunction shareWithImage:ImageAtt andMessage:[CommonFunction getMessageShareApp] withArchorPoint:ap inViewController:self completion:^{
                        
                        
                        if ([CommonFunction getRewardCoinForSharingApp] > 0)
                        {
                            NSString *str =[NSString stringWithFormat:@"You have claimed %d coins",[CommonFunction getRewardCoinForSharingApp]];
                            [CommonFunction alert:str delegate:nil];
                            [CommonFunction setCoin:[CommonFunction getCoin]+[CommonFunction getRewardCoinForSharingApp]];
                            
                            [delegate updateCoininVIew];
                        }else
                        {
                            
                        }
                        
                        
                        [self cancelBtnAction:nil];
                    }];
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
}


#pragma mark - FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // first get the buttons set for login mode
    
    if (fbView.frame.origin.x == 0)
    {
        
        [self backBtnAction:nil];
    }
    
//    BOOL hideBackBtn = (coinTableView.frame.origin.x == -coinTableView.frame.size.width) ? YES : NO;
//    [UIView animateWithDuration:0.3 animations:^{
//        [coinTableView setFrame:CGRectOffset(coinTableView.frame, +coinTableView.frame.size.width, 0)];
//        [freeCoinTableView setFrame:CGRectOffset(freeCoinTableView.frame, +coinTableView.frame.size.width, 0)];
//        [fbView setFrame:CGRectOffset(freeCoinTableView.frame, +coinTableView.frame.size.width, 0)];
//        
//        if (hideBackBtn)
//        {
//            self.backBtn.alpha = 0;
//        }
//        
//    } completion:^(BOOL finished) {
//        if (finished)
//        {
//            NSURL *url = [NSURL URLWithString:@"fb://profile/172415879600587"];
//            [[UIApplication sharedApplication] openURL:url];
//        }
//    }];
    
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    NSString *str = [user objectForKey:@"link"];
    [CommonFunction setFBLink:str];
    
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
//    NSLog(@"logged out");
    // test to see if we can use the share dialog built into the Facebook application
//    FBShareDialogParams *p = [[FBShareDialogParams alloc] init];
//    p.link = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
#ifdef DEBUG
//    [FBSettings enableBetaFeatures:FBBetaFeaturesShareDialog];
#endif
    //    BOOL canShareFB = [FBDialogs canPresentShareDialogWithParams:p];
    //    BOOL canShareiOS6 = [FBDialogs canPresentOSIntegratedShareDialogWithSession:nil];
    //
    
    // "Post Status" available when logged on and potentially when logged off.  Differentiate in the label.
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
    if ([[error.userInfo objectForKey:@"com.facebook.sdk:ErrorLoginFailedReason"] isEqualToString:@"com.facebook.sdk:SystemLoginDisallowedWithoutError"])
    {
        [CommonFunction alert:@"On your device, please go to Setting->Facebook->Allow this app to use your facebook account" delegate:nil];
    }
}





@end
