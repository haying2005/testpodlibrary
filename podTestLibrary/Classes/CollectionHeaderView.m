//
//  CollectionHeaderView.m
//  testCollection
//
//  Created by fangwenyu on 16/6/1.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "CollectionHeaderView.h"
#import "UIColor+WYColor.h"
#import "UIView+WYView.h"
#import "UIView+Diamond.h"

@interface CollectionHeaderView ()

@property (nonatomic, strong)UIView *dot;

@property (nonatomic, strong)UILabel *lblTitle;

@end

@implementation CollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHex:0xff1e1d1f alpha:1];
        
        self.dot = [[UIView alloc]initWithFrame:CGRectMake(15, (self.height - 5) / 2, 5, 5)];
        self.dot.backgroundColor = [UIColor colorWithHex:0xfffec500 alpha:1];
        [self.dot addDiamondShapeClipWithCornerRadius:1 borderColor:nil borderWidth:0];
        [self addSubview:self.dot];
        
        self.lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 200,  self.height)];
        self.lblTitle.font = [UIFont customRegularFontOfSize:14];
        self.lblTitle.textColor = [UIColor whiteColor];
        self.lblTitle.text = @"名角";
        [self addSubview:self.lblTitle];
        
        self.btnRefresh = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.btnRefresh setImage:[UIImage imageNamed:@"refresh_unsel"] forState:UIControlStateNormal];
        [self.btnRefresh setImage:[UIImage imageNamed:@"refresh_sel"] forState:UIControlStateHighlighted];
        
        [self.btnRefresh setFrame:CGRectMake(0, 0, [UIImage imageNamed:@"refresh_sel"].size.width + 30, self.height)];
        
        [self.btnRefresh addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventTouchUpInside];
        self.btnRefresh.right = self.width;
        [self addSubview:self.btnRefresh];
        self.btnRefresh.hidden = YES;
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.lblTitle.text = title;
    if ([title isEqualToString:@"名角"]) {
        self.btnRefresh.hidden = NO;
    }
    else {
        self.btnRefresh.hidden = YES;
    }
}

- (void)refreshClick:(UIButton *)btn {
    [btn setEnabled:NO];
    if ([self.delegate respondsToSelector:@selector(onCollectionHeaderViewClickRefresh:)]) {
        [self.delegate onCollectionHeaderViewClickRefresh:self];
    }
}



@end
