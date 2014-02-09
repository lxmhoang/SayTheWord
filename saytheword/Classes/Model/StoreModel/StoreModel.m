//
//  StoreModel.m
//  1word2pics
//
//  Created by Hoang le on 3/27/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel
@synthesize listItems;

- (id)init
{
    self = [super init];
    if (self)
    {
//        iAPHelper = [[IAPHelper alloc]init];
//        iAPHelper.delegate = self;
//        [iAPHelper loadStore];
    }
    return self;
}

- (id)initWithArray:(NSArray *)_array
{
    self = [super init];
    if (self)
    {
        listItems = [[NSArray alloc] initWithArray:_array];
    }
    return self;
}

- (void)importData:(NSArray *)_array
{
    NSSortDescriptor *lowestPriceToHighest = [NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES];
    listItems = [[NSArray alloc]initWithArray:[_array sortedArrayUsingDescriptors:[NSArray arrayWithObject:lowestPriceToHighest]]];
    
//    NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:_array];
//    [tmp sortedArrayUsingComparator:^(SKProduct *a, SKProduct *b){
//        return (NSComparisonResult)[a.price compare:b.price];
//    }];
//    
//    listItems = [[NSArray alloc] initWithArray:tmp];
}

- (void)dealloc{
    [listItems release];
    [super dealloc];
}

#pragma mark iaphelper delegate method

- (void)setListProducts:(NSArray *)listProducts
{
    listItems = [[NSArray alloc]initWithArray:listProducts];
}





@end
