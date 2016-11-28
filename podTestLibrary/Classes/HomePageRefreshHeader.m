//
//  HomePageRefreshHeader.m
//  iShow
//
//  Created by fangwenyu on 16/6/2.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "HomePageRefreshHeader.h"
#import "UIColor+WYColor.h"

@interface HomePageRefreshHeader()
{
    UILabel *_lblLastUpdateTime;
    
    CALayer *diamondLayer;
    CALayer *dotLayer;
    
    CGSize sizeDiamond;
    CGSize sizeDot;
    
    CGFloat selfHeight;
    
    BOOL _needUpdateRefreshTime;
    
}
@property (nonatomic, strong) CAKeyframeAnimation *keyframeRotate;
@property (nonatomic, strong) CAKeyframeAnimation *animationShine;

@end

@implementation HomePageRefreshHeader

//- (void)placeSubviews {
//    
//    [super placeSubviews];
//
//}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, -101, SCREEN_WIDTH, 101);
        //[self setBackgroundColor:[UIColor redColor]];
        
        UIImage *imgDiamond = [UIImage imageNamed:@"front_page_loading_icon"];
        UIImage *imgDot = [UIImage imageNamed:@"home_page_loading_spot"];
        sizeDiamond = imgDiamond.size;
        sizeDot = imgDot.size;
        
        diamondLayer = [CALayer layer];
        diamondLayer.frame = CGRectMake((self.frame.size.width -  imgDiamond.size.width )/ 2, self.frame.size.height - 53, imgDiamond.size.width, imgDiamond.size.height);
        //diamondLayer.anchorPoint = CGPointMake(0.5, 1);
        diamondLayer.contents = (__bridge id _Nullable)(imgDiamond.CGImage);
        [self.layer addSublayer:diamondLayer];
        
        dotLayer = [CALayer layer];
        dotLayer.frame = CGRectMake(0, 0, imgDot.size.width, imgDot.size.height);
        dotLayer.contents = (__bridge id _Nullable)(imgDot.CGImage);
        dotLayer.position = CGPointMake(diamondLayer.bounds.size.width / 2, diamondLayer.bounds.size.height / 2);
        [diamondLayer addSublayer:dotLayer];

        _lblLastUpdateTime = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height - 30, self.width, 12)];
        _lblLastUpdateTime.textColor = [UIColor colorWithHex:0xff989599 alpha:1];
        _lblLastUpdateTime.font = [UIFont customLightFontOfSize:10];
        _lblLastUpdateTime.textAlignment = NSTextAlignmentCenter;
        
        // 格式化日期
        //[self updateTime];
        
        [self addSubview:_lblLastUpdateTime];
        
        _needUpdateRefreshTime = YES;
        
        selfHeight = self.frame.size.height;
        
        _lastUpdatedTimeTag = 0;
        
        
    }
    return self;
}

- (void)setIsForBlackBackground:(BOOL)isForBlackBackground {

    _isForBlackBackground = isForBlackBackground;
    
    UIImage *imgDiamond = [UIImage imageNamed:isForBlackBackground ? @"front_page_loading_icon" : @"front_page_loading_icon_1"];
    UIImage *imgDot = [UIImage imageNamed:isForBlackBackground ? @"home_page_loading_spot" : @"home_page_loading_spot_1"];
    diamondLayer.contents = (__bridge id _Nullable)(imgDiamond.CGImage);
    dotLayer.contents = (__bridge id _Nullable)(imgDot.CGImage);
    
    
}


- (void)beginRefreshing {
    
    if (self.isRefreshing) {
        return;//不加的话，会执行两次，导致动画效果有问题，原因不明
    }
    [super beginRefreshing];
    [self startAnimation];
    //[self updateTime];
    
}

- (void)endRefreshing {
    
    [self stopAnimation];
    [self updateTime];
    [super endRefreshing];
}

- (void)updateTime {
    
    ZNLog(@"update time :%@", self.lastUpdatedTimeKey);
    // 格式化日期
    __block NSString *text = @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSTimeInterval timeInverval = - [self.lastUpdatedTime timeIntervalSinceNow];
        text = [self lastUpdatedTimeStringWithTimeInterval:timeInverval];
        dispatch_async(dispatch_get_main_queue(), ^{
            _lblLastUpdateTime.text = text;
        });
    });
    
    _needUpdateRefreshTime = NO;
}

