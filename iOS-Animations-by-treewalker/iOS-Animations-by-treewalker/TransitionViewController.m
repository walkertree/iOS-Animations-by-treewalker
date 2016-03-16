//
//  Transition.m
//  iOS-Animations-by-treewalker
//
//  Created by jiangshu-fu on 16/3/15.
//  Copyright © 2016年 jiangshu-fu. All rights reserved.
//

#import "TransitionViewController.h"
@interface TransitionViewController()

@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *newnewView;

@end

@implementation TransitionViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.animationView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.animationView];
    
    self.newnewView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black_cat"]];
    [self.animationView addSubview:self.newnewView];
    self.newnewView.center = self.view.center;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"love_cat"]];
    self.imageView.center = self.animationView.center;
    
    [UIView transitionWithView:self.animationView
                      duration:1.0
                       options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.animationView addSubview:self.imageView];
                    } completion:^(BOOL finished) {
                        
                    }];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    if(self.imageView)
//    {
//        [UIView transitionWithView:self.animationView
//                          duration:0.6
//                           options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionFlipFromRight
//                        animations:^{
//                            [self.imageView removeFromSuperview];
//                            self.imageView = nil;
//                        }
//                        completion:nil];
//    }
//    else
//    {
//        
//        self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back_ground"]];
//        self.imageView.center = self.animationView.center;
//        [UIView transitionWithView:self.animationView
//                          duration:1.0
//                           options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionFlipFromRight
//                        animations:^{
//                            [self.animationView addSubview:self.imageView];
//                        } completion:^(BOOL finished) {
//                            
//                        }];
//    }
    
//    [UIView transitionWithView:self.imageView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        self.imageView.hidden = !self.imageView.hidden;
//    } completion:nil];
    
    if(self.imageView.hidden == NO)
    {
        [UIView transitionFromView:self.imageView toView:self.newnewView duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft
                        completion:^(BOOL finish){
                            self.imageView.hidden = YES;
         }];
        
    }
    else
    {
        self.imageView.hidden = NO;
        [UIView transitionFromView:self.newnewView toView:self.imageView duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    }
}

@end
