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
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.frame];
        [bgImgView setImage:[UIImage imageNamed:bgImage]];
        [self addSubview:bgImgView];
//        if (IS_IPHONE_5){
//            [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:bgImage]]];
//
//        }else{
//             [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:bgImage]]];
//        }
        // Initialization code
//        [self setBackgroundColor:blColor];
    }

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
