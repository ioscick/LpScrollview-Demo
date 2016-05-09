//
//  LpScrollView.h
//  LpScrollview Demo
//
//  Created by shenliping on 16/5/6.
//  Copyright © 2016年 shenliping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LpScrollViewStyle){
    LpSCrollVIewUrlStyle ,
    LpSCrollVIewStringStyle
};

@interface LpScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic) LpScrollViewStyle lpStyle;

@property (copy, nonatomic) NSArray *imageArray;

@property (strong, nonatomic) UIPageControl *pageControl;

- (instancetype)initWithFrame:(CGRect)frame LpScrollViewStyle:(LpScrollViewStyle)style ImageArray:(NSMutableArray *)array;

@end
