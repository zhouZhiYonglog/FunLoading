//
//  FunProgressView.h
//  FunProgressHub
//
//  Created by 周智勇 on 2019/1/7.
//  Copyright © 2019年 zhouzhiyong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FunLoadingView : UIView

@property (nonatomic, strong)UIImage *loadImg;//图片
@property (nonatomic, copy)NSString *titleText;//文本
@property (nonatomic, strong)UIFont *titleFont;//文本字体
@property (nonatomic, strong)UIColor *titleColor;//文本颜色
//@property (nonatomic, assign)CGFloat viewOffSetY;//loadView在Y轴偏移量


/**
 加载一个图文提示框 成功 view为nil默认加载到window

 @param text 文本
 @param view 父视图
 */
+ (void)showSuccessWithText:(NSString *__nullable)text view:(UIView *__nullable)view;
/**
 加载一个图文提示框 失败 view为nil默认加载到window
 
 @param text 文本
 @param view 父视图
 */
+ (void)showErrorWithText:(NSString *__nullable)text view:(UIView *__nullable)view;

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

/**
 加载一个包含系统指示器的视图

 @param text 文本
 @param view 父视图
 */
+ (void)showIndicatorViewWithText:(NSString *__nullable)text onView:(UIView *)view;

/**
 隐藏现有提示视图

 @param view 包含该视图的父视图
 */
+ (void)hiddenCurrentShowedOnView:(UIView *__nullable)view;

/**
 显示一个GIF动图的框（图片如需替换，可以直接修改原GIF图资源）

 @param view 父视图
 @param text 文本。文本也可直接设计在GIF每一帧，此时text为nil即可
 */
+ (void)showGIFLoadingOnView:(UIView *__nullable)view text:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
