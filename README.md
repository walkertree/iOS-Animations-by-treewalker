#iOS Animations
##简单的视图动画

```
+ (void)animateWithDuration:(NSTimeInterval)duration 
					animations:(void (^)(void))animations 

```
改方法可以使用的 UIView 的属性 ：bounds、frame、center、backgroundColor、alpha、transform

###springs
```
+ (void)animateWithDuration:(NSTimeInterval)duration 
							delay:(NSTimeInterval)delay 
 		usingSpringWithDamping:(CGFloat)dampingRatio 
 		initialSpringVelocity:(CGFloat)velocity 
 					options:(UIViewAnimationOptions)options
				animations:(void (^)(void))animations 
				completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);

```
具有弹性的动画：

usingSpringWithDamping ： 代表弹的强度，0.0 - 1.0，数值越小，表示弹的范围越大。

initialSpringVelocity：表示动画的初始速度，数值越大，初始速度越大，初始速度大，也可以造成弹簧来回的速度显示。

###Transution
```
+ (void)transitionWithView:(UIView *)view 
						duration:(NSTimeInterval)duration 
						options:(UIViewAnimationOptions)options 
					animations:(void (^ __nullable)(void))animations 
					completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);

```
视图添加的动画的过渡方法。

###View Animations in Practice

CAEmitterLayer —— 粒子图层

两个 label 之间的过度动画，可以创建一个中间 view，来进行动画的变化。

```
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
```
例如上面的代码，是对一个动画进行上下翻转过渡的动画。auxLabel 用于中间过渡。结束后移除。

###Keyframe Animations
```
+ (void)animateKeyframesWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewKeyframeAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion 
```

在里面添加每一帧的动画

```
+ (void)addKeyframeWithRelativeStartTime:(double)frameStartTime relativeDuration:(double)frameDuration animations:(void (^)(void))animations NS_AVAILABLE_IOS(7_0); 

```
程序会根据添加的帧动画，一步步执行添加的动画。

如下实例：

```
- (void) planeDepart
{
    CGPoint originalCenter = self.imageViewPlane.center;
    
    [UIView animateKeyframesWithDuration:1.5
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.25
                                                                animations:^{
                                                                    self.imageViewPlane.center = CGPointMake(originalCenter.x + 80, originalCenter.y -10);
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.4 animations:^{
                                      self.imageViewPlane.transform = CGAffineTransformMakeRotation(-M_PI_4 / 2);
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
                                      self.imageViewPlane.center = CGPointMake(self.imageViewPlane.center.x + 100, self.imageViewPlane.center.y - 50);
                                      self.imageViewPlane.alpha = 0.0f;
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.51 relativeDuration:0.01 animations:^{
                                      self.imageViewPlane.transform = CGAffineTransformIdentity;
                                      self.imageViewPlane.center = CGPointMake(0.0, originalCenter.y);
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.45 animations:^{
                                      self.imageViewPlane.alpha = 1.0;
                                      self.imageViewPlane.center = originalCenter;
                                  }];
                                  
                              } completion:^(BOOL finished) {
                                  
                              }];
}
```
其中StartTime 和  relativeDuration ：不是指实际上的时间，而是在这个动画的时间百分比。

###Auto Layout
```
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
```

设置完约束的条件之后，进行动画时，只需要在动画的 block 中，加上 [self.view layoutIfNeeded]; 才会有动画。剩下的动画设置和别的都一样。只是对 autolayout 需要继续学习。