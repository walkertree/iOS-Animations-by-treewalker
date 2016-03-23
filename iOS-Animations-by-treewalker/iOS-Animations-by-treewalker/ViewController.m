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
