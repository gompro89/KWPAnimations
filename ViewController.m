//
//  ViewController.m
//  KWPAnimations
//
//  Created by 朴 根佑 on 2015/11/26.
//  Copyright © 2015年 KWP. All rights reserved.
//

#import "ViewController.h"

#import "UIView+KWPAnimation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [view setBackgroundColor:[UIColor blueColor]];
    [view.layer setBorderColor:[UIColor redColor].CGColor];
    
    [self.view addSubview:view];
    
//    [view setTransformAnimationType:KWPAnimationTransformTypeBorderWidth objects:@(10),@(3),@(1),@(10),nil];
    
    [view setMovingAnimationType:KWPAnimationMovingTypeBounce
                 animationOption:KWPAnimationDirectionOptionTop
                     maxDistance:300
                        duration:4
                          serial:NO];
    
    [view setTransformAnimationType:KWPAnimationTransformTypeCornerRadius
                           duration:3
                             serial:NO
                            objects:@(20),@(5),@(10), nil];
    
    
    
    [view setMovingAnimationType:KWPAnimationMovingTypeShake
                 animationOption:KWPAnimationDirectionOptionLeft
                     maxDistance:150
                        duration:2
                          serial:YES];
    
    [view setTransformAnimationType:KWPAnimationTransformTypeBorderWidth
                           duration:5
                             serial:NO
                            objects:@(8),@(5),@(10), nil];
   
    [view setMovingAnimationType:KWPAnimationMovingTypeShake
                 animationOption:KWPAnimationDirectionOptionTop
                     maxDistance:300
                        duration:3
                          serial:NO];
    
    [view setTransformAnimationType:KWPAnimationTransformTypeCornerRadius
                           duration:7
                             serial:NO
                            objects:@(20),@(5),@(10), nil];
    
    
    [view startAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    switch (touch.view.tag) {
        case 1:
            // タグが1のビュー
            NSLog(@"ImageViewに触った");
            break;
        default:
            // それ以外
            NSLog(@"Viewに触った");
            [touch.view startAnimations];
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
