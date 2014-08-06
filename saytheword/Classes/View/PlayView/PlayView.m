//
//  PlayView.m
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "PlayView.h"

@implementation PlayView

@synthesize playModel, delegate, typingView, answerView, coinLabel;

- (id)initWithModel:(PlayModel *)_model
{
    
    self = [super init];
    if (self)
    {
//        ExplodeView *stars = [[ExplodeView alloc] initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height)];
//        [self addSubview:stars];
//        [self sendSubviewToBack:stars];
//        [UIView animateWithDuration:3 animations:^{
//            stars.center = CGPointMake(320, 70);
//        } completion:^(BOOL finished) {
//            [stars removeFromSuperview];
//        }];
//        
//        [stars release];

        playModel = [_model retain];
        [self setFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
        [self createSubViews];
        if ([CommonFunction getRevealIndex]>-1){
            [self revealALetterFromController:[CommonFunction getRevealIndex]];
        }
        
    }
    
//    [self winEventFromAnswerView];

    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark create sub views

- (void)createNavigationBar
{
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidthOfScreen, 44)];
    [navBar setBackgroundColor:[UIColor clearColor]];
    [navBar setBackgroundColor:[UIColor colorWithRed:203/255.0f green:122/255.0f blue:38/255.0f alpha:1.0f]];
    navBar.layer.masksToBounds = NO;
    navBar.layer.cornerRadius = 5; // if you like rounded corners
    navBar.layer.shadowOffset = CGSizeMake(4, 5);
    navBar.layer.shadowRadius = 5;
    navBar.layer.shadowOpacity = 0.5;
//    [navBar setAlpha:0.4];
//    [navBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kNavBarImg]]];
//    NSLog(@"AAAAAAAAAAAAA %@",playModel.leftSource);
    
    
    coinView = [[UIView alloc]init];
    [coinView setBackgroundColor:[UIColor clearColor]];
    
    
    coinLabel = [[UILabel alloc]init];
    coinLabel.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"coins"]];
    [coinLabel setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:16]];
    
    [coinLabel setTextAlignment:NSTextAlignmentRight];
    [coinLabel sizeToFit];
    [coinLabel setFrame:CGRectMake(0, 5, 75, 34)];
    [coinLabel setBackgroundColor:[UIColor clearColor]];
    [coinLabel setTextColor:[UIColor yellowColor]];
    [coinLabel setTag:1111];
    [coinView addSubview:coinLabel];
    [coinLabel release];
    
    coinImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"coins.png"]];
    [coinImageView setBackgroundColor:[UIColor clearColor]];
    [coinImageView setFrame:CGRectMake(120-43, 5, 33, 33)];
    coinImageView.userInteractionEnabled = YES;
    coinImageView.layer.zPosition = 9999;
    
    
    [coinView addSubview:coinImageView];
    [coinImageView release];
    
    [coinView setFrame:CGRectMake(kWidthOfScreen - 120, 0, 120, 44)];
    //    [coinView setBackgroundColor:[UIColor redColor]];
    
    coinView.userInteractionEnabled = YES;
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coinViewTapped:)];
    [coinView addGestureRecognizer:_tap];
    [_tap release];
    
    [navBar addSubview:coinView];
    [coinView release];
    
    
    
    //Create MenuBtn
    UIButton *menuBackBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [menuBackBtn setBackgroundImage:[UIImage imageNamed:@"homeBtn.png"] forState:UIControlStateNormal];
