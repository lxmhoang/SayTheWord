//
//  ExplodeView.h
//  Anagrams
//
//  Created by Marin Todorov on 16/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExplodeViewDelegate <NSObject>


- (void)genNewEV:(int)i;

@end

@interface ExplodeView : UIView

@property (nonatomic, assign) id delegate;
@property (assign, nonatomic) int range;

@end
