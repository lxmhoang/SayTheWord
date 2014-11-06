//
//  PlayController.m
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "PlayController.h"
#import "IAPViewController.h"

#import <Parse/Parse.h>

@interface PlayController ()

@end

@implementation PlayController
@synthesize playView, playModel, delegate, iapVC;

- (id)initWithPosition:(int)_pos
{
    self = [super init];
    if (self)
    {
        playModel = [[PlayModel alloc] initWithPosition:_pos andLevel:[[[NSUserDefaults standardUserDefaults] objectForKey:@"level"] intValue]];
        NSLog(@"dddddd");
        
        NSString *nibname = kCheckIfIphone ? @"HintsView_ip4" : @"HintsView_iPad";
        hintsView = [[[NSBundle mainBundle] loadNibNamed:nibname owner:nil options:nil] objectAtIndex:0];
        hintsView.delegate = self;
        
        [self.view setFrame:CGRectMake(_pos*kWidthOfScreen + _pos*kShortDisTanceOf2View, 0, kWidthOfScreen, kHeightOfScreen)];
        //
        
        NSLog(@"eeeeee");
        
    }
    
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark playview delegate method

- (void)coinViewTappedFromPlayView
{
    if (iapVC)
    {
        return;
    }
    NSString *nibName = kCheckIfIphone ? @"IAPViewController" : @"IAPViewController_iPad";
    iapVC = [[IAPViewController alloc] initWithNibName:nibName bundle:nil];
    iapVC.delegate = self;
    
    RootController *rootVC = [CommonFunction getRootController];
    
    [rootVC addChildViewController:iapVC];
    [iapVC didMoveToParentViewController:rootVC];
    [rootVC.view addSubview:iapVC.view];
    
    
}

- (void)hintBtnTapped
{
    //    NSLog(@"list of subviwes : %@", self.view.subviews);
    [CommonFunction playSweepSound];
    
    
    hintsView.alpha = 1;
    [hintsView setUp];
    int y = hintsView.bigView.frame.origin.y;
    CGRect frame = hintsView.bigView.frame;
    [hintsView.bigView setFrame:CGRectMake(hintsView.bigView.frame.origin.x, -hintsView.bigView.frame.size.height, hintsView.bigView.frame.size.width, hintsView.bigView.frame.size.height)];
    int dy = kCheckIfIphone ? 25 : 50;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [hintsView.bigView setFrame:CGRectMake(frame.origin.x, y+dy, frame.size.width, frame.size.height)];
    } completion:^(BOOL finished) {
        if (finished)
        {
            
            [UIView animateWithDuration:0.1 animations:^{
                [hintsView.bigView setFrame:CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height)];
            } completion:^(BOOL finished) {
                
            }];
        }
        
        
    }
     ];
    
    
}

- (void)backBtnPressFromPlayView
{
    [playView deactiveTimer];
    [delegate backBtnPressFromPlayController];
}


- (void)showWinScreenFromPlayView
{
    [self takeScreenshot];
    
    [playView deactiveTimer];
    [delegate showWinScreen];
    
    NSLog(@"aaa");
}

#pragma mark

