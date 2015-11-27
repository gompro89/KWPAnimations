//
//  UIView+KWPAnimation.m
//  KWPAnimations
//
//  Created by 朴 根佑 on 2015/11/26.
//  Copyright © 2015年 KWP. All rights reserved.
//

#import "UIView+KWPAnimation.h"
#import <objc/runtime.h>

#define NOPE_V -1

#define EnumerateObjects(objects) ({\
NSMutableArray* values = [[NSMutableArray alloc] init];\
va_list args; \
va_start(args, objects); \
for (NSObject* arg = objects; arg != nil; arg = va_arg(args, NSObject*)) \
{ [values addObject:arg]; } \
va_end(args);\
(NSArray*)values;\
})

#define ScreenSize [ [ UIScreen mainScreen ] bounds ].size

@implementation UIView (KWAnimationExtension)

static float delayTime          = 0;
static float previousDuration   = 0;

#pragma mark -
#pragma mark KeyFrames Getter&Setter

- (NSMutableArray<CAKeyframeAnimation*> *)keyFrames {
    NSMutableArray<CAKeyframeAnimation*> *result = objc_getAssociatedObject(self, @selector(keyFrames));
    if (result == nil) {
        // do a lot of stuff
        result = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, @selector(keyFrames), result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return result;
}

-(void) setKeyFrames:(NSMutableArray<CAKeyframeAnimation *> *)keyFrames
{
    objc_setAssociatedObject(self, @selector(keyFrames), keyFrames, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark -
#pragma mark Start Animation

- (void) getGroupAnimations:(CGFloat)duration
                      delay:(CGFloat)delay
                 completion:(BOOL)completion
{
    NSLog(@"delayTime : %f",delayTime);
    
    CAAnimationGroup* groupAnimations = [CAAnimationGroup animation];
    groupAnimations.animations = (NSArray*)self.keyFrames;
    
    if (duration > 0) {
        groupAnimations.duration = duration;
    }
    
    if (delay > 0) {
        groupAnimations.beginTime = delay;
    }
    
    if (completion) {
        groupAnimations.delegate = self;
    }
    
    [self.layer addAnimation:groupAnimations forKey:@"groupAnimations"];
}


-(void) startAnimations
{
    NSLog(@"%f",delayTime + previousDuration);
    [self getGroupAnimations:(delayTime + previousDuration) delay:NOPE_V completion:NO];
}

-(void) animationDuration:(CGFloat)duration
{
    [self getGroupAnimations:duration delay:NOPE_V completion:NO];
}

-(void) animationDuration:(CGFloat)duration delay:(CGFloat)delay
{
    [self getGroupAnimations:duration delay:delay completion:NO];
}

-(void) animationDuration:(CGFloat)duration delay:(CGFloat)delay completion:(CompleteAnimationBlocks)completion
{
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        [self getGroupAnimations:duration delay:delay completion:YES];
        
        if (completion) {
            completion(YES);
        }else{
            completion(NO);
        }
    }];
    
    [queue addOperation:operation];
    
}


#pragma mark -
#pragma mark Check Animation & Direction Type

- (BOOL) checkValidMovingAnimationType:(KWPAnimationType)animationType
{
    if (KWPAnimationMovingTypeMove == animationType ||
        KWPAnimationMovingTypeBounce == animationType ||
        KWPAnimationMovingTypeShake == animationType)
    {
        NSLog(@"KWPMovingAnimationType");
        return YES;
    }
    else
    {
        NSLog(@"KWPTransformAnimationType");
        return NO;
    }
}

- (BOOL) checkVerticalAnimationOption:(KWPAnimationDirectionOption)animationOption
{
    if (KWPAnimationDirectionOptionBottom == animationOption ||
        KWPAnimationDirectionOptionTop == animationOption)
    {
        NSLog(@"VerticalOption");
        return YES;
    }
    
    else
    {
        NSLog(@"HorizontalOption");
        return NO;
    }
}

- (BOOL) checkAnimationDirection:(KWPAnimationDirectionOption)animationOption
{
    if (KWPAnimationDirectionOptionBottom == animationOption ||
        KWPAnimationDirectionOptionRight == animationOption)
    {
        NSLog(@"HorizontalOption(right): x , VerticalOption(bottom) : y");
        return YES;
    }
    
    else
    {
        NSLog(@"HorizontalOption(left): -x , VerticalOption(top) : -y");
        return NO;
    }
    
}


#pragma mark -
#pragma mark Set Moving Animations

-(void) setMovingAnimationType:(KWPAnimationType)animationType
               animationOption:(KWPAnimationDirectionOption)animationOption
                   maxDistance:(CGFloat)maxDistance
{
 
    NSMutableDictionary *animationInfo = [self setAnimationInfo:animationType animationOption:animationOption maxDistance:maxDistance];
    if (animationInfo != nil) {
        CAKeyframeAnimation *animation = [self setValuesMoveAnimationType:animationType
                                                                     move:[[animationInfo objectForKey:@"move"] integerValue]
                                                                  keyPath:[animationInfo objectForKey:@"keyPath"]
                                                              maxDistance:maxDistance];
        [self.keyFrames addObject:animation];
    }
}

-(void) setMovingAnimationType:(KWPAnimationType)animationType
               animationOption:(KWPAnimationDirectionOption)animationOption
                   maxDistance:(CGFloat)maxDistance
                      duration:(CGFloat)duration
                        serial:(BOOL)serial
{
    
    NSMutableDictionary *animationInfo = [self setAnimationInfo:animationType animationOption:animationOption maxDistance:maxDistance];
    if (animationInfo != nil) {
        CAKeyframeAnimation *animation = [self setValuesMoveAnimationType:animationType
                                                                     move:[[animationInfo objectForKey:@"move"] integerValue]
                                                                  keyPath:[animationInfo objectForKey:@"keyPath"]
                                                              maxDistance:maxDistance];
        
        if (duration < 0) {
            NSLog(@"durationが0以下です。再設定してください。");
            NSLog(@"durationのデフォルト値なし");
        }else{
            
            [self setDelayTime:serial currentDuration:duration];
            animation.beginTime = delayTime;
            animation.duration = duration;
            
        }
        [self.keyFrames addObject:animation];
    }
}

- (void)setDelayTime:(BOOL)serial currentDuration:(float)duration
{
    if ([self.keyFrames lastObject] != nil)
    {
        if (serial) {
            delayTime = delayTime + previousDuration;
            previousDuration = 0;
        }
    }
    
    else
    {
        NSLog(@"以前のAnimationがありません。");
    }

    previousDuration = previousDuration < duration ? duration : previousDuration;
}


- (NSMutableDictionary*) setAnimationInfo:(KWPAnimationType)animationType
                          animationOption:(KWPAnimationDirectionOption)animationOption
                              maxDistance:(CGFloat)maxDistance
{
    if ([self checkValidMovingAnimationType:animationType]) {
        
        NSMutableDictionary *animationInfo = [[NSMutableDictionary alloc] init];
        
        NSString *keyPath = [self getAnimationKeyPath:animationType];
        
        if ([self checkVerticalAnimationOption:animationOption])
        {// animationOptionを見てvertical, horizontal判断する
            //VerticalOption
            keyPath = [keyPath stringByAppendingString:@".y"];
        }
        
        else
        {
            //HorizontalOption
            keyPath = [keyPath stringByAppendingString:@".x"];
        }
        
        [animationInfo setObject:keyPath forKey:@"keyPath"];
        
        NSInteger move = [self checkAnimationDirection:animationOption] ? -1 : 1;
        
        if (maxDistance < 0) {
            NSLog(@"maxDistanceの値は0以上入力してください。");
            NSLog(@"0以下の場合(デフォルト値：100.f)");
            maxDistance = 100.f;
        }
        
        [animationInfo setObject:[NSNumber numberWithInteger:move] forKey:@"move"];
        
        return animationInfo;
        
    }else{
        NSLog(@"MovingAnimationType（move, bounce, shakeなど）ではありません。");
        return nil;
    }
}

-(CAKeyframeAnimation*)setValuesMoveAnimationType:(KWPAnimationType)animationType
                                             move:(NSInteger)move
                                          keyPath:(NSString*)keyPath
                                      maxDistance:(CGFloat)maxDistance
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    NSMutableArray *animationValues = [[NSMutableArray alloc] init];
    
    switch (animationType) {
        case KWPAnimationMovingTypeMove:
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            
            [animationValues addObject:@(move * maxDistance)];
            [animationValues addObject:@(0)];
            
            animation.values = (NSArray*)animationValues;
            break;
        case KWPAnimationMovingTypeBounce:
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            
            [animationValues addObject:@(move * maxDistance)];
            while (maxDistance > 20.f) {
                maxDistance /= 2;
                [animationValues addObject:@(0)];
                [animationValues addObject:@(move * maxDistance)];
            }
            
            [animationValues addObject:@(0)];
            
            break;
        case KWPAnimationMovingTypeShake:
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            
            while (maxDistance > 20.f) {
                maxDistance /= 2;
                [animationValues addObject:@(move * maxDistance)];
                [animationValues addObject:@(-move * maxDistance)];
            }
            
            [animationValues addObject:@(0)];
            break;
            
        default:
            NSLog(@"AnimationSetting失敗：正しくないanimationTypeです。");
            return nil;
            break;
    }
    
    animation.values = (NSArray*)animationValues;
    
    return animation;
    
}

#pragma mark -
#pragma mark Set Transform Animation

-(void)setTransformAnimationType:(KWPAnimationType)animationType
                        duration:(CGFloat)duration
                          serial:(BOOL)serial
                         objects:(NSObject*)objects, ...
{
    if (![self checkValidMovingAnimationType:animationType]) {
        NSString *keyPath = [self getAnimationKeyPath:animationType];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
        animation.values = EnumerateObjects(objects);
       
        [self setDelayTime:serial currentDuration:duration];
        
        animation.beginTime = delayTime;
        animation.duration = duration;
        
        [self.keyFrames addObject:animation];
    }else{
        NSLog(@"TransformAnimationTypeではありません。");
    }
}

#pragma mark 

@end