//    [menuBackBtn setTitle:@"Menu" forState:UIControlStateNormal];
    [menuBackBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [menuBackBtn setTintColor:[UIColor blueColor]];
    [menuBackBtn setFrame:CGRectMake(10, 5, 70, 34)];
    [menuBackBtn addTarget:delegate action:@selector(backBtnPressFromPlayView) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:menuBackBtn];
    
//    navBar.layer.shadowOffset = CGSizeMake(0, 8);
//    navBar.layer.shadowRadius = 10;
//    navBar.layer.shadowOpacity = 0.5;
    
//    navBar.layer.cornerRadius = 10;
    [self addSubview:navBar];
    [navBar release];
    
    // Create Level label
    UILabel *levelLabel = [[UILabel alloc]init];
    levelLabel.text = [NSString stringWithFormat:@"Level %d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"level"] intValue]];
    [levelLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
    [levelLabel sizeToFit];
    
    [levelLabel setFrame:CGRectMake((kWidthOfScreen - levelLabel.frame.size.width)/2, (44 - levelLabel.frame.size.height)/2, levelLabel.frame.size.width, levelLabel.frame.size.height)];
    [levelLabel setBackgroundColor:[UIColor clearColor]];
    [levelLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:levelLabel];
    [levelLabel release];
}

- (void)createImageViews
{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(2, kYOfImages, 155, 155)];
    [leftView setBackgroundColor:[UIColor whiteColor]];
    [leftView.layer setCornerRadius:10.0f];
    [leftView setTag:kTagOfLeftView];
    
    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 145, 145)
                                ];
    [leftImgView setImage:[UIImage imageNamed:playModel.wordInfo.leftImg]];
    [leftView addSubview:leftImgView];
    [leftImgView release];
    
    UITapGestureRecognizer *_tapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLeft:)];
    [leftView addGestureRecognizer:_tapLeft];
    [_tapLeft release];
    
    [self addSubview:leftView];
    [leftView release];
    
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(163, kYOfImages, 155, 155)];
    [rightView setBackgroundColor:[UIColor whiteColor]];
    [rightView.layer setCornerRadius:10.0f];
    [rightView setTag:kTagOfRightView];
    
    UITapGestureRecognizer *_tapRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRight:)];
    [rightView addGestureRecognizer:_tapRight];
    [_tapRight release];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 145, 145)];
    [rightImageView setImage:[UIImage imageNamed:playModel.wordInfo.rightImg]];
    [rightView addSubview:rightImageView];
    [rightImageView release];
    
    [self addSubview:rightView];
    [rightView release];
    
}

- (void)createTitles
{
    UILabel *leftlabel = [[UILabel alloc] initWithFrame:CGRectMake(2, kYOfImages+155+5, 155, 30)];
    [leftlabel setText:[playModel.wordInfo.leftWord uppercaseString]];
    [leftlabel setTextAlignment:NSTextAlignmentCenter];
    [leftlabel setBackgroundColor:[UIColor clearColor]];
    leftlabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    [leftlabel setTextColor:[UIColor whiteColor]];
//    [leftlabel setHidden:![CommonFunction getShowLeftTitle]];
    leftlabel.alpha = [CommonFunction getShowLeftTitle] ? 1 : 0;
    [leftlabel setTag:kTagOfLeftTitle];
    [self addSubview:leftlabel];
    [leftlabel release];
    
    UILabel *rightlabel = [[UILabel alloc] initWithFrame:CGRectMake(163, kYOfImages+155+5, 155, 30)];
    [rightlabel setText:[playModel.wordInfo.rightWord uppercaseString]];
    [rightlabel setTextAlignment:NSTextAlignmentCenter];
    [rightlabel setBackgroundColor:[UIColor clearColor]];
    rightlabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    [rightlabel setTextColor:[UIColor whiteColor]];
    rightlabel.alpha = [CommonFunction getShowRightTitle] ? 1 : 0;
//    [rightlabel setHidden:![CommonFunction getShowRightTitle]];
    [rightlabel setTag:kTagOfRightTitle];
    [self addSubview:rightlabel];
    [rightlabel release];
}