- (void)checkNotification
{
    
    
    // in the case that user doesn't allow, notification but deviceToken is created already, see AppDelegate.m, appwillEnterForeGround
    
    // check if user not allow notification
    
    if ([[[UIApplication sharedApplication] currentUserNotificationSettings] types] == UIUserNotificationTypeNone)
    {
        // user doesn't allow notification
        
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"] == nil)
        {
            // create its own devicetoken by itself
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
            
            [formatter setDateStyle:NSDateFormatterShortStyle];
            [formatter setTimeStyle:NSDateFormatterMediumStyle];
            NSString *deviceToken = [formatter stringFromDate:[NSDate date]];
            deviceToken = [[deviceToken componentsSeparatedByCharactersInSet:
                            [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                           componentsJoinedByString:@""];
            deviceToken = [NSString stringWithFormat:@"__%d__date%@", arc4random()%10,deviceToken];
            
            //        [CommonFunction alert:@"first time" delegate:nil];
            // first time or not ?
            
            PFObject *obj = [[PFObject alloc] initWithClassName:@"Installation"];
            
            [CommonFunction updateInstallationInfoWithObject:obj andDeviceToken:deviceToken];
            [CommonFunction updateConfigurationInfo];
            
            [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"deviceToken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }else
        {
            // user not allow but devicetoken is still exist, that mean either user disabled notification after installing app, or above code was ran before, anw do nothing
        }
        
    }else
    {
        
    }
    
}

#pragma mark default method


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self checkNotification];
    
    
    
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    playView = [[PlayView alloc]initWithModel:playModel];
    [playView setDelegate:self];
    
    [self.view setFrame:playView.bounds];
    [self.view addSubview:playView];
    
    // create HintsView
    
    //    [hintsView setUp];
    [self.view addSubview:hintsView];
    [hintsView setTag:kTagOfHintView];
    hintsView.alpha = 0;
    
    
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(takeScreenshot) withObject:nil afterDelay:2];
}

- (void)takeScreenshot
{
    playView.adbanner.alpha = 0;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [bgImgView setImage:[UIImage imageNamed:bgImage]];
    [playView insertSubview:bgImgView atIndex:0];
    
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [playView.layer renderInContext:context];
    self.screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [bgImgView removeFromSuperview];
    
    playView.adbanner.alpha = 1;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.screenShot = self.screenShot;
}


#pragma mark Hint Delegate methods




- (void)shareFBFromHint
{
    
}

- (void)removeALetterFromHintsView
{
    int numOfRemoveableChars = [playView checkNumOfRemoveableChars];
    if (numOfRemoveableChars == 0)
    {
        [CommonFunction alert:@"There is no removeable char left" delegate:nil];
        
        return;
    }
    
    if ([CommonFunction getCoin]>=[CommonFunction getPriceOfRemovingLetter]){
        [CommonFunction setCanRemoveALetter:NO];
        [CommonFunction setCoin:([CommonFunction getCoin]-[CommonFunction getPriceOfRemovingLetter])];
        
        // record coins spended
        int k = [CommonFunction getCoinsSpended];
        [CommonFunction setCoinsSpended:(k+[CommonFunction getPriceOfRemovingLetter])];
        
        [self updateCoininVIew];
        [self removeALetter];
        
    }else
    {
        [self coinViewTappedFromPlayView];
    }
    
}


- (void)revealALetterFromHintsView
{
    int numOfEmptyLB = [playView checkNumOfEmptyLabelInResultView];
    if (numOfEmptyLB==0){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"The answer view must have at least 1 empty label" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    
    if ([CommonFunction getCoin]>=[CommonFunction getPriceOfRevealingLetter]){
        [CommonFunction setCanRevealALetter:NO];
        [CommonFunction setCoin:([CommonFunction getCoin]-[CommonFunction getPriceOfRevealingLetter])];
        
        
        // record coins spended
        int k = [CommonFunction getCoinsSpended];
        [CommonFunction setCoinsSpended:(k+[CommonFunction getPriceOfRevealingLetter])];
        
        [self updateCoininVIew];
        [self revealALetter:numOfEmptyLB];
        
    }else{
        [self coinViewTappedFromPlayView];
    }
}

- (void)revealLeftWordFromHintsView
{
    if ([CommonFunction getCoin]>=[CommonFunction getPriceOfRevealingLeftPic]){
        [CommonFunction setCoin:([CommonFunction getCoin]-[CommonFunction getPriceOfRevealingLeftPic])];
        
        
        // record coins spended
        int k = [CommonFunction getCoinsSpended];
        [CommonFunction setCoinsSpended:(k+[CommonFunction getPriceOfRevealingLeftPic])];
        
        [self updateCoininVIew];
        [CommonFunction setShowLeftTitle:YES];
        [[playView viewWithTag:kTagOfLeftTitle] setAlpha:1.0];
        
        for (UIView *tmp in self.view.subviews){
            if ([tmp isKindOfClass:[HintsView class]])
            {
                tmp.alpha = 0;
                break;
                
            }
        }
        
    }else{
        [self coinViewTappedFromPlayView];
    }
}

- (void)revealRightWordFromHintsView
{
    if ([CommonFunction getCoin]>=[CommonFunction getPriceOfRevealingRightPic]){
        [CommonFunction setCoin:([CommonFunction getCoin]-[CommonFunction getPriceOfRevealingRightPic])];
        
        // record coins spended
        int k = [CommonFunction getCoinsSpended];
        [CommonFunction setCoinsSpended:(k+[CommonFunction getPriceOfRevealingRightPic])];
        
        
        [self updateCoininVIew];
        [CommonFunction setShowRightTitle:YES];
        [[playView viewWithTag:kTagOfRightTitle] setAlpha:1.0];
        
        for (UIView *tmp in self.view.subviews){
            if ([tmp isKindOfClass:[HintsView class]])
            {
                tmp.alpha = 0;
                break;
                
            }
        }
    }else{
        [self coinViewTappedFromPlayView];
    }
}

#pragma mark IAPViewController delegate method

- (void)updateCoininVIew
{
    [CommonFunction playManyCoinsSound];
    playView.coinLabel.text = [NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"coins"] intValue]];
}


- (void)dismissIAPVC
{
    iapVC = nil;
}

- (void)shareFB:(UIGestureRecognizer *)_tap
{
    
}

#pragma mark functions

- (void)removeALetter
{
    [playView removeALetterFromController];
    NSLog(@"A LETTER HAS BEEN REMOVED");
    for (UIView *tmp in self.view.subviews){
        if ([tmp isKindOfClass:[HintsView class]])
        {
            tmp.alpha = 0;
            break;
            
        }
    }
}

- (void)revealALetter:(int)numOfEmptyLB
{
    int r = [playView getIndexOfRevealLabel:numOfEmptyLB];
    
    [CommonFunction setRevealIndex:r];
    
    
    
    [playView revealALetterFromController:r];
    for (UIView *tmp in self.view.subviews){
        if ([tmp isKindOfClass:[HintsView class]])
        {
            tmp.alpha = 0;
            break;
            
        }
    }
}

#pragma mark UIALertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1){
        NSLog(@"button pressed : %ld", (long)buttonIndex);
        [self coinViewTappedFromPlayView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
