//
//  WordDatabase.m
//  saytheword
//
//  Created by Hoang Le on 6/10/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "WordDatabase.h"


@implementation WordDatabase

static WordDatabase *_database;

+ (WordDatabase*)database {
    if (_database == nil) {
        _database = [[WordDatabase alloc] init];
    }
    return _database;
}

- (void)updateInitString:(NSString *)_newInitString atLevel:(int)_level
{
    NSString *query = @"UPDATE words SET initString = ? WHERE level = ?";
    sqlite3_stmt *statement = nil;
    sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil);
    sqlite3_bind_text(statement, 1, [_newInitString UTF8String], -1, nil);
    sqlite3_bind_int(statement, 2, _level);
    
    if (sqlite3_step(statement))
    {
        NSLog(@"Done");
    }
    sqlite3_finalize(statement);
    WordInfo *editedWord = [CommonFunction getWordInfoForLevel:_level];
    editedWord.dummyString = _newInitString;
    [CommonFunction setWordInfo:editedWord];
}

- (WordInfo *)wordInfoWithLevel:(int)_level
{
    NSLog(@"aaaaaa");
    NSString *query = [NSString stringWithFormat:@"SELECT level, leftWord, leftImg, rightWord, rightImg, finalWord, initString from words WHERE level = %d",_level];
  
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)
        == SQLITE_OK) {
        
        NSLog(@"bbbbbb");
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int newLevel = sqlite3_column_int(statement, 0);
            char *_newLeftWord = (char *) sqlite3_column_text(statement, 1);
            char *_newLeftImg = (char *) sqlite3_column_text(statement, 2);
            char *_newRightWord = (char *) sqlite3_column_text(statement, 3);
            char *_newRightImg = (char *) sqlite3_column_text(statement, 4);
            char *_newFinalWord = (char *) sqlite3_column_text(statement, 5);
            char *_newInitString = (char *) sqlite3_column_text(statement, 6);
            
            NSString *newLeftWord = [[NSString alloc] initWithUTF8String:_newLeftWord];
            NSString *newLeftImg = [[NSString alloc] initWithUTF8String:_newLeftImg];
            NSString *newRightWord = [[NSString alloc] initWithUTF8String:_newRightWord];
            NSString *newRightImg = [[NSString alloc] initWithUTF8String:_newRightImg];
            NSString *newFinalWord = [[NSString alloc] initWithUTF8String:_newFinalWord];
            NSString *newInitString = [[NSString alloc] initWithUTF8String:_newInitString];
            
            
            WordInfo *info = [[WordInfo alloc] initWithUniqueLevel:newLevel leftWord:newLeftWord leftImg:newLeftImg rightWord:newRightWord rightImg:newRightImg finalWord:newFinalWord initString:newInitString];
            sqlite3_finalize(statement);
            return info;
  
           
        }
    }
    
    NSLog(@"cccccc");
    return nil;
}

- (NSString *) getDBPath {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,    NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"saytheword.sqlite"];
}

- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"saytheword.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
		if (!success)
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

- (id)init {
    if ((self = [super init])) {
        [self createEditableCopyOfDatabaseIfNeeded];
        NSString *sqLiteDb = [self getDBPath];
        
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

- (void)insertDatabaseIntoNSUserDefault
{
    NSArray *datas = [self WordsInfo];
    for (WordInfo *info in datas)
    {
        [CommonFunction setWordInfo:info];
        
    }
}

- (NSArray *)WordsInfo {
    
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT level, leftWord, leftImg, rightWord, rightImg, finalWord, initString from words ORDER BY level ASC";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)
        == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int newLevel = sqlite3_column_int(statement, 0);
            char *_newLeftWord = (char *) sqlite3_column_text(statement, 1);
            char *_newLeftImg = (char *) sqlite3_column_text(statement, 2);
            char *_newRightWord = (char *) sqlite3_column_text(statement, 3);
            char *_newRightImg = (char *) sqlite3_column_text(statement, 4);
            char *_newFinalWord = (char *) sqlite3_column_text(statement, 5);
            char *_newInitString = (char *) sqlite3_column_text(statement, 6);
            
            NSString *newLeftWord = [[NSString alloc] initWithUTF8String:_newLeftWord];
            NSString *newLeftImg = [[NSString alloc] initWithUTF8String:_newLeftImg];
            NSString *newRightWord = [[NSString alloc] initWithUTF8String:_newRightWord];
            NSString *newRightImg = [[NSString alloc] initWithUTF8String:_newRightImg];
            NSString *newFinalWord = [[NSString alloc] initWithUTF8String:_newFinalWord];
            NSString *newInitString = [[NSString alloc] initWithUTF8String:_newInitString];
             
        
            WordInfo *info = [[WordInfo alloc] initWithUniqueLevel:newLevel leftWord:newLeftWord leftImg:newLeftImg rightWord:newRightWord rightImg:newRightImg finalWord:newFinalWord initString:newInitString];
            
            [retval addObject:info];
        }
        sqlite3_finalize(statement);
    }
    return retval;
    
}

@end
