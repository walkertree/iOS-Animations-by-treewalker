//
//  ViewController.m
//  iOS-Animations-by-treewalker
//
//  Created by jiangshu-fu on 16/3/14.
//  Copyright © 2016年 jiangshu-fu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewPlane;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelNumber.text = @"0";

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self planeDepart];
    [self addNumber];
}

- (void) planeDepart
{
    CGPoint originalCenter = self.imageViewPlane.center;
    
    [UIView animateKeyframesWithDuration:1.5
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.25
                                                                animations:^{
                                                                    self.imageViewPlane.center = CGPointMake(originalCenter.x + 80, originalCenter.y -10);
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.4 animations:^{
                                      self.imageViewPlane.transform = CGAffineTransformMakeRotation(-M_PI_4 / 2);
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
                                      self.imageViewPlane.center = CGPointMake(self.imageViewPlane.center.x + 100, self.imageViewPlane.center.y - 50);
                                      self.imageViewPlane.alpha = 0.0f;
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.51 relativeDuration:0.01 animations:^{
                                      self.imageViewPlane.transform = CGAffineTransformIdentity;
                                      self.imageViewPlane.center = CGPointMake(0.0, originalCenter.y);
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.45 animations:^{
                                      self.imageViewPlane.alpha = 1.0;
                                      self.imageViewPlane.center = originalCenter;
                                  }];
                                  
                              } completion:^(BOOL finished) {
                                  
                              }];
}

- (void) addNumber
{
    [UIView animateWithDuration:0.1 animations:^{
        self.labelNumber.text = [NSString stringWithFormat:@"%d",([self.labelNumber.text intValue] + arc4random() % 100 + 9)];
    } completion:^(BOOL finished) {
        [self addNumber];
    }];
}

@end
