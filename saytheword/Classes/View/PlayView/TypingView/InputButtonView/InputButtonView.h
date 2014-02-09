//
//  InputButtonView.h
//  noitu
//
//  Created by Hoang le on 3/25/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputButtonView : UIView
{
  
}

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UILabel *lb;
@property (nonatomic) int tagg;


- initWithText:(NSString *)text andFrame:(CGRect)_frame andTag:(int)_i;

@end
