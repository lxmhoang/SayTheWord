//
//  HintView.h
//  1word2pics
//
//  Created by Hoang le on 4/5/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "PlayModel.h"
#import "HintCell.h"
#import <QuartzCore/QuartzCore.h>

@protocol HintViewDelegate <NSObject>

- (void)shareFBFromHint;
- (void)shareFB:(UIGestureRecognizer *)_tap;
- (void)removeALetterFromHintView;
- (void)revealALetterFromHintView;
- (void)revealLeftWordFromHintView;
- (void)revealRightWordFromHintView;


@end

@interface HintView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableView;

}

@property (nonatomic, assign)  id delegate;




@end
