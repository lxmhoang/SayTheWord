//
//  StoreView.h
//  1word2pics
//
//  Created by Hoang le on 3/27/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"
#import "Common.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "StoreCell.h"

@protocol StoreViewDelegate <NSObject>

- (void)buyItem:(NSString *)_str;

@end

@interface StoreView : UIView<UITableViewDelegate, UITableViewDataSource, MBProgressHUDDelegate>
{
    StoreModel *storeModel;
    UITableView *tableView;
    MBProgressHUD *HUD;
}

@property (nonatomic, assign) id delegate;

- (id)initWithFrame:(CGRect)frame andData:(StoreModel *)_data;

- (void)createSubViews;

- (void)showTableView;

@end
