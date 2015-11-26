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
    
    [self.view addSubview:view];
    
    [view setTransformAnimationType:KWPAnimationMovingTypeShake objects:@(10),@(3),@(1),@(10),nil];
    [view animationDuration:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
