//
//  UIView+KWPAnimationType.m
//  KWPAnimations
//
//  Created by 朴 根佑 on 2015/11/26.
//  Copyright © 2015年 KWP. All rights reserved.
//

#import "UIView+KWPAnimationType.h"

@implementation UIView (KWPAnimationType)

-(NSString*)getAnimationKeyPath:(KWPAnimationType)animationType
{

    switch (animationType) {
        case KWPAnimationMovingTypeMove:
            return @"transform.translation";
            break;
        case KWPAnimationMovingTypeBounce:
            return @"transform.translation";
            break;
        case KWPAnimationMovingTypeShake:
            return @"transform.translation";
            break;
        case KWPAnimationTransformTypeScale:
            return @"transform.scale";
            break;
        case KWPAnimationTransformTypeCornerRadius:
            return @"cornerRadius";
            break;
        case KWPAnimationTransformTypeBorderWidth:
            return @"borderWidth";
            break;
        case KWPAnimationTransformTypeBorderColor:
            return @"borderColor";
            break;
        default:
            break;
    }
    
}

@end
