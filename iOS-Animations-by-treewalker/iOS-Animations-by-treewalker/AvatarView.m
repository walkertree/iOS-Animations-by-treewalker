//
//  AvatarView.m
//  iOS-Animations-by-treewalker
//
//  Created by jiangshu-fu on 16/3/22.
//  Copyright © 2016年 jiangshu-fu. All rights reserved.
//

#import "AvatarView.h"

@interface AvatarView()

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat animationDuration;

@property (nonatomic, strong) CALayer *photoLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIImage *photoImage;

@end

@implementation AvatarView


- (void)awakeFromNib
{
    self.lineWidth = 6.0;
    self.animationDuration = 1.0;
    self.photoLayer = [CALayer layer];
    self.circleLayer = [CAShapeLayer layer];
    self.maskLayer = [CAShapeLayer layer];
    self.label = [[UILabel alloc]init];
    self.label.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0f];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor blackColor];
    [self addSubview:self.label];
}

- (void) setImage:(UIImage *)image;
{
    self.photoLayer.contents = (__bridge id _Nullable)(image.CGImage);
    self.photoImage = image;
}
- (void) setText:(NSString *) name
{
    self.label.text = name;
}

- (void) bounceOffPoint:(CGPoint)bouncePoint morphSize:(CGSize)morphSize
{
    CGPoint originalCenter = self.center;
    [UIView animateWithDuration:self.animationDuration
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.center = bouncePoint;
                     } completion:^(BOOL finished) {
                         
                     }];
    
    [UIView animateWithDuration:self.animationDuration
                          delay:self.animationDuration
         usingSpringWithDamping:0.7
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.center = originalCenter;
                     } completion:^(BOOL finished) {
                         [self bounceOffPoint:bouncePoint morphSize:morphSize];
                     }];
    CGRect morphedFrame = (originalCenter.x > bouncePoint.x) ?
    CGRectMake(0, self.bounds.size.height - morphSize.height, morphSize.width, morphSize.height) :
    CGRectMake(self.bounds.size.width - morphSize.width, self.bounds.size.height - morphSize.height, morphSize.width, morphSize.height);
    
    CABasicAnimation *morphAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    morphAnimation.duration = self.animationDuration;
    morphAnimation.toValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithOvalInRect:morphedFrame].CGPath);
    morphAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut] ;
    
    [self.circleLayer addAnimation:morphAnimation forKey:nil];
    [self.maskLayer addAnimation:morphAnimation forKey:nil];
}

- (void)didMoveToWindow
{
    [self.layer addSublayer:self.photoLayer];
}

- (void)layoutSubviews
{
//{(bounds.size.width - image.size.width + lineWidth)/2
    self.photoLayer.frame = CGRectMake((self.bounds.size.width - self.photoImage.size.width + self.lineWidth) / 2,
                                       (self.bounds.size.height - self.photoImage.size.height - self.lineWidth) / 2,
                                       self.photoImage.size.width,
                                       self.photoImage.size.height);
    
    self.circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;     // 方形的内接圆
    self.circleLayer.strokeColor = [UIColor whiteColor].CGColor;                            // 画笔颜色
    self.circleLayer.lineWidth = self.lineWidth;                                            // 线条的宽度
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;                              // 形状内的填充颜色
    
    self.maskLayer.path = self.circleLayer.path;
    self.maskLayer.position = CGPointMake(0, 10);
    
    self.label.frame = CGRectMake(0, self.bounds.size.height + 10, self.bounds.size.width, 24.0f);
    
    self.photoLayer.mask = self.maskLayer;
    [self.layer addSublayer:self.circleLayer];
    
}

@end
