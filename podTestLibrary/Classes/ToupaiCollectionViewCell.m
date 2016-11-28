//
//  ToupaiCollectionViewCell.m
//  testCollection
//
//  Created by fangwenyu on 16/6/1.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "ToupaiCollectionViewCell.h"
#import "UIView+WYView.h"
#import "UIColor+WYColor.h"
#import "BroadcasterModel.h"
#import "iCarousel.h"
#import "BaseController.h"

@interface ToupaiCollectionViewCell() <UIScrollViewDelegate, iCarouselDelegate, iCarouselDataSource>

@property (nonatomic, strong)UIScrollView *scrollV;

@property (nonatomic, strong)UIPageControl *pageControl;

@property (nonatomic, strong)iCarousel *icarousel;

@property (nonatomic, strong)NSTimer *timer; //轮播定时器
@end

@implementation ToupaiCollectionViewCell

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSTimer *)timer {
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        ZNLog(@"timer start...");
    }
    return _timer;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.scrollV = [[UIScrollView alloc]initWithFrame:self.bounds];
        self.scrollV.delegate = self;
        self.scrollV.pagingEnabled = YES;
        self.scrollV.showsHorizontalScrollIndicator = NO;
        //[self addSubview:self.scrollV];
        
        self.icarousel = [[iCarousel alloc]initWithFrame:self.bounds];
        self.icarousel.delegate = self;
        self.icarousel.dataSource = self;
        self.icarousel.pagingEnabled = YES;        
        [self addSubview:self.icarousel];
        
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 8)];
        self.pageControl.bottom = self.height - 3;
        self.pageControl.left = (self.width - 100) / 2;
        self.pageControl.numberOfPages = 4;
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithHex:0xff0d0014 alpha:1];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHex:0xfffec500 alpha:1];
        
        [self addSubview:self.pageControl];
        
        [self timer];
    }
    
    return self;
}

- (void)initContents:(NSMutableArray *)arr {
    
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:arr];
    [self.dataArr addObjectsFromArray:arr];
    
    self.pageControl.numberOfPages = self.dataArr.count;
    [self.icarousel reloadData];
    
}

#pragma mark - iCarouselDelegate
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    self.pageControl.currentPage = carousel.currentItemIndex;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    //NSLog(@"did selected index: %d", index);
    if ([[self viewController] isKindOfClass:[BaseController class]]) {
        [((BaseController *)[self viewController]) watchLiveWithBroadcaster:[self.dataArr objectAtIndex:index]];
    }
}

#pragma mark - iCarouselDataSource 
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    
    return self.dataArr.count;
    
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    BroadcasterModel *model = [self.dataArr objectAtIndex:index];
    
    if (view) {
        //ZNLog();
        [(ToupaiView *)view setInfo:model];
    }
    else {
        //ZNLog();
        ToupaiView *toupaiView = [[ToupaiView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        
        [toupaiView setInfo:model];
        
        view = toupaiView;
    }
    
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (scrollView.contentOffset.x + scrollView.width / 2)  / scrollView.width;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}

- (void)setTimerStart:(BOOL)flag {
    if (flag) {
        [self timer];
    }
    else {
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
            ZNLog(@"timer invalidate...");
        }
    }
}

//轮播
- (void)scroll {
    [self.icarousel scrollByNumberOfItems:1 duration:1];
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}



@end
