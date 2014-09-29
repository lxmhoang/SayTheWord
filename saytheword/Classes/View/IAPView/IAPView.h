//
//  IAPView.h
//  saytheword
//
//  Created by Hoang Le on 7/10/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IAPViewDelegate <NSObject>

- (void)IAPselected:(id)_sender;



@end

@interface IAPView : UIView
{
    NSString *bgImgName;
}

@property (nonatomic, strong) NSString *productIdentifier;
@property (nonatomic, unsafe_unretained) id delegate;

- (id)initWithProductIdentifier:(NSString *)PI;

@end
