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

#import <QuartzCore/QuartzCore.h>

@protocol HintsViewDelegate <NSObject>

- (void)removeALetterFromHintsView;
- (void)revealALetterFromHintsView;
- (void)revealLeftWordFromHintsView;
- (void)revealRightWordFromHintsView;
- (void)revealAnswerWordFromHintsView;

@end

@interface HintsView : UIView  
{
}

@property (strong, nonatomic) IBOutlet UIView *bigView;

@property (nonatomic, unsafe_unretained)  id<HintsViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *view11;
@property (strong, nonatomic) IBOutlet UIView *view12;
@property (strong, nonatomic) IBOutlet UIView *view13;
@property (strong, nonatomic) IBOutlet UIView *view21;
@property (strong, nonatomic) IBOutlet UIView *view22;

@property (strong, nonatomic) IBOutlet UIView *view23;

@property (strong, nonatomic) IBOutlet UIImageView *askFriendIcon;
@property (strong, nonatomic) IBOutlet UILabel *freeCoinIcon;

@property (strong, nonatomic) IBOutlet UIView *coinView11,*coinView12,*coinView13,*coinView21,*coinView22,*coinView23;

- (IBAction)closeBigView:(id)sender;

- (void)bloat;

- (void)setUp;


- (IBAction)removeLetter:(UITapGestureRecognizer *)_sender;

- (IBAction)revealLetter:(UITapGestureRecognizer *)_sender;

- (IBAction)showLeftTitle:(UITapGestureRecognizer *)_sender;

- (IBAction)showRightTitle:(UITapGestureRecognizer *)_sender;






@end