- (void)createAnswerView
{
    answerView = [[AnswerView alloc]initWithFrame:CGRectMake(0, kYOfAnswerView, 320, 60) andModel:playModel];
    answerView.delegate = self;
    [self addSubview:answerView];
    [answerView release];
    
    UILabel *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kYOfAnswerView+60+5, 320, 30)];
    [answerLabel setText:[playModel.wordInfo.finalWord uppercaseString]];
    [answerLabel setTextAlignment:NSTextAlignmentCenter];
    [answerLabel setBackgroundColor:[UIColor clearColor]];
    answerLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    [answerLabel setTextColor:[UIColor whiteColor]];
    [answerLabel setHidden:![CommonFunction getShowAnswer]];
    [answerLabel setTag:kTagOfAnswerTitle];
    [self addSubview:answerLabel];
    [answerLabel release];
}

- (void)createTypingView
{
    typingView = [[TypingView alloc]initWithFrame:CGRectMake(0, kYOfTyppingView, 320, 120) andModel:playModel];
    typingView.delegate = self;
    [self addSubview:typingView];
    [typingView release];
}

- (void)createSubViews
{

//    FBLoginView *loginview = [[FBLoginView alloc] init];
//    
//    loginview.frame = CGRectOffset(loginview.frame, 5, 25);
//    loginview.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    [self addSubview:loginview];
//    
//    [loginview sizeToFit];

    
//    [loginview sizeToFit];
//    [loginview release];
    
    
    [self setBackgroundColor:[UIColor clearColor]];
//    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1136.jpg"]]];
    [self setFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
    
    [self createNavigationBar];
    [self createImageViews];
    [self createTitles];
    [self createAnswerView];
    [self createTypingView];
    
    UIButton *hintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [hintBtn setFrame:CGRectMake(12, kYOfTyppingView+15, 45, 45)];
    [hintBtn setBackgroundImage:[UIImage imageNamed:@"hint.png"] forState:UIControlStateNormal];
    [hintBtn addTarget:delegate action:@selector(hintBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [hintBtn setTag:kTagOfHintButton];
    
    [self addSubview:hintBtn];
}

#pragma mark Handle Gesture

- (void)willRemoveTextOfAnswerView:(UITapGestureRecognizer *)_sender
{
    [_sender.view removeFromSuperview];
    [answerView removeAllText];
}

- (void)coinViewTapped:(UITapGestureRecognizer *)_sender
{
    [delegate coinViewTappedFromPlayView];
}

- (void)tapToNormal:(UITapGestureRecognizer *)_sender
{
    [[self viewWithTag:kTagOfDarkView] removeFromSuperview];
    [[self viewWithTag:kTagOfNewView] removeFromSuperview];
    [_sender.view removeFromSuperview];
}

- (void)tapLeft:(UITapGestureRecognizer *)_sender
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    UIView *darkView = [[UIView alloc]initWithFrame:self.bounds];
    [darkView setBackgroundColor:[UIColor blackColor]];
    [darkView setTag:kTagOfDarkView];
    darkView.alpha = 0.7;
    [self addSubview:darkView];
    [darkView release];
   
    UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(10, kYOfImages, 145, 145)];
    [newView setBackgroundColor:[UIColor whiteColor]];
    [newView.layer setCornerRadius:10.0f];
    
    UIImageView *newImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 135, 135)];
    [newImgView setImage:[UIImage imageNamed:playModel.wordInfo.leftImg]];
    [newView addSubview:newImgView];
    [newImgView release];
    
    [newView setTag:kTagOfNewView];
    [self addSubview:newView];
    [newView release];
    
    [UIView animateWithDuration:0.2 animations:^{
        [newView setFrame:CGRectMake(0, kYOfImages+50, 320, 320)];
        for (UIView *subView in newView.subviews){
            [subView setFrame:CGRectMake(5, 5, 310, 310)];
        }
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        UIView *clearView = [[UIView alloc]initWithFrame:self.bounds];
        [clearView setBackgroundColor:[UIColor clearColor]];
        
        
        UITapGestureRecognizer *_tapToNormalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToNormal:)];
        [clearView addGestureRecognizer:_tapToNormalGesture];
        [_tapToNormalGesture release];
        
        [self addSubview:clearView];
        
    }];
    

}

