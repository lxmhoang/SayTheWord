//
//  MenuController.m
//  saytheword
//
//  Created by Hoang le on 5/28/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "MenuController.h"

@interface MenuController ()

@end

@implementation MenuController

@synthesize menuView,menuModel,delegate;

#pragma mark InitMethod

- (id)initWithPosition:(int)_pos
{
    self = [super init];
    if (self){
        menuModel = [[MenuModel alloc]initWithPosition:_pos];
        [self.view setFrame:CGRectMake(_pos*kWidthOfScreen + _pos*kShortDisTanceOf2View, 0, kWidthOfScreen, kHeightOfScreen)];
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

#pragma mark ActionMethod

- (void)play
{
//    NSLog(@"PLAY ....");
//    PlayController *playController = [[PlayController alloc] init];
//    [self addChildViewController:playController];
//    [playController.view setFrame:CGRectMake(320, 0, 320, playController.view.bounds.size.height)];
//    [self.view addSubview:playController.view];
//    
//    [UIView animateWithDuration:2 animations:^{
//        [self.view setFrame:CGRectMake(-320, 0, 320, self.view.bounds.size.height)];
//
//    }];
//    [playController release];
}

#pragma mark MenuView Delegate Method

- (void)resetLevel
{
    [CommonFunction setLevel:1];
    [delegate playActionFromMenuController];
}

- (void)playBtnPressFromMenuView
{
    [delegate playActionFromMenuController];
}

- (void)howtoBtnPressFromMenuView
{
    [delegate howtoActionFromMenuController];
}

- (void)coinViewTappedFromMenuView
{
    StoreController *storeController = [[StoreController alloc]init];
    storeController.delegate = self;
    //    [self presentViewController:storeController animated:YES completion:nil];
    //    [storeController release];
    [self addChildViewController:storeController];
    
    [self.view addSubview:storeController.view];
}

#pragma mark StoreController delegate method

- (void)updateCoininVIew
{
    
    menuView.coinLabel.text = [NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"coins"] intValue]];
}

- (void)shareFB:(UIGestureRecognizer *)_tap
{
    
}

#pragma mark Default Method

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    menuView = [[MenuView alloc]initWithModel:menuModel];
    menuView.delegate = self;
    [self.view addSubview:menuView];
    [menuView release];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
