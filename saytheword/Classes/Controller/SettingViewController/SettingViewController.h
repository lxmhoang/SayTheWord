//
//  SettingViewController.h
//  saytheword
//
//  Created by StarHub Imac Admin on 28/2/14.
//  Copyright (c) 2014 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SettingControllerProtocol <NSObject>

- (void)backBtnPressFromSettingController;
@end

@interface SettingViewController : UIViewController
{
    UISlider *bgMusicVolumSilder;
}

@property (nonatomic, assign) id delegate;

- (id)initWithPosition:(int)_pos;

@end
