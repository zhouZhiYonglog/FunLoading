//
//  ViewController.m
//  FunLoadingView
//
//  Created by 周智勇 on 2019/1/8.
//  Copyright © 2019年 zhouzhiyong. All rights reserved.
//

#import "ViewController.h"
#import "FunLoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showCicked:(id)sender {
    
    [FunLoadingView showSuccessWithText:@"显示成功" view:self.view];
    //    [FunLoadingView showErrorWithText:@"显示错误" view:nil];
    
    //    FunLoadingView *loadView = [[FunLoadingView alloc] initCustomViewWithFrame:self.view.bounds];
    //    loadView.loadImg = [NSString stringWithFormat:@"FunLoading.bundle/%@", @"error"];
    //    loadView.titleText = @"哈哈哈";
    //    loadView.titleColor = [UIColor redColor];
    //    loadView.titleFont = [UIFont systemFontOfSize:20];
    //    [loadView showViewAndHiddenIn:2.0 onView:self.view];
    
}
- (IBAction)indicatorViewClicked:(id)sender {
    [FunLoadingView showIndicatorViewWithText:@"加载中" onView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [FunLoadingView hiddenCurrentShowedOnView:self.view];
    });
}

- (IBAction)gifClicked:(id)sender {
    [FunLoadingView showGIFLoadingOnView:nil text:@"正在加载..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [FunLoadingView hiddenCurrentShowedOnView:nil];
    });
}


@end
