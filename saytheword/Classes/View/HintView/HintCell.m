//
//  HintCell.m
//  1word2pics
//
//  Created by Hoang le on 4/22/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import "HintCell.h"

@implementation HintCell

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

- (void)showCoin:(NSString *)_amount
{
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Star_Coin.jpg"]];
    [imgView setBackgroundColor:[UIColor clearColor]];
    [imgView setFrame:CGRectMake(240-45, 15, 40, 40)];
    [self addSubview:imgView];
    [imgView release];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(240-50-60, 15, 60, 40)];
    lb.textAlignment = NSTextAlignmentRight;
    lb.text = _amount;
    [self addSubview:lb];
    [lb release];
}

@end
