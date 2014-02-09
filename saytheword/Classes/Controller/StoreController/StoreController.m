//
//  StoreController.m
//  1word2pics
//
//  Created by Hoang le on 3/27/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import "StoreController.h"

@interface StoreController ()

@end

@implementation StoreController
@synthesize listItems, delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        storeModel = [[StoreModel alloc]init];
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
    }
    return self;
}

- (void)viewDidLoad
{
    iAPHelper = [[IAPHelper alloc]init];
    iAPHelper.delegate = self;
    
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"Please Wait";
	HUD.detailsLabelText = @"Connecting to App Store ....";
	HUD.square = YES;
    [HUD show:YES];
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [iAPHelper loadStore];
}

- (void)doBuy
{
    //    [iAPHelper purchaseItem];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark iaphelperDelegate

- (void)IAPFailed{
    [HUD hide:YES];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Cannot connect to Itunes, please check your Internet Connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
    [self dismissVC];
}

- (void)finishTransaction
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setListProducts:(NSArray *)listProducts
{
    [storeModel importData:listProducts];
//    storeView = [[StoreView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) andData:storeModel];
//    storeView.delegate = self;
//    [self.view addSubview:storeView];
//    [storeView release];
//    int height = [storeModel.listItems count]*kHeightOfRowStoreItem+kHeightOfTopBarPopUpIAP;
//    storeView.frame = CGRectMake(40, (kHeightOfScreen-height)/2, 240, height);
//    [storeView showTableView];
    storesView = [[StoresView alloc] initWithFrame:self.view.bounds andData:storeModel];
    storesView.delegate = self;
    [self.view addSubview:storesView];
    [storesView showUp];
    [storesView release];
    
    
    [HUD hide:YES];
}

#pragma  StoreView delegate method

- (void)buyItem:(NSString *)_productIdentifier
{
    if ([iAPHelper canMakePurchase])
    {
        [iAPHelper purchaseItem];
        
        //        NSLog(@"zzz");
    }else{
        NSLog(@"this purchase is disable");
    }
}

- (void)afterTransaction
{
    [delegate updateCoininVIew];
    [self dismissVC];
}

- (void)dismissVC
{
    [self.view removeFromSuperview];
    //    [storeModel release];
    //    [storeView release];
    //    [iAPHelper release];
    //    [listItems release];
    [self removeFromParentViewController];
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Storesview delegate method

- (void)dismissStoreController
{
    [self dismissVC];
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [delegate updateCoininVIew];
    [self dismissVC];
}

@end
