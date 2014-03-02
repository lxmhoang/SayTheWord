//
//  StoreController.h
//  1word2pics
//
//  Created by Hoang le on 3/27/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreView.h"
#import "StoresView.h"
#import "StoreModel.h"
#import <StoreKit/StoreKit.h>
#import "IAPHelper.h"
#import "MBProgressHUD.h"

@protocol StoreControllerDelegate <NSObject>

- (void)updateCoininVIew;

@end

@interface StoreController : UIViewController<StoreViewDelegate, StoresViewDelegate, IAPHelperDelegate, MBProgressHUDDelegate, UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
    IAPHelper *iAPHelper;
    StoreView *storeView;
    StoresView *storesView;
    StoreModel *storeModel;
}

@property (nonatomic, retain) NSArray *listItems;
@property (nonatomic, assign)  id delegate;
//- (id)initWithArray:(NSArray *)_array;

@end
