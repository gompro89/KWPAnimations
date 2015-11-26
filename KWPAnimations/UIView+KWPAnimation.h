//
//  UIView+KWPAnimation.h
//  KWPAnimations
//
//  Created by 朴 根佑 on 2015/11/26.
//  Copyright © 2015年 KWP. All rights reserved.
//

#import <UIKit/UIKit.h>

//KWPAnimationType
typedef enum {
    KWPAnimationMovingTypeMove = 1,
    KWPAnimationMovingTypeBounce,
    KWPAnimationMovingTypeShake,
    KWPAnimationTransformTypeScale,
    KWPAnimationTransformTypeCornerRadius,
    KWPAnimationTransformTypeBorderWidth,
    KWPAnimationTransformTypeBorderColor,
    
    KWPAnimationTypeCount,
} KWPAnimationType;


extern NSString *const KeyFrameTypeName[KWPAnimationTypeCount];
NSString *const KeyFrameTypeName[KWPAnimationTypeCount] = {
    [KWPAnimationMovingTypeMove]          = @"transform.translation",
    [KWPAnimationMovingTypeBounce]        = @"transform.translation",
    [KWPAnimationMovingTypeShake]         = @"transform.translation",
    [KWPAnimationTransformTypeScale]         = @"transform.scale",
    [KWPAnimationTransformTypeCornerRadius]  = @"cornerRadius",
    [KWPAnimationTransformTypeBorderWidth]   = @"borderWidth",
    [KWPAnimationTransformTypeBorderColor]   = @"borderColor",
};


//KWPAnimationOptions
typedef NS_ENUM(NSInteger, KWPAnimationDirectionOption)
{
    KWPAnimationDirectionOptionTop = 0,
    KWPAnimationDirectionOptionBottom,
    KWPAnimationDirectionOptionLeft,
    KWPAnimationDirectionOptionRight
};


@interface UIView (KWAnimationExtension)

@property (retain, nonatomic) NSMutableArray <CAKeyframeAnimation*>* keyFrames;

//start Group Animations
-(void) startAnimations;
-(void) animationDuration:(CGFloat)duration;
-(void) animationDuration:(CGFloat)duration delay:(CGFloat)delay;
-(void) animationDuration:(CGFloat)duration delay:(CGFloat)delay completion:(BOOL)completion;

//set Moving Animation
-(void)setMovingAnimationType:(KWPAnimationType)animationType
              animationOption:(KWPAnimationDirectionOption)animationOption
                  maxDistance:(CGFloat)maxDistance;

//set Transform Animation
-(void)setTransformAnimationType:(KWPAnimationType)animationType
                         objects:(NSObject*)objects, ... NS_REQUIRES_NIL_TERMINATION;

@end
