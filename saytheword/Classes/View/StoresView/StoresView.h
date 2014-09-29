//
//  StoresView.h
//  saytheword
//
//  Created by Hoang Le on 7/10/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"
#import "Common.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "StoreCell.h"
#import "IAPView.h"
#import "ApActivityData.h"
#import "FreeCoinView.h"



#import "FacebookActivity.h"

@protocol StoresViewDelegate <NSObject>

- (void)buyItem:(NSString *)_str;
- (void)dismissStoreController;

@end

@interface StoresView : UIView <MBProgressHUDDelegate, IAPViewDelegate>
{
    StoreModel *storeModel;
    MBProgressHUD *HUD;
    UIView *bigView;
}

@property (nonatomic, unsafe_unretained) id delegate;

- (id)initWithFrame:(CGRect)frame andData:(StoreModel *)_data;



- (void)showUp;

@end
