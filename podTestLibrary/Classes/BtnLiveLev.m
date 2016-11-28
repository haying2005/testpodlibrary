//
//  BtnLiveLev.m
//  iShow
//
//  Created by fangwenyu on 16/7/26.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "BtnLiveLev.h"
#import "UIColor+WYColor.h"

@implementation BtnLiveLev

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont customRegularFontOfSize:8];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setLiveLevel:(NSInteger)liveLevel {
    _liveLevel = liveLevel;
    [self setTitle:[NSString stringWithFormat:@"%ld", (long)liveLevel] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self setBackgroundImage:[UIImage imageNamed:[self getImageNameWithLiveLevel:liveLevel]] forState:UIControlStateNormal];
     
    if (liveLevel >= 20) {
        [self setTitleColor:[UIColor colorWithHex:0x2a292b alpha:1] forState:UIControlStateNormal];
    }
}

- (NSString *)getImageNameWithLiveLevel:(NSInteger)liveLevel
{
    NSString *imageName = nil;
    
    if (liveLevel < 6) {
        imageName = @"live_lev_5";
    }
    else if (liveLevel >= 6 && liveLevel < 10) {
        imageName = @"live_lev_9";
    }
    else if (liveLevel >= 10 && liveLevel < 16) {
        imageName = @"live_lev_15";
    }
    else if (liveLevel >= 16 && liveLevel < 20) {
        imageName = @"live_lev_18";
    }
    else {
        imageName = @"live_lev_18";
    }
    
    if (self.width < 20) {
        imageName = [imageName stringByAppendingString:@"_small"];
        self.titleLabel.font = [UIFont customRegularFontOfSize:8];
    }
    else if (self.width < 25) {
        imageName = [imageName stringByAppendingString:@"_middle"];
        self.titleLabel.font = [UIFont customRegularFontOfSize:12];
    }
    else {
        imageName = [imageName stringByAppendingString:@"_big"];
        self.titleLabel.font = [UIFont customRegularFontOfSize:14];
    }
    
    return imageName;
}

@end
