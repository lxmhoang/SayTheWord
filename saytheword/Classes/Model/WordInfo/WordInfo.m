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
        leftWord = __leftWord;
        rightWord = __rightWord;
        leftImg = __leftImg;
        rightImg = __rightImg;
        finalWord = __finalWord;
        dummyString = __initString;
        if (dummyString.length<11)
        {
            int k = 11-dummyString.length;
            for (int i=0;i<k;i++)
            {
                dummyString = [dummyString stringByAppendingString:@"A"];
            }
        }
    }
    return self;
}

@end