- (void)tapRight:(UITapGestureRecognizer *)_sender
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    UIView *darkView = [[UIView alloc]initWithFrame:self.bounds];
    [darkView setBackgroundColor:[UIColor blackColor]];
    [darkView setTag:kTagOfDarkView];
    darkView.alpha = 0.7;
    [self addSubview:darkView];
    [darkView release];
    
    UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(165, kYOfImages, 145, 145)];
    [newView setBackgroundColor:[UIColor whiteColor]];
    [newView.layer setCornerRadius:10.0f];
    
    UIImageView *newImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 135, 135)];
    [newImgView setImage:[UIImage imageNamed:playModel.wordInfo.rightImg]];
    [newView addSubview:newImgView];
    [newImgView release];
    
    [newView setTag:kTagOfNewView];
    [self addSubview:newView];
    [newView release];
    
    [UIView animateWithDuration:0.2 animations:^{
        [newView setFrame:CGRectMake(0, kYOfImages+50, 320, 320)];
        for (UIView *subView in newView.subviews){
            [subView setFrame:CGRectMake(5, 5, 310, 310)];
        }
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        UIView *clearView = [[UIView alloc]initWithFrame:self.bounds];
        [clearView setBackgroundColor:[UIColor clearColor]];
        
        
        UITapGestureRecognizer *_tapToNormalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToNormal:)];
        [clearView addGestureRecognizer:_tapToNormalGesture];
        [_tapToNormalGesture release];
        
        [self addSubview:clearView];
        
    }];
    
    
}

#pragma mark TypingViewDelegate

- (void)pickCharPress:(NSString *)_char
{
    [answerView setNewChar:_char];
}

#pragma mark AnswerViewDelegate



- (void)winEventFromAnswerView
{
    UIView *leftTitleView = [self viewWithTag:kTagOfLeftTitle];
    UIView *rightTitleView = [self viewWithTag:kTagOfRightTitle];
    [UIView animateWithDuration:0.8 animations:^{

        leftTitleView.alpha = 1;
        rightTitleView.alpha = 1;
    } completion:^(BOOL finished) {
        RootController *rootVC = [CommonFunction getRootController];
        AnswerView *copyAnswerView = [answerView retain];
        
        [rootVC.view addSubview:copyAnswerView];
        [rootVC.view addSubview:leftTitleView];
        [rootVC.view addSubview:rightTitleView];
        [leftTitleView setTag:kTagOfLeftTitle];
        [rightTitleView setTag:kTagOfRightTitle];
        [copyAnswerView setTag:kTagOfCopyAnswerView];
        [copyAnswerView release];
        [delegate showWinScreenFromPlayView];
    }];
    
    

    
    return;
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    UIView *hintBtn = [self viewWithTag:kTagOfHintButton];
    UIView *leftView = [self viewWithTag:kTagOfLeftView];
    UIView *rightView = [self viewWithTag:kTagOfRightView];

    
    [leftTitleView setFrame:CGRectMake(2, kYOfImages+155+5 + 90, leftTitleView.frame.size.width, leftTitleView.frame.size.height)];
    [rightTitleView setFrame:CGRectMake(163, kYOfImages+155+5 + 90, rightTitleView.frame.size.width, rightTitleView.frame.size.height)];
    
    if (![CommonFunction getShowLeftTitle])
    {
        [leftTitleView setFrame:CGRectMake(-155, kYOfImages+155+5+ 90, 155, 30)];
        leftTitleView.alpha = 1;
    }

    if (![CommonFunction getShowRightTitle])
    {
        [rightTitleView setFrame:CGRectMake(320, kYOfImages+155+5+ 90, 155, 30)];
        rightTitleView.alpha = 1;
    }
    
    

    [UIView animateWithDuration:1.0 animations:^{
        
        [typingView setFrame:CGRectMake(typingView.frame.origin.x, kHeightOfScreen, typingView.frame.size.width, typingView.frame.size.height)];
        [hintBtn setFrame:CGRectMake(hintBtn.frame.origin.x, kHeightOfScreen, hintBtn.frame.size.width , hintBtn.frame.size.height)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{

            
            if (![CommonFunction getShowLeftTitle])
            {
                [leftTitleView setFrame:CGRectMake(2, kYOfImages+155+5+ 90, 155, 30)];
            }
            if (![CommonFunction getShowRightTitle])
            {
                [rightTitleView setFrame:CGRectMake(163, kYOfImages+155+5+ 90, 155, 30)];
            }
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:1.0 animations:^{
                leftView.alpha = 0;
                
                rightView.alpha = 0;

            } completion:^(BOOL finished) {
                
            }];

            
        }];
        
    }];
