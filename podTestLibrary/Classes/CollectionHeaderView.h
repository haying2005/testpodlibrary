//
//  CollectionHeaderView.h
//  testCollection
//
//  Created by fangwenyu on 16/6/1.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionHeaderView;
@protocol CollectionHeaderViewDelegate <NSObject>

- (void)onCollectionHeaderViewClickRefresh:(CollectionHeaderView *)headerView;

@end
@interface CollectionHeaderView : UICollectionReusableView

@property (nonatomic, copy)NSString *title;

@property (nonatomic, strong)UIButton *btnRefresh;

@property (nonatomic, weak) id<CollectionHeaderViewDelegate> delegate;

@end
