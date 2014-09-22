//
//  RootView.m
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//
//#define kFileNameRootViewBackGround @"bgip5.jpg"


#import "RootView.h"

@implementation RootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (IS_IPHONE_5){
            [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:bgImage]]];

        }else{
             [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:bgImage]]];
        }
        // Initialization code
//        [self setBackgroundColor:blColor];
    }
//    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [v1 setBackgroundColor:[UIColor colorWithRed:203/255.0f green:122/255.0f blue:38/255.0f alpha:1.0f]];
//    [self addSubview:v1];
//    [v1 release];
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
