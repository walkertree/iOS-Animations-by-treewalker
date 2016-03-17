//
//  ViewController.m
//  iOS-Animations-by-treewalker
//
//  Created by jiangshu-fu on 16/3/14.
//  Copyright © 2016年 jiangshu-fu. All rights reserved.
//

#import "ViewController.h"
#import "SnowView.h"

typedef enum : NSUInteger {
    Positive = 1,
    Negative = -1,
} AnimationDirection;

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) SnowView *snowView;

@property (nonatomic, strong) UILabel *labelTitle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createViews];
    
}

- (void) createViews
{
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"bg-snowy"];
    
    
    self.snowView = [[SnowView alloc]initWithFrame: CGRectMake(-150, -100, 300, 50)];
    UIView *snowClipView = [[UIView alloc]initWithFrame:CGRectOffset(self.view.frame, 0, 50) ];
    snowClipView.clipsToBounds = YES;
    [snowClipView addSubview:self.snowView];
    [self.view addSubview:snowClipView];
    self.snowView.hidden = NO;
    
    
    self.labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 3, 50)];
    self.labelTitle.center = CGPointMake(self.view.center.x, 25);
    self.labelTitle.text = @"高德地图";
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.backgroundColor = [UIColor clearColor];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:self.labelTitle];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.snowView.alpha == 1)
    {
        [self fadeImageView:self.imageView
                    toImage:[UIImage imageNamed:@"bg-sunny"]
                 showEffect:NO];
    }
    else
    {
        [self fadeImageView:self.imageView
                    toImage:[UIImage imageNamed:@"bg-snowy"]
                 showEffect:YES];
    }
    

    AnimationDirection direction = Negative;
//      文字翻转
//    [self cubeTransition:self.labelTitle text:@"木蜗壳" direction: direction];
//      文字淡入淡出
    CGPoint offset = CGPointMake(((int)direction) * 80, 0.0f);
    [self moveLable:self.labelTitle text:@"木蜗壳" offset:offset];
    
}

#pragma mark - ---  动画方法  ---
- (void) fadeImageView:(UIImageView *)imageView
               toImage:(UIImage *)image
            showEffect:(BOOL)effect
{
    [UIView transitionWithView:imageView
                      duration:1.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        imageView.image = image;
                    } completion:^(BOOL finished) {
                        
                    }];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.snowView.alpha = effect ? 1.0 : 0.0;
                     } completion:^(BOOL finished) {
                         
                     }];
}


- (void) cubeTransition:(UILabel *)label text:(NSString *)text direction:(AnimationDirection) direction
{
    UILabel *auxLabel = [[UILabel alloc]initWithFrame:label.frame];
    auxLabel.text = text;
    auxLabel.font = label.font;
    auxLabel.textAlignment = label.textAlignment;
    auxLabel.backgroundColor = [UIColor clearColor];
    auxLabel.textColor = label.textColor;
    CGFloat auxLabelOffset = ((int)(direction) * label.frame.size.height) / 2.0f;
    auxLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0f, 0.1f),
                                                 CGAffineTransformMakeTranslation(0.0f, auxLabelOffset));
    [label.superview addSubview:auxLabel];
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         auxLabel.transform = CGAffineTransformIdentity;
                         label.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0f, 0.1f), CGAffineTransformMakeTranslation(0.0, -auxLabelOffset));
                     } completion:^(BOOL finished) {
                         label.text = auxLabel.text;
                         label.transform = CGAffineTransformIdentity;
                    
                         [auxLabel removeFromSuperview];
                     }];
}


- (void) moveLable:(UILabel *)label text:(NSString *)text offset:(CGPoint)offset
{
    UILabel *auxLabel = [[UILabel alloc]initWithFrame:label.frame];
    auxLabel.text = text;
    auxLabel.font = label.font;
    auxLabel.textAlignment = label.textAlignment;
    auxLabel.backgroundColor = [UIColor clearColor];
    auxLabel.textColor = label.textColor;
    
    auxLabel.transform = CGAffineTransformMakeTranslation(offset.x, offset.y);
    auxLabel.alpha = 0;
    [self.view addSubview:auxLabel];
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.labelTitle.transform = CGAffineTransformMakeTranslation(offset.x, offset.y);
                         self.labelTitle.alpha = 0.0f;
                     } completion:^(BOOL finished) {
                         
                     }];
    
    [UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         auxLabel.transform = CGAffineTransformIdentity;
                         auxLabel.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         
                     }];
}

@end
