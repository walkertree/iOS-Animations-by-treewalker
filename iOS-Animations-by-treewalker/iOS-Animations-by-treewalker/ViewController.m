//
//  ViewController.m
//  iOS-Animations-by-treewalker
//
//  Created by jiangshu-fu on 16/3/14.
//  Copyright © 2016年 jiangshu-fu. All rights reserved.
//

#import "ViewController.h"
#import "AvatarView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelVs;
@property (weak, nonatomic) IBOutlet AvatarView *viewBeats;
@property (weak, nonatomic) IBOutlet AvatarView *viewMe;
@property (weak, nonatomic) IBOutlet UIButton *buttonSearch;

@property (strong, nonatomic) CAGradientLayer *gradientLayer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewBeats setImage:[UIImage imageNamed:@"avatar-2.png"]];
    [self.viewMe setImage:[UIImage imageNamed:@"avatar-1.png"]];
    [self.viewBeats setText:@"Beats"];
    [self.viewMe setText:@"ME"];
    
    [self.viewBeats setNeedsLayout];
    [self.viewMe setNeedsLayout];
    
    
    
    self.gradientLayer = [CAGradientLayer layer];
    // 0.5 、1 都是按照比例来划分的。
    self.gradientLayer.startPoint = CGPointMake(0, 0.5);
    self.gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    self.gradientLayer.colors = @[ (id)[[UIColor redColor] CGColor],
                                    (id)[[UIColor blueColor] CGColor],
                                   (id)[[UIColor greenColor] CGColor]];
    self.gradientLayer.locations = @[[NSNumber numberWithFloat:0.25],[NSNumber numberWithFloat:0.5],[NSNumber numberWithFloat:0.75]];
    self.gradientLayer.frame = CGRectMake( -self.buttonSearch.bounds.size.width,
                                          self.buttonSearch.bounds.origin.y,
                                          3*self.buttonSearch.bounds.size.width,
                                          self.buttonSearch.bounds.size.height);
    [self.buttonSearch.layer addSublayer:self.gradientLayer];
    
    CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradientAnimation.fromValue = @[[NSNumber numberWithFloat:0],
                                    [NSNumber numberWithFloat:0],
                                    [NSNumber numberWithFloat:0.25]];
    gradientAnimation.toValue = @[[NSNumber numberWithFloat:0.5],
                                  [NSNumber numberWithFloat:1.0],
                                  [NSNumber numberWithFloat:1.0]];
    gradientAnimation.duration = 3.0;
    gradientAnimation.repeatCount = INFINITY;
    
    [self.gradientLayer addAnimation:gradientAnimation forKey:nil];
    
    
    
    CAShapeLayer *ovalShapeLayer = [CAShapeLayer layer];
    ovalShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    ovalShapeLayer.lineWidth = 4.0;
    ovalShapeLayer.lineDashPattern = @[[NSNumber numberWithInt:2],
                                       [NSNumber numberWithInt:3]];

    
    CGFloat refreshRadius = self.view.frame.size.width / 3;
    ovalShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.view.frame.size.width / 3,
                                                                            self.view.frame.size.height / 2,
                                                                            refreshRadius,
                                                                            refreshRadius)].CGPath;
    [self.view.layer addSublayer:ovalShapeLayer];
    
    
    UIImage *imageMe = [UIImage imageNamed:@"avatar-1.png"];
    CALayer *imageLayer = [CALayer layer];
    imageLayer.contents = (__bridge id _Nullable)(imageMe.CGImage);
    imageLayer.bounds = CGRectMake(0, 0, imageMe.size.width / 2, imageMe.size.height / 2);
    imageLayer.position = CGPointMake( self.view.center.x + refreshRadius / 2,
                                      self.view.center.y + refreshRadius / 2);
    [self.view.layer addSublayer:imageLayer];
    
    imageLayer.opacity = 1.0;
    
    
    
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = [NSNumber numberWithFloat:-0.5];
    startAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = [NSNumber numberWithFloat:0];
    endAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    CAAnimationGroup * storkeAnimationGroup = [CAAnimationGroup animation];
    storkeAnimationGroup.duration = 1.5;
    storkeAnimationGroup.repeatCount = 5;
    storkeAnimationGroup.animations = @[startAnimation,endAnimation];
    [ovalShapeLayer addAnimation:storkeAnimationGroup forKey:nil];
    
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path = ovalShapeLayer.path;
    keyAnimation.calculationMode = kCAAnimationPaced;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    
    CAAnimationGroup * flyAnimationGroup = [CAAnimationGroup animation];
    flyAnimationGroup.duration = 1.5;
    flyAnimationGroup.repeatCount = 5;
    flyAnimationGroup.animations = @[keyAnimation,rotationAnimation];
    [imageLayer addAnimation:flyAnimationGroup forKey:nil];
    
    
}

- (IBAction)searchPress:(id)sender {
    self.viewMe.translatesAutoresizingMaskIntoConstraints = YES;
//    opponentAvatar.shouldTransitionToFinishedState = true

}

- (void) viewDidAppear:(BOOL)animated
{
    [self searchForOpponent];
}


- (void) searchForOpponent
{
    CGSize avatarSize = self.viewMe.frame.size;
    CGFloat bounceXOffset = self.viewMe.frame.size.width / 1.9;
    CGSize morphSize = CGSizeMake(avatarSize.width * 0.85, avatarSize.height * 1.1);
    
    CGPoint rightBouncePoint = CGPointMake(self.view.frame.size.width / 2 + bounceXOffset,
                                           self.viewMe.center.y);
    CGPoint leftBouncePoint = CGPointMake(self.view.frame.size.width / 2 - bounceXOffset,
                                          self.viewMe.center.y);
    
    
    [self.viewMe bounceOffPoint:rightBouncePoint morphSize:morphSize];
    [self.viewBeats bounceOffPoint:leftBouncePoint morphSize:morphSize];
}





@end
