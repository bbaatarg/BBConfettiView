//
//  BBConfettiView.m
//  PresentationTest
//
//  Created by Bayarbaatar Gonchigsuren on 7/10/20.
//  Copyright © 2020 Bayarbaatar Gonchigsuren. All rights reserved.
//

#import "BBConfettiView.h"

@implementation BBConfettiView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


-(id)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


-(void)setup{

    /*
    self.colors     = @[[UIColor colorWithRed:179.0/255.0 green:208.0/255.0 blue:151.0/255.0 alpha:1.0],
                        [UIColor colorWithRed:131.0/255.0 green:187.0/255.0 blue:97.0/255.0 alpha:1.0],
                        [UIColor colorWithRed:217.0/255.0 green:47.0/255.0 blue:117.0/255.0 alpha:1.0],
                        [UIColor colorWithRed:179.0/255.0 green:66.0/255.0 blue:62.0/255.0 alpha:1.0],
                        [UIColor colorWithRed:233.0/255.0 green:169.0/255.0 blue:78.0/255.0 alpha:1.0],
                        [UIColor colorWithRed:169.0/255.0 green:59.0/255.0 blue:128.0/255.0 alpha:1.0],
                        [UIColor colorWithRed:78.0/255.0 green:118.0/255.0 blue:168.0/255.0 alpha:1.0],
//                        [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:224.0/255.0 alpha:1.0],
                        [UIColor colorWithWhite:205.0/255.0 alpha:1.0]];
     */
    self.colors     = @[[UIColor colorWithRed:0.95 green:0.40 blue:0.27 alpha:1.0],
                        [UIColor colorWithRed:1.00 green:0.78 blue:0.36 alpha:1.0],
                        [UIColor colorWithRed:0.48 green:0.78 blue:0.64 alpha:1.0],
                        [UIColor colorWithRed:0.30 green:0.76 blue:0.85 alpha:1.0],
                        [UIColor colorWithRed:0.58 green:0.39 blue:0.55 alpha:1.0]];
    
    self.intensity  = 0.75;
    self.type       = ConfettiTypeConfetti;
    self.active     = NO;
}

-(void)startConfetti{
    
    self.emitter = [CAEmitterLayer new];
    
    self.emitter.emitterPosition    = CGPointMake(self.frame.size.width/2.0, self.frame.size.height);
    self.emitter.emitterShape       = kCAEmitterLayerPoints;
    self.emitter.emitterSize        = CGSizeMake(self.frame.size.width, 1.0);
    
    NSMutableArray<CAEmitterCell *>* cells = [NSMutableArray new];
    
    for (UIColor* color in self.colors) {
        CAEmitterCell* cell = [self confettiWithColor:color];
        if (cell) {
            [cells addObject:cell];
        }
    }
    
    self.emitter.emitterCells = cells;
    [self.layer addSublayer:self.emitter];
    self.active = YES;
    
    self.emitter.birthRate = 4;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.emitter.birthRate = 0;
    });
}

-(void)stopConfetti{
    
    self.emitter.birthRate = 0;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self setAlpha:0.0];

    } completion:^(BOOL finished) {
        NSLog(@"stopped");
        self.active = NO;
        self.emitter.emitterCells = [NSArray array];
        [self.emitter removeFromSuperlayer];
        [self removeFromSuperview];

    }];
    
}

-(CAEmitterCell *)confettiWithColor:(UIColor *)color{

    UIImage* content = [self imageForType:self.type];
    if (content == nil) {
        return nil;
    }

    CAEmitterCell* confetti = [CAEmitterCell new];
    confetti.birthRate  = 6.0 * self.intensity;
    confetti.lifetime   = 14.0 * self.intensity;
    confetti.lifetimeRange  = 0;
    confetti.color = color.CGColor;
    confetti.velocity   = (float)350.0 * self.intensity;
    confetti.velocityRange  = (float)80.0 * self.intensity;
    confetti.emissionLongitude = M_PI;
    confetti.emissionRange =  M_PI;
    confetti.spin = 3.5 * self.intensity;
    confetti.spinRange = 4.0 * self.intensity;
    confetti.scaleRange = self.intensity;
    confetti.scaleSpeed = -0.1 * self.intensity;
    confetti.contents = (__bridge id _Nullable)content.CGImage;
    
    return confetti;
}

-(BOOL)isActive{
    return self.active;
}

-(UIImage *)imageForType:(ConfettiType)type{

    NSString* fileName;

    switch (type) {
        case ConfettiTypeConfetti:
            fileName = @"confetti.png";
        break;
        case ConfettiTypeTraingle:
            fileName = @"triangle.png";
        break;
        case ConfettiTypeStar:
            fileName = @"star.png";
        break;
        case ConfettiTypeDiamond:
            fileName = @"diamond.png";
        break;
        case ConfettiTypeRandom:{
            NSArray<NSString *>* possibleSharps = @[@"confetti.png",@"traingle.png",@"confetti.png", @"star.png", @"diamond.png"];
            NSUInteger randomIndex = arc4random() % possibleSharps.count;
            fileName = [possibleSharps objectAtIndex:randomIndex];
        }break;
        default:{
            fileName = @"confetti.png";
        }break;
    }
    return [UIImage imageNamed:fileName];
}

@end
