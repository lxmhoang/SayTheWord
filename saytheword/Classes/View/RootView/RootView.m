//
//  RootView.m
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "RootView.h"

@implementation RootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (IS_IPHONE_5){
            [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kFileNameRootViewBackGround]]];

        }else{
             [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgip5.jpg"]]];
        }
        // Initialization code
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
