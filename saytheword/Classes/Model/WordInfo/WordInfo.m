//
//  WordInfo.m
//  saytheword
//
//  Created by Hoang Le on 6/10/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "WordInfo.h"

@implementation WordInfo

@synthesize level, leftImg, leftWord, rightImg, rightWord, finalWord, dummyString;

- (id)initWithUniqueLevel:(int)uniqueLevel leftWord:(NSString *)__leftWord leftImg:(NSString *)__leftImg rightWord:(NSString *)__rightWord rightImg:(NSString *)__rightImg finalWord:(NSString *)__finalWord initString:(NSString *)__initString
{
    if (self = [super init]){
        level = uniqueLevel;
        leftWord = [__leftWord retain];
        rightWord = [__rightWord retain];
        leftImg = [__leftImg retain];
        rightImg = [__rightImg retain];
        NSLog(@"right img : %@",rightImg);
        finalWord = [__finalWord retain];
        dummyString = [__initString retain];
    }
    return self;
}

@end
