//
//  MingJueCollectionViewCell.m
//  testCollection
//
//  Created by fangwenyu on 16/6/1.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "MingJueCollectionViewCell.h"
#import "UIColor+WYColor.h"
#import "UIView+WYView.h"
#import "UIView+Diamond.h"
#import "BtnLiveLev.h"

@interface MingJueCollectionViewCell ()



@property (nonatomic, strong) UIImageView *coverImgV;

@property (nonatomic, strong) UIImageView *mask;    //遮罩

@property (nonatomic, strong) UIImageView *headImgV;

@property (nonatomic, strong) UILabel *lblNick;

//@property (nonatomic, strong) UILabel *lblLevl;

@property (nonatomic, strong) UIButton *btnWatcherNum;  //观众数量

@property (nonatomic, strong) UIButton *btnGame;

//@property (nonatomic, strong) UIButton *play;

@property (nonatomic, strong) BtnLiveLev *btnLevel; //等级icon

@end

@implementation MingJueCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor grayColor];
        self.clipsToBounds = YES;
        
        CGFloat imgViewWidth = 588 * 0.5 / 375 * [UIScreen mainScreen].bounds.size.width;
        self.coverImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, - imgViewWidth * 0.2, imgViewWidth, imgViewWidth)];
        //self.coverImgV.frame = CGRectMake(0, 0, imgViewWidth, self.height);
        self.coverImgV.backgroundColor = [UIColor blackColor];
        self.coverImgV.image = [UIImage imageNamed:@"3.jpg"];
        self.coverImgV.contentMode = UIViewContentModeScaleAspectFill;
        self.coverImgV.clipsToBounds = YES;
        [self addSubview:self.coverImgV];
        
//        self.play = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *image = [UIImage imageNamed:@"play_unsel"];
//        [self.play setImage:image forState:UIControlStateNormal];
//        [self.play setImage:[UIImage imageNamed:@"play_sel"] forState:UIControlStateHighlighted];
//        [self.play setFrame:CGRectMake(0, 0, image.size.width , image.size.height)];
//        
//        [self.coverImgV addSubview:self.play];
        
        self.mask = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.mask];
        
        self.headImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        self.headImgV.image = [UIImage imageNamed:@"2.jpg"];
        self.headImgV.contentMode = UIViewContentModeScaleAspectFill;
        [self.headImgV addDiamondShapeClipWithCornerRadius:3 borderColor:[UIColor colorWithHex:0Xffcccacc alpha:1] borderWidth:.5];
        [self addSubview:self.headImgV];
        
        UIImage *image_lev = [UIImage imageNamed:@"live_lev_5_small"];
        self.btnLevel = [[BtnLiveLev alloc]initWithFrame:CGRectMake(0, 0, image_lev.size.width, image_lev.size.height)];
        [self addSubview:self.btnLevel];
        
        self.lblNick = [[UILabel alloc]initWithFrame:CGRectZero];
        self.lblNick.font = [UIFont customBoldFontOfSize:14];
        self.lblNick.textColor = [UIColor whiteColor];
        [self.lblNick setShadowColor:[UIColor colorWithHex:0xff312f32 alpha:1]];
        [self.lblNick setShadowOffset:CGSizeMake(1, 1)];
        [self addSubview:self.lblNick];
        self.lblNick.text = @" ";
        
