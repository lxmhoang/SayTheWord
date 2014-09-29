//
//  WinController.h
//  saytheword
//
//  Created by Hoang Le on 6/21/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinView.h"
#import "PlayModel.h"
#import "AnswerView.h"


@protocol WinControllerProtocol <NSObject>

- (void)nextLevelFromWinView;

@end

@interface WinController : UIViewController <WinViewProtocol>

@property (nonatomic, strong) PlayModel *playModel;
@property (nonatomic, strong) WinView *winView;
@property (nonatomic, unsafe_unretained) id delegate;

- (id)initWithPosition:(int)_pos;

@end
