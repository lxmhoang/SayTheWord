//
//  ExplodeView.m
//  Anagrams
//
//  Created by Marin Todorov on 16/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "ExplodeView.h"
#import "QuartzCore/QuartzCore.h"

@implementation ExplodeView
{
  CAEmitterLayer* _emitter;
}

@synthesize delegate, range;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    //initialize the emitter
    _emitter = (CAEmitterLayer*)self.layer;
    _emitter.emitterPosition = CGPointMake(self.bounds.size.width /2, self.bounds.size.height/2 );
    _emitter.emitterSize = self.bounds.size;
    _emitter.emitterMode = kCAEmitterLayerAdditive;
    _emitter.emitterShape = kCAEmitterLayerRectangle;
  }
  return self;
}

+ (Class) layerClass
{
  //configure the UIView to have emitter layer
  return [CAEmitterLayer class];
}

-(void)didMoveToSuperview
{
  [super didMoveToSuperview];
  if (self.superview==nil) return;
  
  UIImage* texture = [UIImage imageNamed:@"particle.png"];
  NSAssert(texture, @"particle.png not found");
  
  CAEmitterCell* emitterCell = [CAEmitterCell emitterCell];
  
  emitterCell.contents = (id)[texture CGImage];
  
  emitterCell.name = @"cell";
    

    
   
  
  emitterCell.birthRate = 500;
  emitterCell.lifetime = 2.75;
    
//  emitterCell.greenRange = 0.99;
//  emitterCell.greenRange = -8.8;
    
 
  

  emitterCell.blueRange = 0.33;
  emitterCell.blueSpeed = -2.33;
    
//    emitterCell.alphaSpeed = -0.2;

//    int k = arc4random()%3;
//    NSLog(@"k = %d",k);
//    switch (k) {
//        case 0:
//            emitterCell.redRange = 0.99;
//            emitterCell.redSpeed = -8.8;
//            break;
//        case 1:
//            emitterCell.blueRange = 0.33;
//            emitterCell.blueSpeed = -2.33;
//
//            break;
//
//        case 2:
//            emitterCell.greenRange = 0.99;
//            emitterCell.greenSpeed = -8.8;
//
//            break;
//            
//        default:
//            break;
//    }
    
//    emitterCell.redRange = 4.0;
//    emitterCell.redSpeed = 0.5;
//    emitterCell.blueRange = 3.0;
//    emitterCell.blueSpeed = 0.5;
//    emitterCell.greenRange = 5.0;
//    emitterCell.greenSpeed = 0.5;
//    emitterCell.alphaSpeed = -0.2;
    
  
  emitterCell.velocity = 100;
  emitterCell.velocityRange = 00;
  
  emitterCell.scaleRange = 0.0;
  emitterCell.scaleSpeed = 0.0;
    
//    emitterCell.color = [[UIColor redColor] CGColor];
  
  emitterCell.emissionRange = M_PI*2;
  
  _emitter.emitterCells = @[emitterCell];
  
  [self performSelector:@selector(disableEmitterCell) withObject:nil afterDelay:0.1];
  [self performSelector:@selector(rebirth) withObject:nil afterDelay:2.0];
  [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2.0];
    
}

- (void)rebirth
{
    [delegate genNewEV:range];
}

-(void)disableEmitterCell
{
  [_emitter setValue:@0 forKeyPath:@"emitterCells.cell.birthRate"];
}

@end
