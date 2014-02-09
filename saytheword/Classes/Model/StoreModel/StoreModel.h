//
//  StoreModel.h
//  1word2pics
//
//  Created by Hoang le on 3/27/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAPHelper.h"
#import <StoreKit/StoreKit.h>

@interface StoreModel : NSObject 
{
//    IAPHelper *iAPHelper;
}

@property (nonatomic, retain) NSArray *listItems;

- (id)initWithArray:(NSArray *)_array;
- (void)importData:(NSArray *)_array;

@end
