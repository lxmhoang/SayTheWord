//
//  PlayView.m
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "PlayView.h"

#import "GADBannerView.h"
#import "GADRequest.h"

@implementation PlayView

@synthesize playModel, delegate, typingView, answerView, coinLabel, leftView, rightView, adbanner;

- (id)initWithModel:(PlayModel *)_model
{
    
    self = [super init];
    if (self)
    {

        yOfImages = kCheckIfIphone ? 70 : 160;
        sizeOfImg = kCheckIfIphone ? 155 : 300;
        distanceFromImgToTitle = kCheckIfIphone ? 5 : 20;
        heightOftitle = kCheckIfIphone ? 30 : 45;
        yOfAnswerView = kCheckIfIphone ? 260 : 540;
        heightOfAnswerView = kCheckIfIphone ? 60 : 120;
        distanceFromAnswerViewToAnswerLabel = kCheckIfIphone ? 5 : 10;
        yOfTypingView = kCheckIfIphone ? (([ [ UIScreen mainScreen ] bounds ].size.height == 568) ? 360 : 310) : 700;
        heightOfTypingView = kCheckIfIphone ? 120 : 240;
        
        

        playModel = _model;
        [self setFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
        [self createSubViews];
        if ([CommonFunction getRevealIndex]>-1){
            [self revealALetterFromController:[CommonFunction getRevealIndex]];
        }
        hintInternal = 2;
        [self performSelector:@selector(after10s) withObject:self afterDelay:10];
        
        
    }
    
//    [self winEventFromAnswerView];

    
    return self;
}

- (void)after10s
{
    timer = [NSTimer scheduledTimerWithTimeInterval:hintInternal target:self selector:@selector(hintJump) userInfo:nil repeats:YES];

}

- (void)hintJump
{
    int k = hintBtn.frame.size.width / 3;\
    [UIView animateWithDuration:0.1 animations:^{
        [hintBtn setFrame:CGRectOffset(hintBtn.frame, 0, -k)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            [hintBtn setFrame:CGRectOffset(hintBtn.frame, 0, k)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                [hintBtn setFrame:CGRectOffset(hintBtn.frame, 0, -k)];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    [hintBtn setFrame:CGRectOffset(hintBtn.frame, 0, k)];
                } completion:^(BOOL finished) {
//                    NSLog(@"done");
                }];
            }];
        }];
    }];
    
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
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfNavigationBar)];
    
    [navBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_nau_new.png"]]];
    
    //    [navBar setBackgroundColor:[UIColor colorWithRed:203/255.0f green:122/255.0f blue:38/255.0f alpha:1.0f]];
    [navBar setBackgroundColor:navColor];
    navBar.layer.masksToBounds = NO;
    //    navBar.layer.cornerRadius = 5; // if you like rounded corners
//    navBar.layer.shadowOffset = CGSizeMake(4, 5);
//    navBar.layer.shadowRadius = 5;
//    navBar.layer.shadowOpacity = 0.5;
    
    
    //    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    //    [v1 setBackgroundColor:[UIColor colorWithRed:203/255.0f green:122/255.0f blue:38/255.0f alpha:1.0f]];
    //    [self addSubview:v1];
    
    coinView = [[UIView alloc]init];
    [coinView setFrame:CGRectMake(kWidthOfScreen - (kCheckIfIphone ? 120 : 220), 0, (kCheckIfIphone ? 120 : 220), kHeightOfNavigationBar)];
    [coinView setBackgroundColor:[UIColor clearColor]];
    
    int fontSize = kCheckIfIphone ? 16 : 28;
    
    coinLabel = [[UILabel alloc]init];
    coinLabel.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"coins"]];
    [coinLabel setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:fontSize]];
    
    [coinLabel setTextAlignment:NSTextAlignmentRight];
    [coinLabel sizeToFit];
    [coinLabel setFrame:CGRectMake(0, kCheckIfIphone ? 5 : 10, kCheckIfIphone ? 75 : 150, kCheckIfIphone ? 33 : 44 )];
    [coinLabel setBackgroundColor:[UIColor clearColor]];
    [coinLabel setTextColor:[UIColor yellowColor]];
    [coinView addSubview:coinLabel];
    
    coinImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"coins.png"]];
    [coinImageView setBackgroundColor:[UIColor clearColor]];
    int size = kCheckIfIphone ? 33 : 44;
    [coinImageView setFrame:CGRectMake(coinLabel.frame.size.width+10, (coinView.frame.size.height-size)/2, size, size)];
    coinImageView.userInteractionEnabled = YES;
    coinImageView.layer.zPosition = 9999;
    
    
    [coinView addSubview:coinImageView];
    
    
    
    coinView.userInteractionEnabled = YES;
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coinViewTapped:)];
    [coinView addGestureRecognizer:_tap];
    
    [navBar addSubview:coinView];
    
    CGRect tmpRect = kCheckIfIphone ? CGRectMake(10, 5, 70, 34) : CGRectMake(16, 7, 100, 50);
    //Create MenuBtn
    UIButton *menuBackBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [menuBackBtn setBackgroundImage:[UIImage imageNamed:@"homeBtn.png"] forState:UIControlStateNormal];
    //    [menuBackBtn setTitle:@"Menu" forState:UIControlStateNormal];
    [menuBackBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [menuBackBtn setTintColor:[UIColor blueColor]];
    [menuBackBtn setFrame:tmpRect];
    [menuBackBtn addTarget:delegate action:@selector(backBtnPressFromPlayView) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:menuBackBtn];

    
    
    
    
    [self addSubview:navBar];
    
    // Create Level label
    fontSize = kCheckIfIphone ? 20 : 40;
    int width = kCheckIfIphone ? 100 : 200;
    int height = kCheckIfIphone ? 44 : 64;
    UILabel *levelLabel = [[UILabel alloc]init];
    levelLabel.textAlignment = NSTextAlignmentCenter;
    levelLabel.text = [NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"level"] intValue]];
    [levelLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:fontSize]];
    [levelLabel sizeToFit];
    
    [levelLabel setFrame:CGRectMake((kWidthOfScreen - width)/2, 0, width, height)];
    [levelLabel setBackgroundColor:[UIColor clearColor]];
    [levelLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:levelLabel];
}

