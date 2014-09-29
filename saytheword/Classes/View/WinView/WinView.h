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
#import <iAd/iAd.h>

@protocol WinViewProtocol <NSObject>

- (void)animationFinished;

@end

@interface WinView : UIView <ExplodeViewDelegate, ADBannerViewDelegate>
{
    NSMutableArray *listCoins;
    BOOL tapped;
    ADBannerView *adbanner;
    BOOL _bannerIsVisible;
    int endYLimit;
    int widthOfFireWork;
    int numOfFW, sizeOfFW;
}

@property (nonatomic, unsafe_unretained) id delegate;



@property (nonatomic, strong) PlayModel *playModel;

- (id)initWithModel:(PlayModel *)_playModel;

@end
