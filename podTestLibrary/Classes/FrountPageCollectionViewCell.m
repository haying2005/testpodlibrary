//
//  FrountPageCollectionViewCell.m
//  testCollection
//
//  Created by fangwenyu on 16/5/31.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "FrountPageCollectionViewCell.h"
#import "UIColor+WYColor.h"
#import "UIView+Diamond.h"
#import "UIImage+WYImage.h"
//#import "SDWebImageDownloader.h"
#import "BtnLiveLev.h"

@interface FrountPageCollectionViewCell()

@property (nonatomic, strong) UIImageView *innerView;
@property (nonatomic, strong) UIImageView *headImgView;

@property (nonatomic, strong) UIButton *btnWatcherNum;

@property (nonatomic, strong) UIButton *btnGame;

//@property (nonatomic, strong) UIButton *play;

@property (nonatomic, strong) BtnLiveLev *btnLevel;

@end

@implementation FrountPageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        
        self.innerView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.innerView.backgroundColor = [UIColor blackColor];
        self.innerView.contentMode = UIViewContentModeScaleAspectFill;
        //self.headImgView.contentMode = UIViewContentModeLeft;
        self.innerView.clipsToBounds = YES;
        [self.contentView addSubview:self.innerView];
        
//        self.play = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *image = [UIImage imageNamed:@"play_unsel"];
//        [self.play setImage:image forState:UIControlStateNormal];
//        [self.play setImage:[UIImage imageNamed:@"play_sel"] forState:UIControlStateHighlighted];
//        [self.play setFrame:CGRectMake(0, 0, image.size.width , image.size.height)];
//        
//        [self.innerView addSubview:self.play];
        
        //头像
        self.headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 35, 35)];
        [self.headImgView addDiamondShapeClipWithCornerRadius:3 borderColor:[UIColor colorWithHex:0Xffcccacc alpha:1] borderWidth:.5];
        [self.innerView addSubview:self.headImgView];
        self.headImgView.contentMode = UIViewContentModeScaleAspectFill;
        
        UIImage *image_lev = [UIImage imageNamed:@"live_lev_5_small"];
        self.btnLevel = [[BtnLiveLev alloc]initWithFrame:CGRectMake(0, 0, image_lev.size.width, image_lev.size.height)];
        [self.btnLevel setCenter:CGPointMake(self.headImgView.left + self.headImgView.width * 3/4, self.headImgView.top + self.headImgView.height * 3/4)];
        [self addSubview:self.btnLevel];
        
        
        //观众人数
        self.btnWatcherNum = [[UIButton alloc]initWithFrame:CGRectZero];
        [self.btnWatcherNum setImage:[UIImage imageNamed:@"homepage_watcher_num"] forState:UIControlStateNormal];
        [self.btnWatcherNum setTitle:@"0" forState:UIControlStateNormal];
        self.btnWatcherNum.titleLabel.font = [UIFont customLightFontOfSize:8];
        [self.btnWatcherNum setTitleColor:[UIColor colorWithHex:0xffffffff alpha:1] forState:UIControlStateNormal];
        [self.btnWatcherNum setTitleShadowColor:[UIColor colorWithHex:0xff312f32 alpha:1] forState:UIControlStateNormal];
        [[self.btnWatcherNum titleLabel] setShadowOffset:CGSizeMake(1, 1)];
        [self.innerView addSubview:self.btnWatcherNum];
        
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
    
    self.innerView.frame = self.bounds;
    
    //self.play.center = CGPointMake(self.innerView.width / 2, self.innerView.height /2);
    
    [self.btnWatcherNum sizeToFit];
    [self.btnWatcherNum setFrame:CGRectMake(5, self.innerView.bounds.size.height - 5 - self.btnWatcherNum.bounds.size.height, self.btnWatcherNum.bounds.size.width, self.btnWatcherNum.bounds.size.height)];
    
    [self.btnWatcherNum setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
    [self.btnWatcherNum sizeToFit];
    self.btnWatcherNum.width += 2;
    
    [self.btnGame setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
    [self.btnGame sizeToFit];
    self.btnGame.width += 2;
    self.btnGame.left = self.btnWatcherNum.right + 10;
    self.btnGame.top = self.btnWatcherNum.top;
    
}

- (void)setInfo:(BroadcasterModel *)model {
    self.coverUrl = model.coverImageIath;
    [self.innerView sd_setImageWithURL:[NSURL URLWithString:self.coverUrl]];

    
    self.nick = model.nickName;
    //self.lblNick.text = self.nick;
    
    self.headUrl = model.smallHeadUrl;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[self.headUrl toSmallHeadUrlString]]];
    
    
//    __block UIImage *imgCover = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:self.coverUrl];
//    if (imgCover) {
//        [self.innerView setImage:imgCover];
//    }
//    else {
//        //[self.innerView setImage:[UIImage imageNamed:@"avatar"]];
//        [self.innerView setImage:nil];
//        [self performSelector:@selector(loadCover:) withObject:[NSURL URLWithString:self.coverUrl] afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
//    }
    
//    __block UIImage *imgHead = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:self.headUrl];
//    if (imgHead) {
//        [self.headImgView setImage:imgHead];
//    }
//    else {
//        [self.headImgView setImage:[UIImage imageNamed:@"avatar"]];
//        //[self performSelector:@selector(loadHead:) withObject:[NSURL URLWithString:self.headUrl] afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
//    }
    
    
    self.watcherNum = model.viewercount;
    [self.btnWatcherNum setTitle:[NSString stringWithFormat:@"%ld", (long)self.watcherNum] forState:UIControlStateNormal];
    
    self.liverLevel = model.level;
    //self.lblLevl.text = [NSString stringWithFormat:@"Lv%d", self.liverLevel];
    [self.btnLevel setLiveLevel:model.level];
    [self setNeedsLayout];
    
}


//新增
- (void)loadCover:(NSString *)str {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //从disk中获取
        UIImage *imgCover = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:self.coverUrl];
        if (imgCover) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //主线程更新UI
                self.innerView.alpha = 0;
                [self.innerView setImage:imgCover];
                [UIView animateWithDuration:.5 animations:^{
                    self.innerView.alpha = 1;
                }];
            });
        }
        else {
            //硬盘缓存中没有
            WEAKSELF
            [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:self.coverUrl] options:0 progress:NULL completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.innerView.alpha = 0;
                    [weakSelf.innerView setImage:image];
                    [UIView animateWithDuration:.5 animations:^{
                        self.innerView.alpha = 1;
                    }];
                });
                
            }];
        }
    });
}

- (void)loadHead:(NSString *)str {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //从disk中获取
        UIImage *imgCover = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:self.headUrl];
        if (imgCover) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //主线程更新UI
                [self.headImgView setImage:imgCover];
            });
        }
        else {
            //硬盘缓存中没有
            dispatch_async(dispatch_get_main_queue(), ^{
                //主线程更新UI
                //[self.innerView sd_setImageWithURL:[NSURL URLWithString:self.headUrl] placeholderImage:nil];
                
                WEAKSELF
                [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:self.headUrl] options:0 progress:NULL completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    [weakSelf.headImgView setImage:image];
                }];
                
            });
        }
    });
}

@end
