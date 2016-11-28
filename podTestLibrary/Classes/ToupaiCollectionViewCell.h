//
//  ToupaiCollectionViewCell.h
//  testCollection
//
//  Created by fangwenyu on 16/6/1.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToupaiView.h"

@interface ToupaiCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)NSMutableArray *dataArr;

- (void)initContents:(NSMutableArray *)arr;

- (void)setTimerStart:(BOOL)flag;
@end