- (UIImage *)getImageByName:(NSString *)imgName
{
    NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir  = [documentPaths objectAtIndex:0];
    NSString  *pathFile = [documentsDir stringByAppendingPathComponent:imgName];
    UIImage *documentImage = [UIImage imageWithContentsOfFile:pathFile];
    
    
    if (documentImage)
    {
        return documentImage;
    }else
    {
        
        UIImage *img = [UIImage imageNamed:imgName];

        return img;
    }
}

- (void)createImageViews
{
    leftView = [[UIView alloc]initWithFrame:CGRectMake((kWidthOfScreen - 2*sizeOfImg)/4, yOfImages, sizeOfImg, sizeOfImg)];
    [leftView setBackgroundColor:[UIColor whiteColor]];
    [leftView.layer setCornerRadius:10.0f];
    [leftView setTag:kTagOfLeftView];
    
    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, sizeOfImg-10, sizeOfImg-10)];
    
    [leftImgView setImage:[self getImageByName:playModel.wordInfo.leftImg]];
    [leftView addSubview:leftImgView];
    
    
    
    UITapGestureRecognizer *_tapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLeft:)];
    [leftView addGestureRecognizer:_tapLeft];
    
    [self addSubview:leftView];
    
    
    rightView = [[UIView alloc]initWithFrame:CGRectMake(leftView.frame.origin.x + leftView.frame.size.width + (kWidthOfScreen - sizeOfImg*2)/2, yOfImages, sizeOfImg, sizeOfImg)];
    [rightView setBackgroundColor:[UIColor whiteColor]];
    [rightView.layer setCornerRadius:10.0f];
    [rightView setTag:kTagOfRightView];
    
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, sizeOfImg-10, sizeOfImg-10)];
    
    [rightImageView setImage:[self getImageByName:playModel.wordInfo.rightImg]];
    
    [rightView addSubview:rightImageView];
    
    UITapGestureRecognizer *_tapRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRight:)];
    [rightView addGestureRecognizer:_tapRight];
    [self addSubview:rightView];
    
}

- (void)createTitles
{
    int fontsize = kCheckIfIphone ? 15 : 32;
    UILabel *leftlabel = [[UILabel alloc] initWithFrame:CGRectMake((kWidthOfScreen - 2*sizeOfImg)/4, yOfImages+sizeOfImg + distanceFromImgToTitle, sizeOfImg, heightOftitle)];
    [leftlabel setText:[playModel.wordInfo.leftWord uppercaseString]];
    [leftlabel setTextAlignment:NSTextAlignmentCenter];
    [leftlabel setBackgroundColor:[UIColor clearColor]];
    leftlabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:fontsize];
    [leftlabel setTextColor:[UIColor whiteColor]];
