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
    UIView *bigView;
}


@property (nonatomic, assign)  id<HintsViewDelegate> delegate;


- (void)bloat;




@end