//    [UIView animateWithDuration:2.0 animations:^{
//        [[self viewWithTag:kTagOfLeftTitle] setAlpha:1.0];
//        [[self viewWithTag:kTagOfRightTitle] setAlpha:1.0];
//        [typingView setAlpha:0.0];
//        [[self viewWithTag:kTagOfHintButton] setAlpha:0.0];
//        
//    } completion:^(BOOL finished) {
//        
//        
//    }];

//    [UIView animateWithDuration:1.5 animations:^{
//        typingView.alpha = 0;
//    } completion:^(BOOL finished) {
//        NSLog(@"Done");
//    }];

    return;
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [delegate showWinScreenFromPlayView];

    return;
    
    AnswerView *newAnserView = [answerView retain];
    [[newAnserView viewWithTag:kTagOfEraseIcon] removeFromSuperview];
    
    newAnserView.userInteractionEnabled = NO;
    [answerView removeFromSuperview];
    
    RootController *rootController = [CommonFunction getRootController];

    UIView *whiteView = [[UIView alloc]initWithFrame:answerView.frame];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.alpha = 0.4;
    [rootController.view addSubview:whiteView];
    [whiteView release];
    
    newAnserView.backgroundColor = [UIColor clearColor];
    [rootController.view addSubview:newAnserView];
    [newAnserView release];
    
    [UIView animateWithDuration:1.5 animations:^{
        [self setFrame:CGRectMake(-320, 0, 320, kHeightOfScreen)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            [whiteView setFrame:CGRectMake(0, 0, 320, kHeightOfScreen)] ;
        } completion:^(BOOL finished) {
            [delegate showWinScreenFromPlayView];
        }];
        
        
//        [newAnserView setFrame:CGRectMake(0, 0, 320, kHeightOfScreen)];
    }];

    
//    [self setFrame:CGRectMake(-320, kYOfTyppingView, 320, 120)];
//    [delegate showWinScreenFromPlayView];
}

- (void)answerViewFilled
{
    
    
    if ([answerView ifAnswerIsCorrect])
    {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
        {
            UIView *tmpLine = [answerView viewWithTag:i+2*kRandomNumber];
            [tmpLine setBackgroundColor:[UIColor whiteColor]];
        }
        
        [UIView animateWithDuration:1.5 animations:^{
            for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
            {
                UIView *tmpLine = [answerView viewWithTag:i+2*kRandomNumber];
                tmpLine.alpha = 0;
            }
        } completion:^(BOOL finished) {
            [answerView winEvent];
        }];
        
    }
    else
    {
        [answerView setTextToRed];
        UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, 320, 568)];
        UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(willRemoveTextOfAnswerView:)];
        [clearView addGestureRecognizer:_tap];
        [_tap release];
        [self addSubview:clearView];
        [clearView release];
    }
}

- (void)tapToTextFromAnswerView:(NSString *)_text
{
    [typingView returnTextFromPlayView:_text];
}

#pragma mark method call from play controller

