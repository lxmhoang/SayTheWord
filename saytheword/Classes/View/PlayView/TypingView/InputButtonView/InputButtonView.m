//
//  InputButtonView.m
//  noitu
//
//  Created by Hoang le on 3/25/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import "InputButtonView.h"

@implementation InputButtonView
@synthesize lb;
@synthesize text, tagg;

- initWithText:(NSString *)_text andFrame:(CGRect)_frame andTag:(int)_i
{
    self = [super initWithFrame:_frame];
    if (self)
    {
        int fontSize = kCheckIfIphone ? 25 : 40;
        tagg=_i;
        text = _text;
        text = [text uppercaseString];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button.png"]];
        [imgView setFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
        [self addSubview:imgView];
        lb = [[UILabel alloc]initWithFrame:self.bounds];
        lb.text = text;
        [lb setFont:[UIFont fontWithName:@"Verdana-Bold" size:fontSize]];
        [lb setTextAlignment:NSTextAlignmentCenter];
        [lb setBackgroundColor:[UIColor clearColor]];
        [self addSubview:lb];
    }
    return self;
}

@end
