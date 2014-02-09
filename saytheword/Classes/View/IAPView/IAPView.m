//
//  IAPView.m
//  saytheword
//
//  Created by Hoang Le on 7/10/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "IAPView.h"

@implementation IAPView
@synthesize productIdentifier, delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
    }
    return self;
}

- (void)IAPselected:(UITapGestureRecognizer *)_sender
{
    [delegate IAPselected:_sender];
}


- (void)makeViews
{

    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(IAPselected:)];
    [self addGestureRecognizer:_tap];
    [_tap release];
    if ([productIdentifier isEqualToString:kProductIDOf200])
    {

        
        bgImgName = @"coin1.png";
        [self setFrame:CGRectMake(31, 24, 28 , 30)];
    }else if ([productIdentifier isEqualToString:kProductIDOf420])
    {
        bgImgName = @"coin 2.png";
        [self setFrame:CGRectMake(60, 24, 27 , 30)];
    }else if ([productIdentifier isEqualToString:kProductIDOf1085])
    {
        bgImgName = @"coin3.png";
        [self setFrame:CGRectMake(3, 60, 27 , 30)];
    }else if ([productIdentifier isEqualToString:kProductIDOf2350])
    {
        bgImgName = @"coin 4.png";
        [self setFrame:CGRectMake(31, 60, 28 , 30)];
    }else if ([productIdentifier isEqualToString:kProductIDOf7150])
    {
//        bgImgName = @"coin 4.png";
//        [self setFrame:CGRectMake(31, 60, 28 , 30)];
    }else if ([productIdentifier isEqualToString:@"FreeCoins"])
    {
        bgImgName = @"coin 5.png";
        [self setFrame:CGRectMake(3, 24, 27, 30)];
    }else if ([productIdentifier isEqualToString:@"diamond"])
    {
        bgImgName = @"coin 6.png";
        [self setFrame:CGRectMake(60, 60, 27 , 30)];
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"string not found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
    
    [self setBackgroundColor:[UIColor clearColor]];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
    [imgView setImage:[UIImage imageNamed:bgImgName]];
    [self addSubview:imgView];
    [imgView release];
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(4, 23, 19, 7)];
    [lb setBackgroundColor:[UIColor clearColor]];
    lb.text = bgImgName;
    lb.font = [UIFont fontWithName:@"Arial" size:4];
    [self addSubview:lb];
    [lb release];
    
}

- (id)initWithProductIdentifier:(NSString *)PI
{
    self = [super init];
    if (self)
    {
        productIdentifier = [NSString stringWithString:PI];
        [self makeViews];
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
