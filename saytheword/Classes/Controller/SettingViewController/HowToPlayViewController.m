//
//  HowToPlayViewController.m
//  saytheword
//
//  Created by Hoang Le on 9/20/14.
//  Copyright (c) 2014 Hoang Le. All rights reserved.
//

#import "HowToPlayViewController.h"

@interface HowToPlayViewController ()

@end

@implementation HowToPlayViewController
@synthesize navigationBar, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithPosition:(int)_pos
{
    NSString *nibName = kCheckIfIphone ? @"HowToPlayViewController" : @"HowToPlayViewController_iPad";
    self = [super initWithNibName:nibName bundle:nil];
    if (self)
    {
        [self.view setFrame:CGRectMake(_pos*kWidthOfScreen + _pos*kShortDisTanceOf2View, 0, kWidthOfScreen, kHeightOfScreen)];
        int k = kCheckIfIphone ? 4 : 7;
        self.pic1View.layer.cornerRadius = k;
        self.pic2View.layer.cornerRadius = k;
        
    }
    
    return self;
}

- (IBAction)menuBtnTapped:(id)sender {
    if ([delegate respondsToSelector:@selector(backBtnPressFromHowToController)])
    {
        [delegate backBtnPressFromHowToController];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([CommonFunction getRule])
    {
        
        self.textRule.text = [CommonFunction getRule];
    }
    
    navigationBar.layer.shadowOffset = CGSizeMake(4, 5);
    navigationBar.layer.shadowRadius = 5;
    navigationBar.layer.shadowOpacity = 0.5;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNavigationBar:nil];
    [super viewDidUnload];
}
@end
