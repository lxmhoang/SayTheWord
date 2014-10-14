//
//  WordDatabase.h
//  saytheword
//
//  Created by Hoang Le on 6/10/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordInfo.h"
#import <sqlite3.h>

@interface WordDatabase : NSObject
{
    sqlite3 *_database;
}

+ (WordDatabase *)database;
- (NSArray *)WordsInfo;
- (WordInfo *)wordInfoWithLevel:(int)_level;
- (void)updateInitString:(NSString *)_newInitString atLevel:(int)_level;

- (void)insertDatabaseIntoNSUserDefault;

@end
