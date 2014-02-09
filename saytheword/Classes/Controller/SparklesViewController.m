//
//  SparklesViewController.m
//  saytheword
//
//  Created by Hoang Le on 8/8/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "SparklesViewController.h"
//Header file

#import "QuartzCore/QuartzCore.h"


@interface SparklesViewController ()

@end

@implementation SparklesViewController

//Implementation file

- (void)viewDidLoad
{
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(destroyEmitter) userInfo:nil repeats:YES];
    [self sparklesIt];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)sparklesIt
{
    int delay;
    
    UIImage *image;
    
    int imgSel=[self numberWithMin:0 :6];
    switch (imgSel) {
        case 0:
            image=[UIImage imageNamed:@"green.png"];
            break;
        case 1:
            image=[UIImage imageNamed:@"silver.png"];
            break;
        case 2:
            image=[UIImage imageNamed:@"yellow.png"];
            break;
        case 3:
            image=[UIImage imageNamed:@"red.png"];
            break;
        case 4:
            image=[UIImage imageNamed:@"purple.png"];
            break;
        case 5:
            image=[UIImage imageNamed:@"pink.png"];
            break;
        case 6:
            image=[UIImage imageNamed:@"blue.png"];
            break;
        default:
            image = nil;
            break;
    }
    
    CGPoint pt=CGPointMake([self numberWithMin:0 :320],[self numberWithMin:0 :460]);
    
    float multiplier=0.25f;
    
    //create the emitter layer
    emitter=[CAEmitterLayer layer];
    emitter.emitterPosition=pt;
    emitter.emitterMode=kCAEmitterLayerOutline;
    emitter.emitterShape=kCAEmitterLayerCircle;
    emitter.renderMode=kCAEmitterLayerAdditive;
    emitter.emitterSize=CGSizeMake(100*multiplier, 0);
    
    //Flare particles emitted from the rocket as it flys
    CAEmitterCell *flare = [CAEmitterCell emitterCell];
    flare.contents = ( id)([image CGImage]);
    flare.emissionLongitude = (4 * M_PI) / 2;
    flare.scale = 0.4;
    flare.velocity = 100;
    flare.birthRate = 15;
    flare.lifetime = 30;
    flare.emissionRange = M_PI / 7;
    flare.alphaSpeed = -0.7;
    flare.scaleSpeed = -0.1;
    flare.scaleRange = 0.1;
    flare.beginTime = 0.01;
    flare.duration = 0.7;
    
    emitter.emitterCells=[NSArray arrayWithObject:flare];
    [self.view.layer addSublayer:emitter];
    
    delay=[self numberWithMin:5 :10];
    [self performSelector:@selector(sparklesIt) withObject:nil afterDelay:delay];
}

-(void)destroyEmitter
{
    NSLog(@"destroy emitter called ");
    if (emitter!=nil) {
//        [emitter removeFromSuperlayer];
//        emitter=nil;
    }
}

-(int)numberWithMin:(int)min :(int)max
{
    return rand() % (max - min) + min;
}
@end