//
//  FunProgressView.m
//  FunProgressHub
//
//  Created by 周智勇 on 2019/1/7.
//  Copyright © 2019年 zhouzhiyong. All rights reserved.
//

#import "FunLoadingView.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface FunLoadingView ()

@property (nonatomic, strong)UIView *partnerView;
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel *titleLable;

@property (nonatomic, strong)NSData *imageData;
@end

@implementation FunLoadingView
/*
 弹窗需求：
 1.显示正确 - 图片+文字 延时自动消失
 2.显示错误 - 图片+文字 延时自动消失
 
 功能点：文字可变、文字颜色字体大小可变、图片可变、隐藏时间可控。
       可通过封装方法简单调用
        可单独显示文字、图片
 
 3.显示加载系统指示器 - 指示器+文字 手动取消
 功能点：文字可变、文字颜色字体大小可变
 
 4.加载GIF动态图 + 文字 || GIF图自带文字
 */

- (void)initOriginPropertyValue{
    [self registerKVO];
    
    self.titleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    self.titleColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1];
}

- (instancetype)initCustomViewWithFrame:(CGRect)frame{
    if ([self initWithFrame:frame]) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWith/2 - 14, kScreenHeight/2 - 14, 28, 28)];
        [self addSubview:imgView];
        self.imgView = imgView;
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imgView.frame) + 10, kScreenWith - 20, 20)];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLable];
        self.titleLable = titleLable;
        
        [self initOriginPropertyValue];
    }
    return self;
}

- (instancetype)initIndicatorViewWithFrame:(CGRect)frame{
    if ([self initWithFrame:frame]) {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWith/2 - 14, kScreenHeight/2 - 14, 28, 28)];
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        CGAffineTransform transform = CGAffineTransformMakeScale(1.5, 1.5);
        indicatorView.transform = transform;
        [indicatorView startAnimating];
        [self addSubview:indicatorView];
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(indicatorView.frame) + 5, kScreenWith - 20, 20)];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLable];
        self.titleLable = titleLable;
        
        [self initOriginPropertyValue];
    }
    return self;
}

- (instancetype)initGIFViewWithFrame:(CGRect)frame{
    if ([self initWithFrame:frame]) {
        FLAnimatedImageView *gifView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(kScreenWith/2 - 30, kScreenHeight/2 - 30, 60, 60)];
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:self.imageData];
        gifView.animatedImage = image;
        gifView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:gifView];
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(gifView.frame) + 5, kScreenWith - 20, 20)];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLable];
        self.titleLable = titleLable;
        
        [self initOriginPropertyValue];
    }
    return self;
}

- (NSData *)imageData {
    if (!_imageData) {
//        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"FunLoading" ofType:@"bundle"]];
        NSBundle *bundle = [FunLoadingView bundleWithBundleName:@"FunLoading" podName:nil];
        NSString *path = [bundle pathForResource:@"loading4" ofType:@"gif"];
        _imageData = [NSData dataWithContentsOfFile:path];
    }
    return _imageData;
}

+ (void)showTextWithText:(NSString *)text icon:(UIImage *)icon view:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    FunLoadingView *loadingView = [[FunLoadingView alloc] initCustomViewWithFrame:view.bounds];
    loadingView.loadImg = icon;
    loadingView.titleText = text;
    loadingView.partnerView = view;
    [loadingView showViewAndHiddenIn:2];
}
//显示、定时移除
- (void)showViewAndHiddenIn:(CGFloat)delay{
    [self.partnerView addSubview:self];
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.10 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.10 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeScale(0.1, 0.1);
            self.transform = transform;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    });
}

#pragma mark -- 显示各种视图

+ (void)showSuccessWithText:(NSString *)text view:(UIView *)view{
    NSBundle *bundle = [FunLoadingView bundleWithBundleName:@"FunLoading" podName:nil];
    NSString *path = [bundle pathForResource:@"success@2x" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];

    [self showTextWithText:text icon:image view:view];
}

