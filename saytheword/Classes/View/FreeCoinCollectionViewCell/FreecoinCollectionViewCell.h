//
//  FreecoinCollectionViewCell.h
//  saytheword
//
//  Created by Hoang Le on 10/4/14.
//  Copyright (c) 2014 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreecoinCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UIView *rmvAdsView;
@property (strong, nonatomic) IBOutlet UILabel *coinLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *saveLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bgImg;
@property (strong, nonatomic) IBOutlet UILabel *freeCoinLabel;

@end
