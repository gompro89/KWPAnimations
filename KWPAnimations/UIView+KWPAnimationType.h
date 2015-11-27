//
//  UIView+KWPAnimationType.h
//  KWPAnimations
//
//  Created by 朴 根佑 on 2015/11/26.
//  Copyright © 2015年 KWP. All rights reserved.
//

#import <UIKit/UIKit.h>

//KWPAnimationType
typedef NS_ENUM(NSInteger, KWPAnimationType)
{
    KWPAnimationMovingTypeMove = 1,
    KWPAnimationMovingTypeBounce,
    KWPAnimationMovingTypeShake,
    KWPAnimationTransformTypeScale,
    KWPAnimationTransformTypeCornerRadius,
    KWPAnimationTransformTypeBorderWidth,
    KWPAnimationTransformTypeBorderColor
};

//KWPAnimationOptions
typedef NS_ENUM(NSInteger, KWPAnimationDirectionOption)
{
    KWPAnimationDirectionOptionTop = 0,
    KWPAnimationDirectionOptionBottom,
    KWPAnimationDirectionOptionLeft,
    KWPAnimationDirectionOptionRight
};


@interface UIView (KWPAnimationType)
-(NSString*)getAnimationKeyPath:(KWPAnimationType)animationType;
@end
