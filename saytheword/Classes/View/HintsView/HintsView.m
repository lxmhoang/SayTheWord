//
//  HintView.m
//  1word2pics
//
//  Created by Hoang le on 4/5/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import "HintsView.h"

@implementation HintsView
@synthesize delegate,  bigView;

- (void)removeLetter:(UITapGestureRecognizer *)_sender
{
    [delegate removeALetterFromHintsView];
}

- (void)revealLetter:(UITapGestureRecognizer *)_sender
{
    [delegate revealALetterFromHintsView];
}

- (void)showLeftTitle:(UITapGestureRecognizer *)_sender
{
    [delegate revealLeftWordFromHintsView];
}

- (void)showRightTitle:(UITapGestureRecognizer *)_sender
{
    [delegate revealRightWordFromHintsView];
}

- (void)showAnswer:(UITapGestureRecognizer *)_sender
{
    [delegate revealAnswerWordFromHintsView];
}

- (void)createSmallViews
{
    // Create navigation
    
//    int heightOfNaviBar = kCheckIfIphone ? 14 : 32;
    
//    UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, bigView.frame.size.width, heightOfNaviBar)];
//    
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"CANCEL"
//                                                                    style:UIBarButtonItemStyleDone target:nil action:nil];
//    
//    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"HINTS"];
//    item.rightBarButtonItem = rightButton;
//    item.hidesBackButton = NO;
//    [naviBar pushNavigationItem:item animated:NO];
//    
//    NSDictionary *settings = @{
//                               UITextAttributeFont                 :  [UIFont systemFontOfSize:<#(CGFloat)#>],
//                               UITextAttributeTextColor            :  [UIColor whiteColor],
//                               UITextAttributeTextShadowColor      :  [UIColor clearColor],
//                               UITextAttributeTextShadowOffset     :  [NSValue valueWithUIOffset:UIOffsetZero]};
//    
//    [[UINavigationBar appearance] setTitleTextAttributes:settings];
//    
//    [bigView addSubview:naviBar];
    
    //
    UIView *removeLetterView = [[UIView alloc]initWithFrame:CGRectMake(3, 24, 27, 30)];
    [removeLetterView setBackgroundColor:[UIColor redColor]];
    if (![CommonFunction getCanRemoveALetter]){
        removeLetterView.alpha = 0.5;
    }else{
        UITapGestureRecognizer *_tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeLetter:)];
        [removeLetterView addGestureRecognizer:_tap1];
    }
    [bigView addSubview:removeLetterView];
    
    UIView *showLetterView = [[UIView alloc]initWithFrame:CGRectMake(31, 24, 28 , 30)];
    [showLetterView setBackgroundColor:[UIColor redColor]];
    if (![CommonFunction getCanRevealALetter]){
        showLetterView.alpha = 0.5;
    }else{
        UITapGestureRecognizer *_tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(revealLetter:)];
        [showLetterView addGestureRecognizer:_tap2];
    }

    [bigView addSubview:showLetterView];
    
    UIView *showLeftTitle = [[UIView alloc]initWithFrame:CGRectMake(60, 24, 27 , 30)];
    [showLeftTitle setBackgroundColor:[UIColor redColor]];
    if ([CommonFunction getShowLeftTitle]){
        showLeftTitle.alpha = 0.5;
    }else{
        UITapGestureRecognizer *_tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showLeftTitle:)];
        [showLeftTitle addGestureRecognizer:_tap3];
    }

    [bigView addSubview:showLeftTitle];
    
    UIView *showRightTitle = [[UIView alloc]initWithFrame:CGRectMake(3, 64, 27 , 30)];
    [showRightTitle setBackgroundColor:[UIColor redColor]];
    if ([CommonFunction getShowRightTitle]){
        showRightTitle.alpha = 0.5;
    }else{
        UITapGestureRecognizer *_tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showRightTitle:)];
        [showRightTitle addGestureRecognizer:_tap4];
    }
    
    [bigView addSubview:showRightTitle];
    
