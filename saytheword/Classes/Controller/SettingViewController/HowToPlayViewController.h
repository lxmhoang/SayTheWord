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

@property (strong, nonatomic) IBOutlet UIView *pic1View;
@property (strong, nonatomic) IBOutlet UIView *pic2View;
@property (strong, nonatomic) IBOutlet UILabel *textRule;

- (id)initWithPosition:(int)_pos;
- (IBAction)menuBtnTapped:(id)sender;

@end
