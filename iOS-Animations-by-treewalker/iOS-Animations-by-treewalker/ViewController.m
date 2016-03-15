//
//  ViewController.m
//  iOS-Animations-by-treewalker
//
//  Created by jiangshu-fu on 16/3/14.
//  Copyright © 2016年 jiangshu-fu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomLeftImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomRightImage;
@property (weak, nonatomic) IBOutlet UIImageView *topRightImage;
@property (weak, nonatomic) IBOutlet UIImageView *topLeftImage;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.passwordTextField addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.topLeftImage.alpha = 0.0f;
    self.topRightImage.alpha = 0.0f;
    self.bottomLeftImage.alpha = 0.0f;
    self.bottomRightImage.alpha = 0.0f;

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.headLabel.center = CGPointMake(self.headLabel.center.x - self.view.frame.size.width,
                                        self.headLabel.center.y) ;
    self.passwordTextField.center = CGPointMake(self.passwordTextField.center.x - self.view.bounds.size.width,
                                                self.passwordTextField.center.y) ;
    self.nameTextField.center = CGPointMake(self.nameTextField.center.x - self.view.bounds.size.width,
                                            self.nameTextField.center.y) ;
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.0f animations:^{
        self.headLabel.center = CGPointMake(self.view.center.x,
                                            self.headLabel.center.y) ;
    }];
    
    [UIView animateKeyframesWithDuration:1.0f delay:0.5f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.nameTextField.center = CGPointMake(self.view.center.x,
                                                self.nameTextField.center.y) ;
        
    } completion:nil];
    [UIView animateKeyframesWithDuration:1.0f
                                   delay:0.7f
                                 options:UIViewKeyframeAnimationOptionRepeat|UIViewKeyframeAnimationOptionAutoreverse|UIViewAnimationOptionCurveEaseInOut /*有加速减速显示的过程*/
                              animations:^{
        self.passwordTextField.center = CGPointMake(self.view.center.x,
                                                self.passwordTextField.center.y) ;
        
    } completion:nil];
    
    
    
    [UIView animateKeyframesWithDuration:5.0f
                                   delay:4.0f
                                 options:UIViewKeyframeAnimationOptionRepeat                              animations:^{
                                  self.topLeftImage.alpha = 1.0f;
                                  self.topRightImage.alpha = 1.0f;
                                  self.bottomLeftImage.alpha = 1.0f;
                                  self.bottomRightImage.alpha = 1.0f;
                                  
                              } completion:nil];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"%@",keyPath);
}


@end