//    UIView *showAnswer = [[UIView alloc]initWithFrame:CGRectMake(31, 64, 27 , 30)];
//    [showAnswer setBackgroundColor:[UIColor redColor]];
//    if ([CommonFunction getShowAnswer]){
//        showAnswer.alpha = 0.5;
//    }else{
//        UITapGestureRecognizer *_tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAnswer:)];
//        [showAnswer addGestureRecognizer:_tap5];
//        [_tap5 release];
//    }
//    
//    [bigView addSubview:showAnswer];
//    [showAnswer release];




}

- (void)createSubViews
{
    CGRect frameHintView;
    if (kCheckIfIphone)
    {
        if( IS_IPHONE_5 )
        {
            frameHintView =  CGRectMake(115, 200, 90, 100);
        }
        else
        {
            //        frameHintView =  CGRectMake(20, 50, 280, 400);
            frameHintView =  CGRectMake(115, 200, 90, 100);
        }
    }else
    {
        frameHintView = CGRectMake(300, 400, 150, 165);
    }
    
//    int k = kCheckIfIphone ? 5 : 15;
//    
//    
//    bigView = [[UIView alloc]initWithFrame:frameHintView];
//    bigView.layer.cornerRadius = k;
//    bigView.clipsToBounds = YES;
//    [bigView setBackgroundColor:[UIColor whiteColor]];
//    
//    [self createSmallViews];
//    
//
//    [self addSubview:bigView];
}

- (void)setUp
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.45];
    
    
    int k = kCheckIfIphone ? 5 : 15;
    int t = kCheckIfIphone ? 2 : 5;
    
    
    self.askFriendIcon.layer.cornerRadius = k;
    self.freeCoinIcon.layer.cornerRadius = k;
    self.askFriendIcon.layer.borderWidth = 1;
    self.freeCoinIcon.layer.borderWidth = 1;
    self.askFriendIcon.layer.borderColor = [[UIColor yellowColor] CGColor];
    self.freeCoinIcon.layer.borderColor = [[UIColor yellowColor] CGColor];
    
    bigView.layer.cornerRadius = k;
    bigView.clipsToBounds = YES;
    
    self.view11.layer.cornerRadius = t;
    self.view12.layer.cornerRadius = t;
    self.view13.layer.cornerRadius = t;
    self.view21.layer.cornerRadius = t;
    self.view22.layer.cornerRadius = t;
    self.view23.layer.cornerRadius = t;
    
    
    self.coinView11.layer.cornerRadius = t;
    self.coinView12.layer.cornerRadius = t;
    self.coinView13.layer.cornerRadius = t;
    self.coinView21.layer.cornerRadius = t;
    self.coinView22.layer.cornerRadius = t;
    self.coinView23.layer.cornerRadius = t;
    
    
    self.coinView11.layer.masksToBounds = YES;
    self.coinView12.layer.masksToBounds = YES;
    self.coinView13.layer.masksToBounds = YES;
    self.coinView21.layer.masksToBounds = YES;
    self.coinView22.layer.masksToBounds = YES;
    self.coinView23.layer.masksToBounds = YES;
    
    
    bigView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
    
    if (![CommonFunction getCanRemoveALetter])
    {
        
        self.view11.alpha = 0;
    }
    
    
    if (![CommonFunction getCanRevealALetter])
    {
        
        self.view12.alpha = 0;
    }
    
    if ([CommonFunction getShowLeftTitle])
    {
        
        self.view13.alpha = 0;
    }
    if ([CommonFunction getShowRightTitle])
    {
        
        self.view21.alpha = 0;
    }
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        hintString = [[NSUserDefaults standardUserDefaults] stringForKey:@"hintString"];
        // Initialization code
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];

        
//        [self createSubViews];
    }
    return self;
}



- (IBAction)closeBigView:(id)sender {
        [self removeFromSuperview];
}

- (void)bloat
{
//    return;
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
                [bigView setTransform:CGAffineTransformMakeScale(3.4, 3.4)];
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            [bigView setTransform:CGAffineTransformMakeScale(3.0, 3.0)];
        } completion:^(BOOL finished) {
        }];
        

    }
    ];
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
