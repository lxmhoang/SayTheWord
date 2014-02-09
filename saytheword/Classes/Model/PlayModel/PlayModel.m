//
//  PlayModel.m
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "PlayModel.h"

@implementation PlayModel

@synthesize position, wordInfo;

- (id)initWithPosition:(int)_pos andLevel:(int)_level
{
    self = [super init];
    if (self){
        position = _pos;
        wordInfo = [[WordDatabase database] wordInfoWithLevel:_level];
    }
    return self;
    
}

- (void)removeCharInDB:(int)_r
{
    NSString *newInitString = [NSString stringWithString:[wordInfo.dummyString stringByReplacingCharactersInRange:NSMakeRange(_r-kRandomNumber,1) withString:@"*"]];
    
    wordInfo.dummyString = [NSString stringWithFormat:@"%@",newInitString];
    [[WordDatabase database] updateInitString:newInitString atLevel:[CommonFunction getLevel]];

}

@end
