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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *flyRight = [CABasicAnimation animationWithKeyPath:@"position.x"];
        flyRight.fromValue = [NSNumber numberWithFloat:0 / 2];
        flyRight.toValue = [NSNumber numberWithFloat:self.view.bounds.size.width / 2];
        flyRight.duration = 0.5;
        [self.labelTitle.layer addAnimation:flyRight forKey:nil];
        [self.labelUserName.layer addAnimation:flyRight forKey:nil];
        flyRight.fromValue = [NSNumber numberWithFloat:0 / 2];
        flyRight.beginTime = CACurrentMediaTime();
        flyRight.autoreverses = NO;
        [self.labelPassword.layer addAnimation:flyRight forKey:nil];
        
        

    });
    
    CABasicAnimation *cloudA = [CABasicAnimation animationWithKeyPath:@"opacity"];
    cloudA.fromValue = [NSNumber numberWithFloat:0];;
    cloudA.toValue = [NSNumber numberWithFloat:1];;
    cloudA.duration = 2.0;
    [self.imageViewClod1.layer addAnimation:cloudA forKey:nil];
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