//    [leftlabel setHidden:![CommonFunction getShowLeftTitle]];
    leftlabel.alpha = [CommonFunction getShowLeftTitle] ? 1 : 0;
    [leftlabel setTag:kTagOfLeftTitle];
    [self addSubview:leftlabel];
    
    UILabel *rightlabel = [[UILabel alloc] initWithFrame:CGRectMake(leftlabel.frame.origin.x + leftlabel.frame.size.width + (kWidthOfScreen - sizeOfImg*2)/2, yOfImages+sizeOfImg+distanceFromImgToTitle, sizeOfImg, heightOftitle)];
    [rightlabel setText:[playModel.wordInfo.rightWord uppercaseString]];
    [rightlabel setTextAlignment:NSTextAlignmentCenter];
    [rightlabel setBackgroundColor:[UIColor clearColor]];
    rightlabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:fontsize];
    [rightlabel setTextColor:[UIColor whiteColor]];
    rightlabel.alpha = [CommonFunction getShowRightTitle] ? 1 : 0;
//    [rightlabel setHidden:![CommonFunction getShowRightTitle]];
    [rightlabel setTag:kTagOfRightTitle];
    [self addSubview:rightlabel];
}

- (void)createAnswerView
{
    answerView = [[AnswerView alloc]initWithFrame:CGRectMake(0, yOfAnswerView, kWidthOfScreen, heightOfAnswerView) andModel:playModel];
    answerView.delegate = self;
    [self addSubview:answerView];
    
    UILabel *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOfAnswerView+yOfAnswerView+distanceFromAnswerViewToAnswerLabel, kWidthOfScreen, heightOfAnswerView)];
    int fontSize = kCheckIfIphone ? 15 : 32;
    [answerLabel setText:[playModel.wordInfo.finalWord uppercaseString]];
    [answerLabel setTextAlignment:NSTextAlignmentCenter];
    [answerLabel setBackgroundColor:[UIColor clearColor]];
    answerLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:fontSize];
    [answerLabel setTextColor:[UIColor whiteColor]];
    [answerLabel setHidden:![CommonFunction getShowAnswer]];
    [answerLabel setTag:kTagOfAnswerTitle];
    [self addSubview:answerLabel];
}

- (void)createTypingView
{
    typingView = [[TypingView alloc]initWithFrame:CGRectMake(0, yOfTypingView, kWidthOfScreen, heightOfTypingView) andModel:playModel];
    typingView.delegate = self;
    [self addSubview:typingView];
}

- (void)createSubViews
{


    
    
    [self setBackgroundColor:[UIColor clearColor]];

    
    [self createNavigationBar];
    [self createImageViews];
    [self createTitles];
    [self createAnswerView];
    [self createTypingView];
    
    int paddingInTypingView = kCheckIfIphone ? 12 : 76;
    int sizeOfCharInTypingView = kCheckIfIphone ? 48 : 96;
    int yOfCharInTypingView = kCheckIfIphone ? 15:30;
    
    hintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    int y = yOfTypingView;
    [hintBtn setFrame:CGRectMake(paddingInTypingView, y+yOfCharInTypingView, sizeOfCharInTypingView, sizeOfCharInTypingView)];
    [hintBtn setBackgroundImage:[UIImage imageNamed:@"hint.png"] forState:UIControlStateNormal];
    [hintBtn addTarget:self action:@selector(hintBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [hintBtn setTag:kTagOfHintButton];
    
    [self addSubview:hintBtn];
    
    if (![CommonFunction checkNoAds] && [CommonFunction checkIfShowAds] && [CommonFunction getShowAdPlayView])
    {
        adbanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, kWidthOfScreen, 50)];
        adbanner.delegate = self;
        
        _bannerIsVisible = NO;
        [self addSubview:adbanner];
    }
}

#pragma mark Handle Gestured

- (void)hintBtnAction
{
    hintInternal = hintInternal * 2;
    [timer invalidate];
    [self after10s];
    [delegate hintBtnTapped];
}

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
    [CommonFunction playSweepSound];
    [[self viewWithTag:kTagOfDarkView] removeFromSuperview];
    [[self viewWithTag:kTagOfNewView] removeFromSuperview];
    [_sender.view removeFromSuperview];
}

