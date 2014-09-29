//
//  WordInfo.h
//  saytheword
//
//  Created by Hoang Le on 6/10/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordInfo : NSObject
{
    int _level;
    NSString *_leftWord;
    NSString *_leftImg;
    NSString *_rightWord;
    NSString *_rightImg;
    NSString *_finalWord;
    NSString *_initString;
}

@property (nonatomic, assign) int level;
@property (nonatomic, strong) NSString *leftWord;
@property (nonatomic, strong) NSString *rightWord;
@property (nonatomic, strong) NSString *leftImg;
@property (nonatomic, strong) NSString *rightImg;
@property (nonatomic, strong) NSString *finalWord;
@property (nonatomic, strong) NSString *dummyString;

- (id)initWithUniqueLevel:(int)uniqueLevel leftWord:(NSString *)leftWord leftImg:(NSString *)leftImg rightWord:(NSString *)rightWord rightImg:(NSString *)rightImg finalWord:(NSString *)finalWord initString:(NSString *)initString;

@end
