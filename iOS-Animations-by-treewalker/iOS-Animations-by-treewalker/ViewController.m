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
