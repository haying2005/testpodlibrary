//
//  ToupaiView.m
//  testCollection
//
//  Created by fangwenyu on 16/6/1.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "ToupaiView.h"
#import "UIView+WYView.h"
#import "UIColor+WYColor.h"
#import "UIView+Diamond.h"
#import "UIButton+Layout.h"
#import "BtnLiveLev.h"

@interface ToupaiView()

@property (nonatomic, strong) UIImageView *coverImgView;

@property (nonatomic, strong) UIImageView *headImgView;

@property (nonatomic, strong) UILabel *lblLevl;

@property (nonatomic, strong) UILabel *lblNick;

@property (nonatomic, strong) UIButton *btnWatcherNum;

@property (nonatomic, strong) UIButton *btnGame;

//@property (nonatomic, strong) UIButton *play;

@property (nonatomic, strong) BtnLiveLev *btnLevel;

@end
@implementation ToupaiView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        
        //self.coverImgView = [[UIImageView alloc]initWithFrame:self.bounds];
        CGFloat coverImgViewWidth = self.width;
        self.coverImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, - coverImgViewWidth * 0.15, coverImgViewWidth, coverImgViewWidth)];
        self.coverImgView.contentMode = UIViewContentModeScaleAspectFill;
        self.coverImgView.clipsToBounds = YES;
        [self addSubview:self.coverImgView];
        
//        self.play = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *image = [UIImage imageNamed:@"play_unsel"];
//        [self.play setImage:image forState:UIControlStateNormal];
//        [self.play setImage:[UIImage imageNamed:@"play_sel"] forState:UIControlStateHighlighted];
//        [self.play setFrame:CGRectMake(0, 0, image.size.width , image.size.height)];
//        self.play.center = CGPointMake(self.coverImgView.width / 2, self.coverImgView.height /2);
//        [self.coverImgView addSubview:self.play];
        
        self.headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 35, 35)];
        self.headImgView.contentMode = UIViewContentModeScaleAspectFill;
        self.headImgView.clipsToBounds = YES;
        [self.headImgView addDiamondShapeClipWithCornerRadius:3 borderColor:[UIColor colorWithHex:0Xffcccacc alpha:1] borderWidth:.5];
        [self addSubview:self.headImgView];
        
        UIImage *image_lev = [UIImage imageNamed:@"live_lev_5_small"];
        self.btnLevel = [[BtnLiveLev alloc]initWithFrame:CGRectMake(0, 0, image_lev.size.width, image_lev.size.height)];
        [self.btnLevel setCenter:CGPointMake(self.headImgView.left + self.headImgView.width * 3/4, self.headImgView.top + self.headImgView.height * 3/4)];
        [self addSubview:self.btnLevel];
        
        self.lblNick = [[UILabel alloc]initWithFrame:CGRectMake(self.headImgView.right + 6, 12, 0, 0)];
        self.lblNick.font = [UIFont customLightFontOfSize:14];
        self.lblNick.textColor = [UIColor whiteColor];
        [self.lblNick setShadowColor:[UIColor colorWithHex:0xff312f32 alpha:1]];
        [self.lblNick setShadowOffset:CGSizeMake(1, 1)];
        self.lblNick.text = @" ";
        [self addSubview:self.lblNick];
        
        self.lblLevl = [[UILabel alloc]initWithFrame:CGRectMake(self.headImgView.right + 6, 0, 25, 12)];
        self.lblLevl.backgroundColor = [UIColor colorWithHex:0xff312f32 alpha:1];
        self.lblLevl.layer.cornerRadius = 2;
        self.lblLevl.layer.masksToBounds = YES;
        self.lblLevl.font = [UIFont customRegularFontOfSize:8];
        self.lblLevl.textColor = [UIColor whiteColor];
        self.lblLevl.textAlignment = NSTextAlignmentCenter;
        self.lblLevl.text = @"Lv0";
        [self addSubview:self.lblLevl];
        
        //观众人数
        self.btnWatcherNum = [[UIButton alloc]initWithFrame:CGRectZero];
        
        [self.btnWatcherNum setImage:[UIImage imageNamed:@"homepage_watcher_num"] forState:UIControlStateNormal];
        [self.btnWatcherNum setTitle:@" " forState:UIControlStateNormal];
        self.btnWatcherNum.titleLabel.font = [UIFont customLightFontOfSize:8];
        self.btnWatcherNum.titleLabel.shadowColor = [UIColor colorWithHex:0xff312f32 alpha:1];
        self.btnWatcherNum.titleLabel.shadowOffset = CGSizeMake(1, 1);
        [self.btnWatcherNum setTitleColor:[UIColor colorWithHex:0xffffffff alpha:1] forState:UIControlStateNormal];
        [self.btnWatcherNum setTitleShadowColor:[UIColor colorWithHex:0xff312f32 alpha:1] forState:UIControlStateNormal];
        [[self.btnWatcherNum titleLabel] setShadowOffset:CGSizeMake(1, 1)];
        [self addSubview:self.btnWatcherNum];
        
        self.btnGame = [[UIButton alloc]initWithFrame:CGRectZero];
        [self.btnGame setImage:[UIImage imageNamed:@"pocker_icon"] forState:UIControlStateNormal];
        [self.btnGame setTitle:@"德州扑克" forState:UIControlStateNormal];
        self.btnGame.titleLabel.font = [UIFont customLightFontOfSize:8];
        self.btnGame.titleLabel.shadowColor = [UIColor colorWithHex:0xff312f32 alpha:1];
        self.btnGame.titleLabel.shadowOffset = CGSizeMake(1, 1);
        [self.btnGame setTitleColor:[UIColor colorWithHex:0xffffffff alpha:1] forState:UIControlStateNormal];
        [self.btnGame setTitleShadowColor:[UIColor colorWithHex:0xff312f32 alpha:1] forState:UIControlStateNormal];
        [[self.btnGame titleLabel] setShadowOffset:CGSizeMake(1, 1)];
        [self addSubview:self.btnGame];
        
    
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.lblNick sizeToFit];
    self.lblLevl.top = self.lblNick.bottom + 2.5;
    
    self.btnWatcherNum.left = 10;
    self.btnWatcherNum.bottom = self.height - 20;
    
    [self.btnWatcherNum setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
    [self.btnWatcherNum sizeToFit];
    self.btnWatcherNum.width += 2;
    self.btnWatcherNum.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self.btnGame setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
    [self.btnGame sizeToFit];
    self.btnGame.width += 2;
    self.btnGame.left = self.btnWatcherNum.right + 10;
    self.btnGame.top = self.btnWatcherNum.top;
}

- (void)setInfo:(BroadcasterModel *)model {
    
    self.nick = model.nickName;
    self.lblNick.text = self.nick;
    
    self.headUrl = model.smallHeadUrl;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:self.headUrl]];
    
    self.coverUrl = model.coverImageIath;
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:self.coverUrl]];
    
    self.watcherNum = model.viewercount;
    [self.btnWatcherNum setTitle:[NSString stringWithFormat:@"%ld", (long)self.watcherNum] forState:UIControlStateNormal];
    
    
    self.liverLevel = model.level;
    self.lblLevl.text = [NSString stringWithFormat:@"Lv%ld", (long)self.liverLevel];
    [self.btnLevel setLiveLevel:self.liverLevel];
    
    [self setNeedsLayout];
}


@end
