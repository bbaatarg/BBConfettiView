//
//  BBConfettiView.h
//  PresentationTest
//
//  Created by Bayarbaatar Gonchigsuren on 7/10/20.
//  Copyright © 2020 Bayarbaatar Gonchigsuren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    ConfettiTypeConfetti,
    ConfettiTypeTraingle,
    ConfettiTypeStar,
    ConfettiTypeDiamond,
    ConfettiTypeRandom
}ConfettiType;

@interface BBConfettiView : UIView

@property(nonatomic, strong) CAEmitterLayer* emitter;
@property(nonatomic, strong) NSArray<UIColor *>* colors;

@property(nonatomic, assign) CGFloat intensity;
@property(nonatomic, assign) ConfettiType type;
@property(nonatomic, assign) BOOL active;

-(void)startConfetti;
-(void)stopConfetti;


@end

NS_ASSUME_NONNULL_END