- (void)tapLeft:(UITapGestureRecognizer *)_sender
{
    [CommonFunction playSweepSound];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    UIView *darkView = [[UIView alloc]initWithFrame:self.bounds];
    [darkView setBackgroundColor:[UIColor blackColor]];
    [darkView setTag:kTagOfDarkView];
    darkView.alpha = 0.7;
    [self addSubview:darkView];
   
    UIView *newView = [[UIView alloc]initWithFrame:leftView.frame];
    [newView setBackgroundColor:[UIColor whiteColor]];
    [newView.layer setCornerRadius:10.0f];
    
    UIImageView *newImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, sizeOfImg-10, sizeOfImg-10)];
    [newImgView setImage:[self getImageByName:playModel.wordInfo.leftImg]];
    [newView addSubview:newImgView];
    
    [newView setTag:kTagOfNewView];
    [self addSubview:newView];
    
    float k = kCheckIfIphone ? 1 : 0.7f;
    
    [UIView animateWithDuration:0.2 animations:^{
        [newView setFrame:CGRectMake(kWidthOfScreen*(1-k)/2, yOfImages+50, kWidthOfScreen*k, kWidthOfScreen*k)];
        for (UIView *subView in newView.subviews){
            [subView setFrame:CGRectMake(5, 5, kWidthOfScreen*k-10, kWidthOfScreen*k-10)];
        }
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        UIView *clearView = [[UIView alloc]initWithFrame:self.bounds];
        [clearView setBackgroundColor:[UIColor clearColor]];
        
        
        UITapGestureRecognizer *_tapToNormalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToNormal:)];
        [clearView addGestureRecognizer:_tapToNormalGesture];
        
        [self addSubview:clearView];
        
    }];
    

}

- (void)tapRight:(UITapGestureRecognizer *)_sender
{
    [CommonFunction playSweepSound];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    UIView *darkView = [[UIView alloc]initWithFrame:self.bounds];
    [darkView setBackgroundColor:[UIColor blackColor]];
    [darkView setTag:kTagOfDarkView];
    darkView.alpha = 0.7;
    [self addSubview:darkView];
    
    UIView *newView = [[UIView alloc]initWithFrame:rightView.frame];
    [newView setBackgroundColor:[UIColor whiteColor]];
    [newView.layer setCornerRadius:10.0f];
    
    UIImageView *newImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, sizeOfImg-10, sizeOfImg-10)];
    [newImgView setImage:[self getImageByName:playModel.wordInfo.rightImg]];
    [newView addSubview:newImgView];
    
    [newView setTag:kTagOfNewView];
    [self addSubview:newView];
    
    
    float k = kCheckIfIphone ? 1 : 0.7;
    
    [UIView animateWithDuration:0.2 animations:^{
        [newView setFrame:CGRectMake(kWidthOfScreen*(1-k)/2, yOfImages+50, kWidthOfScreen*k, kWidthOfScreen*k)];
        for (UIView *subView in newView.subviews){
            [subView setFrame:CGRectMake(5, 5, kWidthOfScreen*k-10, kWidthOfScreen*k-10)];
        }
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        UIView *clearView = [[UIView alloc]initWithFrame:self.bounds];
        [clearView setBackgroundColor:[UIColor clearColor]];
        
        
        UITapGestureRecognizer *_tapToNormalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToNormal:)];
        [clearView addGestureRecognizer:_tapToNormalGesture];
        
        [self addSubview:clearView];
        
    }];
    
    
}

#pragma mark TypingViewDelegate

- (void)pickCharPress:(NSString *)_char
{
    [CommonFunction playLetterPickSound];
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
        
        [delegate showWinScreenFromPlayView];
        RootController *rootVC = [CommonFunction getRootController];
        AnswerView *copyAnswerView = answerView;
        
        [rootVC.view addSubview:copyAnswerView];
        [rootVC.view addSubview:leftTitleView];
        [rootVC.view addSubview:rightTitleView];
        [leftTitleView setTag:kTagOfLeftTitle];
        [rightTitleView setTag:kTagOfRightTitle];
        [copyAnswerView setTag:kTagOfCopyAnswerView];
//        [delegate showWinScreenFromPlayView];
    }];
    
    

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
        
        [UIView animateWithDuration:1
                         animations:^{
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
        UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, kWidthOfScreen, kHeightOfScreen-44)];
        UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(willRemoveTextOfAnswerView:)];
        [clearView addGestureRecognizer:_tap];
        [self addSubview:clearView];
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
//    NSLog(@"num of removable char : %lu %d",(unsigned long)[listOfRemoveableChar count],r);
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


- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!_bannerIsVisible)
    {
        // If banner isn't part of view hierarchy, add it
        if (adbanner.superview == nil)
        {
            [self addSubview:adbanner];
        }
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
}

- (void)deactiveTimer
{
    [timer invalidate];
    timer = nil;
    
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
