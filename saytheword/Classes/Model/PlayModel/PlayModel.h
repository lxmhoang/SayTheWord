//
//  PlayModel.h
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordDatabase.h"
#import "WordInfo.h"

@interface PlayModel : NSObject

@property (nonatomic) int position;
@property (nonatomic, strong) WordInfo *wordInfo;

- (id)initWithPosition:(int)_pos andLevel:(int)_level;
- (void)removeCharInDB:(int)_tagg;

@end
