//
//  FacebookActivity.m
//  saytheword
//
//  Created by Hoang Le on 7/11/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "FacebookActivity.h"

@implementation FacebookActivity

- (NSString *)activityType
{
    return @"New Activity Type";
}

- (NSString *)activityTitle
{
    return @"Facebook";
}
- (UIImage *) activityImage {
    
    return [UIImage imageNamed:@"bg1136.jpg"];
}
- (BOOL) canPerformWithActivityItems:(NSArray *)activityItems {
    NSLog(@"canPerformWithActivityItems");
    return YES;
}
- (void) prepareWithActivityItems:(NSArray *)activityItems {
    NSLog(@"prepareWithActivityItems");
    
}
- (UIViewController *) activityViewController { return nil; }
- (void) performActivity {
    NSLog(@"zzzzz");
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"facebooks://"]];
}

@end