//        self.lblLevl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 25, 12)];
//        self.lblLevl.backgroundColor = [UIColor colorWithHex:0xff312f32 alpha:1];
//        self.lblLevl.layer.cornerRadius = 2;
//        self.lblLevl.layer.masksToBounds = YES;
//        self.lblLevl.textAlignment = NSTextAlignmentCenter;
//        self.lblLevl.font = [UIFont customRegularFontOfSize:8];
//        [self.lblLevl setTextColor:[UIColor whiteColor]];
//        [self addSubview:self.lblLevl];
//        self.lblLevl.text = @"";
        
        //观众人数
        self.btnWatcherNum = [[UIButton alloc]initWithFrame:CGRectZero];
        [self.btnWatcherNum setImage:[UIImage imageNamed:@"homepage_watcher_num"] forState:UIControlStateNormal];
        [self.btnWatcherNum setTitle:@" " forState:UIControlStateNormal];
        self.btnWatcherNum.titleLabel.font = [UIFont customLightFontOfSize:8];
        [self.btnWatcherNum setTitleShadowColor:[UIColor colorWithHex:0xff312f32 alpha:1] forState:UIControlStateNormal];
        [[self.btnWatcherNum titleLabel] setShadowOffset:CGSizeMake(1, 1)];
        [self.btnWatcherNum setTitleColor:[UIColor colorWithHex:0xffffffff alpha:1] forState:UIControlStateNormal];
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
    
    //self.coverImgV.frame = CGRectMake(0, 0, 588 * 0.5 / 375 * [UIScreen mainScreen].bounds.size.width, self.height);
    
//    self.play.center = CGPointMake(self.coverImgV.width / 2, self.coverImgV.height /2);
    
    self.headImgV.top = 20;
    
    if (self.isHeaderLeft) {
        self.coverImgV.right = self.width;
        
        self.mask.frame = CGRectMake(0, 0, 362 * 0.5 / 375 * [UIScreen mainScreen].bounds.size.width, self.height);
        self.mask.image = [UIImage imageNamed:@"mask_left"];
        
        self.headImgV.left = 81;
    }
    else {
        self.coverImgV.left = 0;
        
        self.mask.frame = CGRectMake(0, 0, 362 * 0.5 / 375 * [UIScreen mainScreen].bounds.size.width, self.height);
        self.mask.image = [UIImage imageNamed:@"mask_right"];
        self.mask.right = self.width;
        
        self.headImgV.right = self.width - 81;
    }
    
    [self.btnLevel setCenter:CGPointMake(self.headImgV.left + self.headImgV.width * 3/4, self.headImgV.top + self.headImgV.height * 3/4)];
    
    [self.lblNick sizeToFit];
    self.lblNick.left = self.headImgV.left - ((self.lblNick.width) -  self.headImgV.width) / 2;
    self.lblNick.top = self.headImgV.bottom + 4;

//    self.lblLevl.left = self.lblNick.right + 5;
//    self.lblLevl.top = self.lblNick.top + (self.lblNick.height - self.lblLevl.height) / 2;
    
    [self.btnWatcherNum setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
    [self.btnWatcherNum sizeToFit];
    self.btnWatcherNum.width += 2;
    self.btnWatcherNum.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self.btnGame setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
    [self.btnGame sizeToFit];
    self.btnGame.width += 2;
    self.btnGame.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    self.btnWatcherNum.left = self.lblNick.left - ((self.btnWatcherNum.width + self.btnGame.width + 10) -  self.lblNick.width) / 2;
    self.btnWatcherNum.top = self.lblNick.bottom + 5;
    self.btnGame.left = self.btnWatcherNum.right + 10;
    self.btnGame.top = self.btnWatcherNum.top;
    
}

- (void)setInfo:(BroadcasterModel *)model {
    
    self.nick = model.nickName;
    self.lblNick.text = self.nick;
    
    self.headUrl = model.smallHeadUrl;
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:self.headUrl]];
    
    self.coverUrl = model.coverImageIath;
    [self.coverImgV sd_setImageWithURL:[NSURL URLWithString:self.coverUrl]];
    
    self.watcherNum = model.viewercount;
    [self.btnWatcherNum setTitle:[NSString stringWithFormat:@"%ld", (long)self.watcherNum] forState:UIControlStateNormal];
    
    self.liverLevel = model.level;
    //self.lblLevl.text = [NSString stringWithFormat:@"Lv%ld", (long)self.liverLevel];
    [self.btnLevel setLiveLevel:self.liverLevel];
    
    [self setNeedsLayout];
    
}

//- (void)setHighlighted:(BOOL)highlighted {
//    //[self.play setHighlighted:highlighted];
//}

@end
