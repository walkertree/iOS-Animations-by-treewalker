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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinerView;

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
    
    self.headLabel.center = CGPointMake(self.headLabel.center.x - self.view.frame.size.width,
                                        self.headLabel.center.y) ;
    self.passwordTextField.center = CGPointMake(self.passwordTextField.center.x - self.view.bounds.size.width,
                                                self.passwordTextField.center.y) ;
    self.nameTextField.center = CGPointMake(self.nameTextField.center.x - self.view.bounds.size.width,
                                            self.nameTextField.center.y) ;
    
    self.loginButton.center = CGPointMake(self.loginButton.center.x,
                                          self.view.center.y + 100);
    self.loginButton.alpha = 0.0f;
    self.spinerView.alpha = 0.0f;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
  
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
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
        self.passwordTextField.center = CGPointMake(self.view.center.x,
                                                self.passwordTextField.center.y) ;
        
    } completion:nil];
    
    
    
    [UIView animateKeyframesWithDuration:2.0f
                                   delay:1.0f
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear                              animations:^{
                                  self.topLeftImage.alpha = 1.0f;
                                  self.topRightImage.alpha = 1.0f;
                                  self.bottomLeftImage.alpha = 1.0f;
                                  self.bottomRightImage.alpha = 1.0f;
                                  
                              } completion:nil];

    [UIView animateWithDuration:0.5
                          delay:0.5
         usingSpringWithDamping:0.5
          initialSpringVelocity:0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.loginButton.center = CGPointMake(self.loginButton.center.x,
                                                              self.view.center.y );
                         self.loginButton.alpha = 1.0f;
                    
                     }
                     completion:nil];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"%@",keyPath);
}

- (IBAction)loginPress:(id)sender {
    
    [UIView animateWithDuration:1.5
                          delay:0.0
         usingSpringWithDamping:0.2
          initialSpringVelocity:0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.loginButton.bounds = CGRectMake(self.loginButton.bounds.origin.x,
                                                             self.loginButton.bounds.origin.y,
                                                             self.loginButton.bounds.size.width + 30 ,
                                                             self.loginButton.bounds.size.height);
                     } completion:nil];
    [UIView animateWithDuration:0.33
                          delay:0.0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.loginButton.center = CGPointMake(self.loginButton.center.x,
                                                               self.loginButton.center.y + 30 );
                         self.loginButton.backgroundColor = [UIColor colorWithRed:0.84 green:0.83 blue:0.62 alpha:1.0f];
                         
                         self.spinerView.center = CGPointMake(self.loginButton.frame.origin.x + 20,
                                                              self.loginButton.frame.origin.y + self.loginButton.bounds.size.height / 2);
                        self.spinerView.alpha = 1.0;
                         
                         self.passwordTextField.frame = CGRectMake(self.passwordTextField.frame.origin.x, self.passwordTextField.frame.origin.y, self.passwordTextField.frame.size.width + 30, self.passwordTextField.frame.size.height);
                     }
                     completion:nil];
    



    [self.spinerView startAnimating];
}


@end
