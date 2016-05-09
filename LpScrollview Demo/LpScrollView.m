//
//  LpScrollView.m
//  LpScrollview Demo
//
//  Created by shenliping on 16/5/6.
//  Copyright © 2016年 shenliping. All rights reserved.
//

#import "LpScrollView.h"
#import "UIImageView+WebCache.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define IMAGEHEIGHT self.frame.size.height

static CGFloat const changeImageTime = 3.0;

@interface LpScrollView (){
    NSInteger index;
    BOOL isTimeUp;
}

@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UIImageView *midImageView;
@property (strong, nonatomic) UIImageView *rightImageView;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation LpScrollView

- (instancetype)initWithFrame:(CGRect)frame LpScrollViewStyle:(LpScrollViewStyle)style ImageArray:(NSMutableArray *)array{
    if (self = [super initWithFrame:frame]) {
        self.lpStyle = style;
        self.imageArray = array;
        self.contentSize = CGSizeMake(SCREENWIDTH * 3, 0);
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        
        [self addSubview:self.leftImageView];
        [self addSubview:self.midImageView];
        [self addSubview:self.rightImageView];
        
       
        
        if (self.lpStyle == LpSCrollVIewStringStyle) {
            [self set_imageWithString];
        }else{
            [self set_imageWithUrl];
        }
        self.contentOffset = CGPointMake(SCREENWIDTH, 0);
        index = 0;
        
        [self set_timer];
        [self set_pageControl];
    }
    return self;
}

#pragma mark -- imageView初始化

- (UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, IMAGEHEIGHT)];
    }
    return _leftImageView;
}

- (UIImageView *)midImageView{
    if (_midImageView == nil) {
        _midImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, IMAGEHEIGHT)];
    }
    return _midImageView;
}

- (UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 2, 0, SCREENWIDTH, IMAGEHEIGHT)];
    }
    return _rightImageView;
}

#pragma mark -- imageView设置image

- (void)set_imageWithString{
    NSInteger count = self.imageArray.count;
    if (count == 1) {
        self.midImageView.image = [UIImage imageNamed:self.imageArray[0]];
       self.leftImageView.image = [UIImage imageNamed:self.imageArray[0]];
        self.rightImageView.image = [UIImage imageNamed:self.imageArray[0]];
    }else if(count == 2){
        self.midImageView.image = [UIImage imageNamed:self.imageArray[0]];
        self.leftImageView.image = [UIImage imageNamed:self.imageArray[1]];
        self.rightImageView.image = [UIImage imageNamed:self.imageArray[1]];
    }else{
        self.midImageView.image = [UIImage imageNamed:self.imageArray[0]];
        self.leftImageView.image = [UIImage imageNamed:self.imageArray[count - 1]];
        self.rightImageView.image = [UIImage imageNamed:self.imageArray[1]];
    }
}

- (void)set_imageWithUrl{
    NSInteger count = self.imageArray.count;
    if (count == 1) {
        [self.midImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[0]] placeholderImage:[UIImage imageNamed:@""]];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[0]] placeholderImage:[UIImage imageNamed:@""]];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[0]] placeholderImage:[UIImage imageNamed:@""]];
    }else if(count == 2){
        [self.midImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[0]] placeholderImage:[UIImage imageNamed:@""]];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[1]] placeholderImage:[UIImage imageNamed:@""]];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[1]] placeholderImage:[UIImage imageNamed:@""]];
    }else{
        [self.midImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[0]] placeholderImage:[UIImage imageNamed:@""]];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[count - 1]] placeholderImage:[UIImage imageNamed:@""]];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[1]] placeholderImage:[UIImage imageNamed:@""]];
    }

}

#pragma mark -- 设置pageControl
- (void)set_pageControl{
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = self.imageArray.count;
    self.pageControl.frame = CGRectMake(SCREENWIDTH - 20*_pageControl.numberOfPages, IMAGEHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    self.pageControl.currentPage = 0;
    self.pageControl.enabled = NO;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor greenColor];
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
}

- (void)addPageControl{
    [[self superview] addSubview:self.pageControl];
}

#pragma mark -- 设置计时器

- (void)set_timer{
    if (self.imageArray.count != 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:changeImageTime target:self selector:@selector(imageViewMoved) userInfo:nil repeats:YES];
        isTimeUp = NO;
    }
}

- (void)imageViewMoved{
    [self setContentOffset:CGPointMake(SCREENWIDTH * 2, 0) animated:YES];
    isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark -- 图片滚动停止后，改变数组顺序
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.contentOffset.x == SCREENWIDTH * 2) {
        if (index == self.imageArray.count - 1) {
            index = 0;
        }else{
            index = index + 1;
        }
    }else{
        if (index == 0) {
            index = self.imageArray.count - 1;
        }else{
            index = index - 1;
        }
    }
    
    self.pageControl.currentPage = index % 3;
    
    if (self.lpStyle == LpSCrollVIewStringStyle) {
        [self string_Decelerating];
    }else{
        [self url_decelerating];
    }
    
    self.contentOffset = CGPointMake(SCREENWIDTH, 0);
    
    if (!isTimeUp) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:changeImageTime]];
    }
    isTimeUp = NO;
}

- (void)string_Decelerating{
    NSInteger count = self.imageArray.count;
    if (index == 0) {
        _leftImageView.image = [UIImage imageNamed:_imageArray[(count - 1)%count]];
        _midImageView.image = [UIImage imageNamed:_imageArray[(index )%count]];
        _rightImageView.image = [UIImage imageNamed:_imageArray[(index + 1)%count]];
    }else{
        _leftImageView.image = [UIImage imageNamed:_imageArray[(index - 1)%count]];
        _midImageView.image = [UIImage imageNamed:_imageArray[(index )%count]];
        _rightImageView.image = [UIImage imageNamed:_imageArray[(index + 1)%count]];
    }
}

- (void)url_decelerating{
    NSInteger count = self.imageArray.count;
    if (index == 0) {
        [_leftImageView sd_setImageWithURL:self.imageArray[(count-1)%count]];
        [_midImageView sd_setImageWithURL:self.imageArray[index%count]];
        [_rightImageView sd_setImageWithURL:self.imageArray[(index+1)%count]];
    }else{
        [_leftImageView sd_setImageWithURL:self.imageArray[(index-1)%count]];
        [_midImageView sd_setImageWithURL:self.imageArray[index%count]];
        [_rightImageView sd_setImageWithURL:self.imageArray[(index+1)%count]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
