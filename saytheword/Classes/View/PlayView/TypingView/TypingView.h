//
//  TypingView.h
//  saytheword
//
//  Created by Hoang Le on 6/16/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayModel.h"
#import "InputButtonView.h"

@protocol TypingViewDelegate <NSObject>

- (void)pickCharPress:(NSString *)_char;

@end

@interface TypingView : UIView
{
    int sizeOfChar, dstBetweenChars, padding, yOfChar;
}

@property (nonatomic, strong) PlayModel *playModel;
@property (nonatomic, unsafe_unretained) id delegate;

- (id)initWithFrame:(CGRect)frame andModel:(PlayModel *)_playModel;
- (void)returnTextFromPlayView:(NSString *)_text;

@end


