//
//  HowToPlayViewController.h
//  saytheword
//
//  Created by Hoang Le on 9/20/14.
//  Copyright (c) 2014 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HowToControllerProtocol <NSObject>
- (void)backBtnPressFromHowToController;
@end

@interface HowToPlayViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *navigationBar;
@property (nonatomic, unsafe_unretained) id delegate;


- (id)initWithPosition:(int)_pos;
- (IBAction)menuBtnTapped:(id)sender;

@end
