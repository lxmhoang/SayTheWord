//
//  StoreCell.m
//  1word2pics
//
//  Created by Hoang Le on 5/11/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import "StoreCell.h"

@implementation StoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showPrice:(NSString *)_amount saving:(NSString *)_saving
{
//    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Star_Coin.jpg"]];
//    [imgView setFrame:CGRectMake(240-50, 15, 40, 40)];
//    [self addSubview:imgView];
//    [imgView release];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(240-50-60, 5, 60, 35)];
    if ([_saving isEqualToString:@""])
    {
        [lb setFrame:CGRectMake(240-50-60, 15, 60, 35)];
    }
//    [lb setBackgroundColor:[UIColor redColor]];
    lb.textAlignment = NSTextAlignmentRight;
    lb.text = _amount;
    [self addSubview:lb];
    [lb release];
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(240-50-60, 5+35, 60, 20)];
    lb2.textAlignment = NSTextAlignmentRight;
    [lb2 setFont:[UIFont fontWithName:@"ArialMT" size:10.0f]];
    lb2.text = [NSString stringWithFormat:@"Save %@",_saving];
    if (![_saving isEqualToString:@""])
    {
        [self addSubview:lb2];
    }
    [lb2 release];
}

@end
