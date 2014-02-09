//
//  StoresView.m
//  saytheword
//
//  Created by Hoang Le on 7/10/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//



#import "StoresView.h"

@implementation StoresView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)createSubViews
{
    bigView = [[UIView alloc] initWithFrame:CGRectMake(115, 200, 90, 100)];
    [bigView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:bigView];
    [bigView setHidden:YES];
    [bigView release];
}

- (id)initWithFrame:(CGRect)frame andData:(StoreModel *)_data
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
        //        self.alpha = 0;
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        storeModel = [_data retain];
        [self createSubViews];
        HUD = [[MBProgressHUD alloc] initWithView:self];
        [self addSubview:HUD];
        
        HUD.delegate = self;
        HUD.labelText = @"Buying ...";
        HUD.detailsLabelText = @"Please wait";
        HUD.square = YES;
        
    }
    return self;
}

- (void)createSmallViews
{
    for (int i=0;i<[storeModel.listItems count];i++)
    {
        
        IAPView *iap = [[IAPView alloc] initWithProductIdentifier:[[storeModel.listItems objectAtIndex:i] productIdentifier]];
        iap.delegate = self;
        [bigView addSubview:iap];
        [iap release];
        
    }
    IAPView *freeCoin = [[IAPView alloc] initWithProductIdentifier:@"FreeCoins"];
    [bigView addSubview:freeCoin];
    freeCoin.delegate = self;
    [freeCoin release];
    
    IAPView *diamond = [[IAPView alloc] initWithProductIdentifier:@"diamond"];
    [bigView addSubview:diamond];
    diamond.delegate = self;
    [diamond release];
    
//    UILabel *freeCoinLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 24, 27, 30)];
//    [freeCoinLabel setBackgroundColor:[UIColor redColor]];
//    [freeCoinLabel setFont:[UIFont fontWithName:@"Arial" size:3]];
//    [freeCoinLabel setTextAlignment:NSTextAlignmentCenter];
//    freeCoinLabel.textColor = [UIColor whiteColor];
//    freeCoinLabel.text = @"Free coins";
//    [bigView addSubview:freeCoinLabel];
//    [freeCoinLabel release];
//    
//    
//    UILabel *oneTScoinsLabel = [[UILabel alloc]initWithFrame:CGRectMake(31, 24, 28 , 30)];
//    oneTScoinsLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"coin1.png"]];
////    [oneTScoinsLabel setBackgroundColor:[UIColor redColor]];
//    [bigView addSubview:oneTScoinsLabel];
//    [oneTScoinsLabel release];
//    
//    UIView *showTitle = [[UIView alloc]initWithFrame:CGRectMake(60, 24, 27 , 30)];
//    [showTitle setBackgroundColor:[UIColor redColor]];
//    [bigView addSubview:showTitle];
//    [showTitle release];
//    
//    UIView *askFriend = [[UIView alloc]initWithFrame:CGRectMake(3, 60, 27 , 30)];
//    [askFriend setBackgroundColor:[UIColor redColor]];
//    [bigView addSubview:askFriend];
//    [askFriend release];
//    
//    UIView *diamond = [[UIView alloc]initWithFrame:CGRectMake(31, 60, 28 , 30)];
//    [diamond setBackgroundColor:[UIColor redColor]];
//    [bigView addSubview:diamond];
//    [diamond release];
//    
//    UIView *ads = [[UIView alloc]initWithFrame:CGRectMake(60, 60, 27 , 30)];
//    [ads setBackgroundColor:[UIColor redColor]];
//    [bigView addSubview:ads];
//    [ads release];
    

}

- (void)closeBigView:(id)_sender
{
    [delegate dismissStoreController];
}

- (void)showUp
{
    [bigView setHidden:NO];
    [self createSmallViews];
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        [bigView setTransform:CGAffineTransformMakeScale(3.2, 3.2)];
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            [bigView setTransform:CGAffineTransformMakeScale(3.0, 3.0)];
        } completion:^(BOOL finished) {
            UIImageView *closeIcon = [[UIImageView alloc]initWithFrame:CGRectMake(bigView.frame.origin.x-12, bigView.frame.origin.y-12, 32, 32)];
            [closeIcon setImage:[UIImage imageNamed:@"Close-icon.png"]];
            closeIcon.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeBigView:)];
            [closeIcon addGestureRecognizer:_tap];
            [_tap release];
            [self addSubview:closeIcon];
            [closeIcon release];
        }];
        
        
    }
     ];
}


#pragma mark IAPView Delegate

- (int)getIndexOfSelectedIAP:(NSString *)_string
{
    if ([_string isEqualToString:@"FreeCoins"])
        return -1;
    if ([_string isEqualToString:@"diamond"])
        return -2;
    for (int i=0;i<[storeModel.listItems count];i++)
    {
        if ([[[storeModel.listItems objectAtIndex:i] productIdentifier] isEqualToString:_string])
        {
            return i;
        }

    }
    return -1;
}

- (void)IAPselected:(UITapGestureRecognizer *)_sender
{

    
    IAPView *iapView = (IAPView *)_sender.view;
    NSLog(@"iapView product identifier %@",iapView.productIdentifier);
    int i = [self getIndexOfSelectedIAP:iapView.productIdentifier];
    
    if (i>=0)
    {
        SKProduct *selectedProduct = [storeModel.listItems objectAtIndex:i];
        SKPayment *payment = [SKPayment paymentWithProduct:selectedProduct];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }else{
        if ([iapView.productIdentifier isEqualToString:@"FreeCoins"])
        {
            FreeCoinView *freeCoinView = [[FreeCoinView alloc] initWithFrame:self.bounds];
            freeCoinView.delegate = delegate;
            [self addSubview:freeCoinView];
            [freeCoinView release];
            
            return;
            
            
 
        }
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
