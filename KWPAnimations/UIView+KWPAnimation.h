//
//  UIView+KWPAnimation.h
//  KWPAnimations
//
//  Created by 朴 根佑 on 2015/11/26.
//  Copyright © 2015年 KWP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+KWPAnimationType.h"

@interface UIView (KWAnimationExtension)

typedef void (^CompleteAnimationBlocks)(BOOL result);     //!< animationが終わった時の通知ブロック

@property (retain, nonatomic) NSMutableArray <CAKeyframeAnimation*>* keyFrames;

//start Group Animations
-(void) startAnimations;
-(void) animationDuration:(CGFloat)duration;
-(void) animationDuration:(CGFloat)duration delay:(CGFloat)delay;

//set Moving Animation
-(void)setMovingAnimationType:(KWPAnimationType)animationType
              animationOption:(KWPAnimationDirectionOption)animationOption
                  maxDistance:(CGFloat)maxDistance;

-(void) setMovingAnimationType:(KWPAnimationType)animationType
               animationOption:(KWPAnimationDirectionOption)animationOption
                   maxDistance:(CGFloat)maxDistance
                      duration:(CGFloat)duration
                        serial:(BOOL)serial;

//set Transform Animation
-(void)setTransformAnimationType:(KWPAnimationType)animationType
                        duration:(CGFloat)duration
                          serial:(BOOL)serial
                         objects:(NSObject*)objects, ...NS_REQUIRES_NIL_TERMINATION;

@end
