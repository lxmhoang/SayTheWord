//
//  WinView.h
//  saytheword
//
//  Created by Hoang Le on 6/21/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayModel.h"
#import "ExplodeView.h"

@protocol WinViewProtocol <NSObject>

- (void)animationFinished;

@end

@interface WinView : UIView <ExplodeViewDelegate>
{
    NSMutableArray *listCoins;
    BOOL tapped;
}

@property (nonatomic, assign) id delegate;



@property (nonatomic, retain) PlayModel *playModel;

- (id)initWithModel:(PlayModel *)_playModel;

@end
