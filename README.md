# FunLoading
加载等待视图。对MBProgressHUD的简化版本，同时增加GIF图片loading的功能。

##一、静态图片+文字
默认成功、失败两种图片。并延时2秒自动消失。
#### 1.简化加载

```
/**
 加载一个图文提示框 成功 view为nil默认加载到window

 @param text 文本
 @param view 父视图
 */
+ (void)showSuccessWithText:(NSString *__nullable)text view:(UIView *__nullable)view;
```
#### 2.自定义加载


```
/**
 初始化一个custom图文视图对象，方便设置属性值

 @param frame 该视图frame
 @return 对象
 */
- (instancetype)initCustomViewWithFrame:(CGRect)frame;
/**
 显示一个custom对象视图

 @param delay 延时隐藏时间
 @param view 父视图
 */
- (void)showViewAndHiddenIn:(CGFloat)delay onView:(UIView *)view;
```
## 二、系统指示器类型的loading


```
/**
 加载一个包含系统指示器的视图

 @param text 文本
 @param view 父视图
 */
+ (void)showIndicatorViewWithText:(NSString *__nullable)text onView:(UIView *)view;
```
## 三、GIF类型的loading

#### GIF资源可以根据实际需求替换bundle内部图片文件
```
/**
 显示一个GIF动图的框（图片如需替换，可以直接修改原GIF图资源）

 @param view 父视图
 @param text 文本。文本也可直接设计在GIF每一帧，此时text为nil即可
 */
+ (void)showGIFLoadingOnView:(UIView *__nullable)view text:(NSString *)text;
```


