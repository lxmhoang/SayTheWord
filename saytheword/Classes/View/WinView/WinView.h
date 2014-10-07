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
#import "GADInterstitial.h"

@class GADBannerView, GADRequest;

@protocol WinViewProtocol <NSObject>

- (void)animationFinished;

@end

@interface WinView : UIView <ExplodeViewDelegate, ADBannerViewDelegate, GADInterstitialDelegate, ADInterstitialAdDelegate>
{
    UILabel *congratLB;
    NSMutableArray *listCoins;
    BOOL tapped;
    ADBannerView *adbanner;
    BOOL _bannerIsVisible;
    int endYLimit;
    int widthOfFireWork;
    int numOfFW, sizeOfFW;
    
    BOOL ableToGoToNextLevel;
    
    BOOL fullscreenAds, brag;
}

@property (nonatomic, strong) ADInterstitialAd *interstitial;
@property (nonatomic, unsafe_unretained) id delegate;
@property (nonatomic, assign) BOOL fullscreenAds, brag;





@property (nonatomic, strong) PlayModel *playModel;

- (id)initWithModel:(PlayModel *)_playModel;

@end
