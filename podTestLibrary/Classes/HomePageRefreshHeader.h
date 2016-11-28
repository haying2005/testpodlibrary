//
//  HomePageRefreshHeader.h
//  iShow
//
//  Created by fangwenyu on 16/6/2.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "MJRefreshHeader.h"

@interface HomePageRefreshHeader : MJRefreshHeader

@property (nonatomic, assign)BOOL isForBlackBackground; //是否是应用在深色背景下（例如首页）

@property (nonatomic, assign)NSInteger lastUpdatedTimeTag;
@end
