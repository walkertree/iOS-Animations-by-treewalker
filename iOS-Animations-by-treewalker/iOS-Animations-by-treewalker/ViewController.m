//
//  ViewController.m
//  iOS-Animations-by-treewalker
//
//  Created by jiangshu-fu on 16/3/14.
//  Copyright © 2016年 jiangshu-fu. All rights reserved.
//

#import "ViewController.h"

@interface TempViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *tempLabel;

@end

@implementation TempViewCell



@end


@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) NSArray * arrayColor;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"☎︎",@"✉︎",@"♻︎",@"♞",@"✾",@"✈︎"];
    
    self.arrayColor = @[[UIColor colorWithRed:249.0/255.0 green:84.0/255.0 blue:7.0/255.0 alpha:1.0],
                        [UIColor colorWithRed:69.0/255.0 green:59.0/255.0 blue:55.0/255.0 alpha:1.0],
                        [UIColor colorWithRed:249.0/255.0 green:194.0/255.0 blue:7.0/255.0 alpha:1.0],
                        [UIColor colorWithRed:32.0/255.0 green:188.0/255.0 blue:32.0/255.0 alpha:1.0],
                        [UIColor colorWithRed:207.0/255.0 green:34.0/255.0 blue:156.0/255.0 alpha:1.0],
                        [UIColor colorWithRed:14/255.0 green:88/255.0 blue:149/255.0 alpha:1.0]];
    
    self.tableView.layer.anchorPoint = CGPointMake(1.0,self.tableView.layer.anchorPoint.y);
}

- (IBAction)Animation:(id)sender {
    /* The identity transform: [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]. */
[UIView animateWithDuration:0.5
                 animations:^{
                     if(self.tableView.layer.transform.m11 == 1
                        &&self.tableView.layer.transform.m12 == 0
                        &&self.tableView.layer.transform.m13 == 0
                        &&self.tableView.layer.transform.m14 == 0
                        &&self.tableView.layer.transform.m21 == 0
                        &&self.tableView.layer.transform.m22 == 1
                        &&self.tableView.layer.transform.m23 == 0
                        &&self.tableView.layer.transform.m24 == 0
                        &&self.tableView.layer.transform.m31 == 0
                        &&self.tableView.layer.transform.m32 == 0
                        &&self.tableView.layer.transform.m33 == 1
                        &&self.tableView.layer.transform.m34 == 0
                        &&self.tableView.layer.transform.m41 == 0
                        &&self.tableView.layer.transform.m42 == 0
                        &&self.tableView.layer.transform.m43 == 0
                        &&self.tableView.layer.transform.m44 == 1)
                     {
                         self.tableView.layer.transform = [self transformForPercent:0];
                         self.tableView.alpha = 0.2;
                     }
                     else
                     {
                         self.tableView.layer.transform = CATransform3DIdentity;
                         self.tableView.alpha = 1;
                     }
                     
                     //消除锯齿
                     self.tableView.layer.shouldRasterize = YES;
                     self.tableView.layer.rasterizationScale = [UIScreen mainScreen].scale;
                 }];
   
    
}

- (CATransform3D) transformForPercent:(CGFloat)percent
{
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0 / 1000;
    
    CGFloat remainingPercent = 1.0 - percent;
    CGFloat angle = remainingPercent * (-M_PI_2);
    //旋转角度设定
    CATransform3D rotationTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0);
   //旋转位移
    CATransform3D translationTransform = CATransform3DMakeTranslation(-self.tableView.frame.size.width, 0, 0);
    //链接两个变化内容
    return CATransform3DConcat(rotationTransform, translationTransform);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TempViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tempViewCell"];
    
    cell.tempLabel.text = self.array[indexPath.row];
    cell.backgroundColor = self.arrayColor[indexPath.row];
    
    return cell;
}

@end
