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