- (int)checkNumOfRemoveableChars
{
    int count=0;
    for (UIView *tmp in typingView.subviews){
        if (([tmp isKindOfClass:[InputButtonView class]])&&(![tmp isHidden])){
            InputButtonView *obj = (InputButtonView *)tmp;
            NSRange range = [playModel.wordInfo.finalWord rangeOfString:[obj.lb.text lowercaseString]];
            if (range.location == NSNotFound){
                count++;
            }
        }
    }
    return count;
}

- (void)removeALetterFromController
{
    NSMutableArray *listOfRemoveableChar = [[NSMutableArray alloc] init];
    for (UIView *tmp in typingView.subviews){
        if ([tmp isKindOfClass:[InputButtonView class]]){
            InputButtonView *obj = (InputButtonView *)tmp;
            NSRange range = [playModel.wordInfo.finalWord rangeOfString:[obj.lb.text lowercaseString]];
            if (range.location == NSNotFound){
                [listOfRemoveableChar addObject:obj];
            }
        }
    }
    
    int r = arc4random()%[listOfRemoveableChar count];
    NSLog(@"num of removable char : %d %d",[listOfRemoveableChar count],r);
    InputButtonView *willBeRemoveBtn = [listOfRemoveableChar objectAtIndex:r];
    [CommonFunction setRemoveIndex:(willBeRemoveBtn.tagg-kRandomNumber)];
//    [playModel removeCharInDB:willBeRemoveBtn.tagg];
    [willBeRemoveBtn removeFromSuperview];
    
}

- (int)checkNumOfEmptyLabelInResultView
{
    int count = 0;
    for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
    {
        UILabel *rVLabel = (UILabel *)[answerView viewWithTag:(kRandomNumber+i)];
        if ([rVLabel.text isEqualToString:@""]){
            count++;
        }
    }
    return count;
}

- (int)getIndexOfRevealLabel:(int)numOfEmptyLB
{
    int k = arc4random()%numOfEmptyLB+1;
    for (int i=0;i<playModel.wordInfo.finalWord.length;i++)
    {
        UILabel *rVLabel = (UILabel *)[answerView viewWithTag:(kRandomNumber+i)];
        if ([rVLabel.text isEqualToString:@""]){
            k--;
        }
        if (k==0){
            return i;
        }
    }
    NSLog(@"getIndexOfRevealLabel ERROR !!!!!!");
    return 99;
    
}

- (void)revealALetterFromController:(int)r
{
    
    
    NSString *revealedChar = [playModel.wordInfo.finalWord substringWithRange:NSMakeRange(r, 1)];
    
    int tmpTag = kRandomNumber+r;
    
    UILabel *revealLB = (UILabel *)[answerView viewWithTag:tmpTag];
    
    if ([revealLB.gestureRecognizers count]==0)
        return;
    [answerView setNewIndex:r];
    [answerView performSelector:@selector(tapLabel:) withObject:[revealLB.gestureRecognizers objectAtIndex:0]];

    for (UIView *tmp in typingView.subviews)
    {
        if ([tmp isKindOfClass:[InputButtonView class]])
        {
            InputButtonView *inputTmp = (InputButtonView *)tmp;
            if ([inputTmp.lb.text isEqualToString:[revealedChar uppercaseString]]){
                NSLog(@"reveal char : %@",inputTmp.lb.text);
                [typingView performSelector:@selector(pickCharPress:) withObject:[inputTmp.gestureRecognizers objectAtIndex:0]];
                
                break;
            }
        }
    }
    
    // remove gesture
    
    UILabel *asVLabel = (UILabel *)[answerView viewWithTag:tmpTag];
    for (UIGestureRecognizer *ges in asVLabel.gestureRecognizers){
//        NSLog(@"1");
        [asVLabel removeGestureRecognizer:ges];
//        NSLog(@"2");
    }
//    
//    UILabel *rVLabel = (UILabel *)[rV viewWithTag:tagFocus];
//    for (UIGestureRecognizer *ges in rVLabel.gestureRecognizers){
//        NSLog(@"3");
//        [rVLabel removeGestureRecognizer:ges];
//        NSLog(@"4");
//    }
    
    
    
    
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
