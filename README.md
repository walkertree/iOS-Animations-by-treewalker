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