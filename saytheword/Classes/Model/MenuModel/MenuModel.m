//
//  MenuModel.m
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

@synthesize position;

- (id)initWithPosition:(int)_pos{
    self = [super init];
    if (self){
        position = _pos;
    }
    return self;
    
}

@end
