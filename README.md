#iOS Animations
##简单的视图动画

```
+ (void)animateWithDuration:(NSTimeInterval)duration 
					animations:(void (^)(void))animations 

```
改方法可以使用的 UIView 的属性 ：bounds、frame、center、backgroundColor、alpha、transform

##springs
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

##Transution
```
+ (void)transitionWithView:(UIView *)view 
						duration:(NSTimeInterval)duration 
						options:(UIViewAnimationOptions)options 
					animations:(void (^ __nullable)(void))animations 
					completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);

```
视图添加的动画的过渡方法。

##View Animations in Practice

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

##Keyframe Animations
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

##Auto Layout
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

##Layer Animations

* fillMode属性的设置：（动画是否在开始或者结束的时候，显示 layer 位置）

   * 1、kCAFillModeRemoved 这个是默认值，也就是说当动画开始前和动画结束后，动画对layer都没有影响，动画结束后，layer会恢复到之前的状态

   * 2、kCAFillModeForwards 当动画结束后，layer会一直保持着动画最后的状态


   * 3、kCAFillModeBackwards 在动画开始前，只需要将动画加入了一个layer，layer便立即进入动画的初始状态并等待动画开始。


   * 4、kCAFillModeBoth 这个其实就是上面两个的合成.动画加入后开始之前，layer便处于动画初始状态，动画结束后layer保持动画最后的状态

**removedOnCompletion** 是否移除动画,返回到初始的位置，和 **fillMode** 配合使用。默认为 YES,即回到初始状态。

* 速度控制函数(CAMediaTimingFunction)：


   * 1、kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉


   * 2、kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开


   * 3、kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地


   * 4、kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。这个是默认的动画行为。


##Animation Keys and Delegates

* delegate

``` 
 @interface NSObject (CAAnimationDelegate)

/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim;

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

@end
```
layer 动画的委托回调，动画开始和结束的响应。

可以根据    

```     
[flyRight setValue:@"labelTitle" forKey:@"name"];
```

设置动画的 key-value 值，然后，根据

```
[flyRight valueForKey:@"name"]

```

来识别是哪一个动画结束或者开始。

根据 

```
info.layer.animationKeys())
```

获得动画的 keypath


##Groups and Advanced Timing

* Groups

```
	CAAnimationGroup *groundAnimation = [CAAnimationGroup animation];
    groundAnimation.beginTime = CACurrentMediaTime() + 0.5;
    groundAnimation.duration = 0.5;
    groundAnimation.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *scalDown = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scalDown.fromValue = [NSNumber numberWithFloat:3.5];
    scalDown.toValue = [NSNumber numberWithFloat:1.0];
    
    CABasicAnimation *rotate =  [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.fromValue = [NSNumber numberWithFloat:M_PI_4];
    rotate.toValue = [NSNumber numberWithFloat:0];
    
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = [NSNumber numberWithFloat:0];;
    fade.toValue = [NSNumber numberWithFloat:1];
    
    groundAnimation.animations = @[scalDown,rotate,fade];
    [self.buttonLogin.layer addAnimation:groundAnimation forKey:nil];
```
EaseIn & EaseOut

   * Ease:是缓慢的，即 In —— 进入时缓慢，动画开始慢慢加速； 
   * Out —— 进入时最快，动画慢慢减速。
   * EaseInEaseOut —— 进入和退出都是缓慢的，中间是快速的状态
   
autoreverses：反向恢复动画 和 repeatCount（次数）、 repeatDuration（重复时间） 配合使用。效果更佳

layer.speed： CAAnimationGroup 没有作用。

##Shapes and Masks
 * UIBezierPath
    * 用来绘制 Shapes 形状

```
self.circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;     // 方形的内接圆    
self.circleLayer.strokeColor = [UIColor whiteColor].CGColor;                            // 画笔颜色 
self.circleLayer.lineWidth = self.lineWidth;                                            // 线条的宽度
self.circleLayer.fillColor = [UIColor clearColor].CGColor;                              // 形状内的填充颜色
```

* Masks
   * CALayer 中 mask 用来添加该图层的遮盖物图层

   
   
   
##Gradient Animations

![Gradient Example](https://raw.githubusercontent.com/walkertree/iOS-Animations-by-treewalker/Gradient_Animations/Example.png)

   渐变色的动画：
   
   ```
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
    
   ```
    

* CAGradientLayer： 渐变色的图层。根据设置动画的 location 属性，设置颜色的位置。 位置都一以比例来设置的。
    
* 如果要在文字上做渐变色。可以使用文字进行绘图（NSString drawInRect）。获取文字的图层信息图层，在文字图层上设置渐变色图层，则，文字上就会有渐变色。

##Stroke and Path Animations

CAShapeLayer 中的： 

 * strokeStart ： 表示绘画的图形显示的范围，0 表示全显示， 1 表示全隐藏  （0-1 ： 绘画图形的比例）
 * strokeEnd ：表示绘画的图形显示的范围，1 表示全显示， 0 表示全隐藏

 ![Gradient Example](https://raw.githubusercontent.com/walkertree/iOS-Animations-by-treewalker/Stroke_and_Path_Animations/Example.png)
 
 旋转代码：
 
    ```
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
    
 ```    
 
* 上面表示旋转的代码。主要就是设置 strokeStart 和 strokeEnd 设置一个旋转的过程。 
* path 动画，可以根据获取到的绘图的 path，赋值给 CAKeyframeAnimation 进行动画的过程