+ (void)showErrorWithText:(NSString *)text view:(UIView *)view{
    NSBundle *bundle = [FunLoadingView bundleWithBundleName:@"FunLoading" podName:nil];
    NSString *path = [bundle pathForResource:@"error@2x" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    [self showTextWithText:text icon:image view:view];
}

- (void)showViewAndHiddenIn:(CGFloat)delay onView:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    self.partnerView = view;
    [self showViewAndHiddenIn:delay];
}

+ (void)showIndicatorViewWithText:(NSString *)text onView:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hiddenCurrentShowedOnView:view];
    
    FunLoadingView *loadingView = [[FunLoadingView alloc] initIndicatorViewWithFrame:view.bounds];
    loadingView.titleText = text;
    loadingView.partnerView = view;
    [loadingView.partnerView addSubview:loadingView];
}

+ (void)showGIFLoadingOnView:(UIView *)view text:(NSString *)text{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hiddenCurrentShowedOnView:view];
    
    FunLoadingView *loadingView = [[FunLoadingView alloc] initGIFViewWithFrame:view.bounds];
    loadingView.titleText = text;
    loadingView.partnerView = view;
    [loadingView.partnerView addSubview:loadingView];
}

#pragma mark --- 移除（指示器类型、GIF类型通用）

+ (void)hiddenCurrentShowedOnView:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[self class]]) {
            [UIView animateWithDuration:0.10 animations:^{
                CGAffineTransform transform = CGAffineTransformMakeScale(0.1, 0.1);
                subView.transform = transform;
            } completion:^(BOOL finished) {
                [subView removeFromSuperview];
            }];
        }
    }
}
#pragma mark --- kvo

- (void)registerKVO{
    for (NSString *keyPath in [self observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (NSArray *)observableKeypaths {
    return [NSArray arrayWithObjects:@"loadImg", @"titleText",@"titleFont",@"titleColor", nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:keyPath waitUntilDone:NO];
    } else {
        [self updateUIForKeypath:keyPath];
    }
}

#pragma mark -- 根据KVO做出相应更新处理

- (void)updateUIForKeypath:(NSString *)keyPath {
    if ([keyPath isEqualToString:@"loadImg"]) {
        self.imgView.image = _loadImg;
    }else if ([keyPath isEqualToString:@"titleText"]) {
        self.titleLable.text = _titleText;
    }else if ([keyPath isEqualToString:@"titleFont"]) {
        self.titleLable.font = _titleFont;
    }else if ([keyPath isEqualToString:@"titleColor"]) {
        self.titleLable.textColor = _titleColor;
    }
    [self setNeedsLayout];
    [self setNeedsDisplay];
}
/*
- (void)updateSubViewsOffSet:(CGFloat)viewOffSetY{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            CGRect lableFrame = self.titleLable.frame;
            lableFrame.origin.y += viewOffSetY;
            self.titleLable.frame = lableFrame;
        }else{
            CGRect subFrame = subView.frame;
            subFrame.origin.y += viewOffSetY;
            subView.frame = subFrame;
        }
    }
}
*/
#pragma mark -- 后去获取bundle里面的z图片资源

+ (NSBundle *)bundleWithBundleName:(NSString *)bundleName podName:(NSString *)podName{
    if (bundleName == nil && podName == nil) {
        @throw @"bundleName和podName不能同时为空";
    }else if (bundleName == nil ) {
        bundleName = podName;
    }else if (podName == nil) {
        podName = bundleName;
    }
    
    
    if ([bundleName containsString:@".bundle"]) {
        bundleName = [bundleName componentsSeparatedByString:@".bundle"].firstObject;
    }
    //没使用framwork的情况下
    NSURL *associateBundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    //使用framework形式
    if (!associateBundleURL) {
        associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
        associateBundleURL = [associateBundleURL URLByAppendingPathComponent:podName];
        associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
        NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
        associateBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
    }
    
    NSAssert(associateBundleURL, @"取不到关联bundle");
    //生产环境直接返回空
    return associateBundleURL?[NSBundle bundleWithURL:associateBundleURL]:nil;
}

#pragma mark -- dealloc

- (void)dealloc {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}
@end
