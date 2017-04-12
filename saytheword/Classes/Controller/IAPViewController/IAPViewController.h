//
//  IAPViewController.h
//  saytheword
//
//  Created by Hoang Le on 9/24/14.
//  Copyright (c) 2014 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IAPHelper.h"
#import "MBProgressHUD.h"
@class StoreModel;

@protocol IAPControllerDelegate <NSObject>

- (void)updateCoininVIew;
- (void)dismissIAPVC;

@end

@interface IAPViewController : UIViewController <IAPHelperDelegate, MBProgressHUDDelegate, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    IBOutlet UITableView *coinTableView;
    IBOutlet UITableView *freeCoinTableView;
    IBOutlet UICollectionView *iapCollectionView;
    IBOutlet UICollectionView *freecoinCollectionView;
    StoreModel *storeModel;
    MBProgressHUD *HUD;
    IAPHelper *iAPHelper;
    float maxScale;
    NSMutableArray *optionsGetFreeCoin;
    
    BOOL finishAnimation, finishLoadProducts;
}
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, unsafe_unretained) id <IAPControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UIView *freeCoinView;
@property (strong, nonatomic) IBOutlet UIView *fbView;
- (IBAction)cancelBtnAction:(id)sender;
- (IBAction)backBtnAction:(id)sender;

@end
