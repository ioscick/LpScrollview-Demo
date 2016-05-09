//
//  ViewController.m
//  LpScrollview Demo
//
//  Created by shenliping on 16/5/6.
//  Copyright © 2016年 shenliping. All rights reserved.
//

#import "ViewController.h"
#import "LpScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"goods1.jpg", @"goods2.jpg", @"Default-Landscape_375h@2x.png"];
    LpScrollView *scrollView = [[LpScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100) LpScrollViewStyle:LpSCrollVIewStringStyle ImageArray:array];
    [self.view addSubview:scrollView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
