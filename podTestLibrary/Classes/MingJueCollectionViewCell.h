//
//  MingJueCollectionViewCell.h
//  testCollection
//
//  Created by fangwenyu on 16/6/1.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BroadcasterModel.h"

@interface MingJueCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) BOOL isHeaderLeft;

@property (nonatomic, copy)NSString *nick;
@property (nonatomic, copy)NSString *headUrl;
@property (nonatomic, copy)NSString *coverUrl;
@property (nonatomic, assign)NSInteger watcherNum;
@property (nonatomic, assign)NSInteger liverLevel;

- (void)setInfo:(BroadcasterModel *)model;
@end
