//
//  AvatarView.h
//  iOS-Animations-by-treewalker
//
//  Created by jiangshu-fu on 16/3/22.
//  Copyright © 2016年 jiangshu-fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarView : UIView

- (void) setImage:(UIImage *)image;

- (void) setText:(NSString *) name;

- (void) bounceOffPoint:(CGPoint)bouncePoint morphSize:(CGSize)morphSize;

@end
