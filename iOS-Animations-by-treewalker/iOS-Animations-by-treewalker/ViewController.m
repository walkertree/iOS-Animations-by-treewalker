//
//  ViewController.m
//  iOS-Animations-by-treewalker
//
//  Created by jiangshu-fu on 16/3/14.
//  Copyright © 2016年 jiangshu-fu. All rights reserved.
//

#import "ViewController.h"

#define Items (@[@"Icecream money", @"Great weather", @"Beach ball", @"Swim suit for him", @"Swim suit for her", @"Beach games", @"Ironing board", @"Cocktail mood", @"Sunglasses", @"Flip flops"])

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuHeightConstraint;

@property (nonatomic, assign) BOOL isMenuOpen;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isMenuOpen = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)menuButtonPress:(id)sender {
    
    self.isMenuOpen = !self.isMenuOpen;
    self.menuHeightConstraint.constant = self.isMenuOpen == YES ? 200 : 60;
    self.labelTitle.text = self.isMenuOpen ? @"Select Item" : @"Packing List";
    self.buttonMenu.transform = self.isMenuOpen ?CGAffineTransformMakeRotation(M_PI_4) : CGAffineTransformIdentity;
    
    for (NSLayoutConstraint *item in self.labelTitle.superview.constraints)
    {
        if(item.secondItem == self.labelTitle && item.secondAttribute == NSLayoutAttributeCenterX)
        {
            item.constant = self.isMenuOpen ? 100:0;
            NSLog(@"%@,%d,%d",item,item.secondAttribute,item.firstAttribute);
            continue;

        }
        
        if(item.firstItem == self.labelTitle && item.firstAttribute == NSLayoutAttributeCenterY)
        {
            [self.labelTitle.superview removeConstraint:item];
            continue;

        }
        
        NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:self.labelTitle
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.labelTitle.superview
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:(self.isMenuOpen ? 0.67:1.0)
                                                                          constant:5.0];
        newConstraint.active = YES;
        
    }
    
    
    
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         //这一句有加，才会有动画
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                     }];
}

- (void) showItem:(NSInteger) index
{
    NSLog(@"tapped item : %@",Items[index]);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = Items[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"summericons_100px_0%d.png",indexPath.row ]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showItem:indexPath.row];
}

@end
