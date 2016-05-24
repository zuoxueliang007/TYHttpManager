//
//  ViewController.m
//  TYHttpManagerDemo
//
//  Created by tany on 16/5/20.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+MJ.h"
#import "TCategoryRequest.h"

@interface ViewController ()<TYRequestDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 请求 使用block
- (IBAction)requestBlockAction:(id)sender {
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    
    // request 使用继承
    TCategoryRequest *request = [TCategoryRequest requestWithGender:@"1" generation:@"1"];
    // 缓存数据
//    request.requestFromCache = YES;
//    request.cacheResponse = YES;
    [request loadWithSuccessBlock:^(TCategoryRequest *request) {
        NSLog(@"%@ data:%@",request.responseObject,request.responseObject.data);
        [MBProgressHUD showSuccess:@"加载成功!" toView:self.view];
    } failureBlock:^(TCategoryRequest *request, NSError *error) {
        [MBProgressHUD showError:@"加载失败!" toView:self.view];
    }];
}

// 请求 使用delegate
- (IBAction)requestDelegateAction:(id)sender {
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    
    // 不用继承 直接使用request
    TYModelRequest *request = [TYModelRequest requestWithModelClass:[TCatergoryData class]];
    // 可以在appdeleagte 里 设置 TYRequstConfigure baseURL
    request.URLString = @"http://api.liwushuo.com/v2/secondary_banners";
    request.parameters = @{@"gender":@"1",@"generation":@"1"};
    request.delegate = self;
    [request load];
}

#pragma mark - delegate

- (void)requestDidFinish:(TYModelRequest *)request
{
     NSLog(@"%@ data:%@",request.responseObject,request.responseObject.data);
    [MBProgressHUD showSuccess:@"加载成功!" toView:self.view];
}

- (void)requestDidFail:(TYModelRequest *)request error:(NSError *)error
{
     [MBProgressHUD showError:@"加载失败!" toView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