- (NSString *)lastUpdatedTimeStringWithTimeInterval:(NSTimeInterval)timeInterval {
    NSString *str = @"";
    if (timeInterval < 0) {
        return str;
    }
    else if (timeInterval >= 0 && timeInterval < 60) {
        str = @"刚刚";
    }
    else if (timeInterval >= 60 && timeInterval < 3600) {
        str = [NSString stringWithFormat:@"%.0f分钟前", timeInterval / 60];
    }
    else if (timeInterval >= 3600 && timeInterval < 3600 * 24) {
        str = [NSString stringWithFormat:@"%.0f小时前", timeInterval / 3600];
    }
    else {
        str = [NSString stringWithFormat:@"%.0f天前", timeInterval / 3600 / 24];
    }
    return str;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    CGFloat old = [[change valueForKey:NSKeyValueChangeOldKey]CGPointValue].y;
    CGFloat new = [[change valueForKey:NSKeyValueChangeNewKey]CGPointValue].y;
    
    //条件过滤
    if (-new > self.scrollViewOriginalInset.top + selfHeight || -new < self.scrollViewOriginalInset.top || new == old) {
        return;
    }
    
    if (-old == self.scrollViewOriginalInset.top && old != new) {
        _needUpdateRefreshTime = YES; //初始状态 开始动的时候
    }
    if (-new > self.scrollViewOriginalInset.top && _needUpdateRefreshTime) {
        [self updateTime];
    }
    
    CGFloat scale = (- new - self.scrollViewOriginalInset.top) / selfHeight;
    
    if (new - old >= selfHeight) {   //刷新结束，KVO观察到offset突然从最大变成0，没有过渡，所以需要人工加上动态变化效果
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.5];
        diamondLayer.bounds = CGRectMake(0, 0, sizeDiamond.width * scale, sizeDiamond.height * scale);
        diamondLayer.position = CGPointMake(self.frame.size.width / 2, selfHeight - 53 - diamondLayer.bounds.size.height / 2);
        dotLayer.opacity = -new / selfHeight;
        dotLayer.position = CGPointMake(diamondLayer.bounds.size.width / 2, diamondLayer.bounds.size.height / 2);
        dotLayer.transform = CATransform3DMakeScale(scale, scale, 1);
        [CATransaction commit];
    }
    
    else {
        //禁用隐式动画
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        //diamondLayer.bounds = CGRectMake(0, 0, sizeDiamond.width * scale, sizeDiamond.height * scale);
        diamondLayer.bounds = CGRectMake(0, 0, sizeDiamond.width * scale, sizeDiamond.height * scale);
        diamondLayer.position = CGPointMake(self.frame.size.width / 2, selfHeight - 53 - diamondLayer.bounds.size.height / 2);
        dotLayer.opacity = - new / selfHeight;
        dotLayer.position = CGPointMake(diamondLayer.bounds.size.width / 2, diamondLayer.bounds.size.height / 2);
        dotLayer.transform = CATransform3DMakeScale(scale, scale, 1);
        [CATransaction commit];
    }
    
    if (_needUpdateRefreshTime) {
        [self updateTime];
    }
    
    //ZNLog(@"offset:%f ==> %f", old, new);
}


- (CAKeyframeAnimation *)keyframeRotate {
    
    if (!_keyframeRotate) {
        
        NSValue *value0 = [NSNumber numberWithFloat:0.0];
        NSValue *value1 = [NSNumber numberWithFloat:1 * M_PI];
        NSValue *value2 = [NSNumber numberWithFloat:1 * M_PI];
        NSValue *value3 = [NSNumber numberWithFloat:2 * M_PI];
        NSValue *value4 = [NSNumber numberWithFloat:2 * M_PI];
        
        _keyframeRotate = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        _keyframeRotate.duration = 6;
        //_keyframeRotate.fillMode = kCAFillModeForwards;
        _keyframeRotate.repeatCount = 100000;
        _keyframeRotate.values = @[value0, value1, value2, value3, value4];
        
        NSValue *time0 = [NSNumber numberWithFloat:0.0];
        NSValue *time1 = [NSNumber numberWithFloat:0.16];
        NSValue *time2 = [NSNumber numberWithFloat:0.5];
        NSValue *time3 = [NSNumber numberWithFloat:0.66];
        NSValue *time4 = [NSNumber numberWithFloat:1.0];
        
        _keyframeRotate.keyTimes = @[time0, time1, time2, time3, time4];
    }
    
    return _keyframeRotate;
}

- (CAKeyframeAnimation *)animationShine {
    
    if (!_animationShine) {
        _animationShine = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        _animationShine.duration = 1;
        //_animationShine.fillMode = kCAFillModeForwards;
        _animationShine.repeatCount = 100000;
        _animationShine.autoreverses = YES;
        
        NSValue *value1 = [NSNumber numberWithFloat:0.0];
        NSValue *value2 = [NSNumber numberWithFloat:1.0];
        
        _animationShine.values = @[value1, value2];
        
    }
    
    return _animationShine;
}

- (void)startAnimation {
    //ZNLog();
    [diamondLayer addAnimation:self.keyframeRotate forKey:@"rotate-layer"];
    [dotLayer addAnimation:self.animationShine forKey:@"shine"];
}

- (void)stopAnimation {
    
    [diamondLayer removeAllAnimations];
    [dotLayer removeAllAnimations];
    
}

@end
