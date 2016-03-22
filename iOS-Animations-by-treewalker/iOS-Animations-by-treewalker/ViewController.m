//
//  ViewController.m
//  iOS-Animations-by-treewalker
//
//  Created by jiangshu-fu on 16/3/14.
//  Copyright © 2016年 jiangshu-fu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewClod1;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewClod2;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewClod3;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewClod4;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITextField *labelUserName;
@property (weak, nonatomic) IBOutlet UITextField *labelPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    CAAnimationGroup *groundAnimation = [CAAnimationGroup animation];
    groundAnimation.beginTime = CACurrentMediaTime() + 0.5;
    groundAnimation.duration = 1;
    groundAnimation.fillMode = kCAFillModeBackwards;
    groundAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    groundAnimation.repeatCount = 3;
//    groundAnimation.repeatDuration = 3;
//    groundAnimation.speed = 2.0f;
//    groundAnimation.autoreverses = YES;
    
    CABasicAnimation *scalDown = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scalDown.fromValue = [NSNumber numberWithFloat:3.5];
    scalDown.toValue = [NSNumber numberWithFloat:1.0];
    
    CABasicAnimation *rotate =  [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.fromValue = [NSNumber numberWithFloat:M_PI_4];
    rotate.toValue = [NSNumber numberWithFloat:0];
    
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = [NSNumber numberWithFloat:0];;
    fade.toValue = [NSNumber numberWithFloat:1];
    
    groundAnimation.animations = @[scalDown,rotate,fade];
    [self.buttonLogin.layer addAnimation:groundAnimation forKey:nil];
}

- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%@",[anim valueForKey:@"name"]);
}

- (IBAction)loginInPress:(id)sender {
        CABasicAnimation *flyRight = [CABasicAnimation animationWithKeyPath:@"position.y"];
        flyRight.fromValue = [NSNumber numberWithFloat:0 / 2];
        flyRight.toValue = [NSNumber numberWithFloat:self.view.bounds.size.width / 2 + 20];
        flyRight.duration = 0.5;
        [self.labelTitle.layer addAnimation:flyRight forKey:nil];
        [self.labelUserName.layer addAnimation:flyRight forKey:nil];
        flyRight.fromValue = [NSNumber numberWithFloat:0 / 2];
        flyRight.toValue = [NSNumber numberWithFloat:self.view.bounds.size.width / 2 + 200];
        flyRight.beginTime = CACurrentMediaTime();
        flyRight.fillMode = kCAFillModeForwards;
        flyRight.removedOnCompletion = NO;
        [self.labelPassword.layer addAnimation:flyRight forKey:nil];
}

@end
