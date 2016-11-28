//
//  FrontPageFlowLayout.m
//  testCollection
//
//  Created by fangwenyu on 16/5/31.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "FrontPageFlowLayout.h"

@interface BlackBlock : UICollectionReusableView

@end

@implementation BlackBlock

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}


@end

#define BORDER_WIDTH    2
#define BORDER_WIDTH1   2

@interface FrontPageFlowLayout()

{
    NSMutableArray *_attributesArray;
    
    NSMutableArray *_attributesArrayForSec1;    //section1的attributes
    
    NSInteger _decorationIndex;
    
    CGFloat _maxHeight;
    
   // NSInteger _itemsCount;
    NSMutableArray *_removedIndexPathsFordecoration;
    NSMutableArray *_temp_RemovedIndexPathsFordecoration;
}

@end

@implementation FrontPageFlowLayout

- (void)prepareLayout {
    
    //ZNLog(@"itemsCount :%ld", _itemsCount);
    
    NSInteger firstSectionCount = [self.collectionView numberOfItemsInSection:0];//固定为1，基本不会变
    NSInteger secondSectionCount = [self.collectionView numberOfItemsInSection:1];//一般为4个，偶尔会变
    NSInteger thirdSectionCount = [self.collectionView numberOfItemsInSection:2];//一般为17个，可能会变
    
    //_itemsCount = firstSectionCount + secondSectionCount + thirdSectionCount;
    
    _decorationIndex = 0;
    
    //CGFloat maxY = BORDER_WIDTH1;
    CGFloat maxY = 0;
    CGFloat maxX = 0;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    
    _attributesArray = [NSMutableArray array];
    _attributesArrayForSec1 = [NSMutableArray array];
    
    _temp_RemovedIndexPathsFordecoration = [NSMutableArray array];
    if (_removedIndexPathsFordecoration) {
        [_temp_RemovedIndexPathsFordecoration addObjectsFromArray:_removedIndexPathsFordecoration];
    }
    _removedIndexPathsFordecoration = nil;
    _removedIndexPathsFordecoration = [NSMutableArray array];
    
    [self invalidateLayout];
    
    [super prepareLayout];
    
    [self registerClass:[BlackBlock class] forDecorationViewOfKind:@"decorationView"];
    [self registerClass:[BlackBlock class] forDecorationViewOfKind:@"attr_decoration_bottom"];
    [self registerClass:[BlackBlock class] forDecorationViewOfKind:@"attr_decoration_right"];
    [self registerClass:[BlackBlock class] forDecorationViewOfKind:@"attr_decoration_top"];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    //最上面的黑色色块
    UICollectionViewLayoutAttributes *attr_decoration_top = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"attr_decoration_top" withIndexPath:[NSIndexPath indexPathWithIndex:_decorationIndex]];
    attr_decoration_top.frame = CGRectMake(0, - 500, screenWidth, 500);
    [_attributesArray addObject:attr_decoration_top];
    _decorationIndex ++;
    
    //section 0
    for (NSInteger i = 0; i < firstSectionCount; i ++) {
        
        x = maxX;
        y = maxY;
        width = screenWidth;
        height = 180;
        //maxY += height + BORDER_WIDTH1;
        //maxY += height;
        
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];
        attr.frame = CGRectMake(x, y, width, height);
        [_attributesArray addObject:attr];
        
        if (i == firstSectionCount - 1) {
            x = maxX;
            y = maxY;
            width = screenWidth;
            height = 180;
            //maxY += height + BORDER_WIDTH1;
            maxY += height;
            
            //名角上面的黑色色块
            UICollectionViewLayoutAttributes *attr_decoration = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decorationView" withIndexPath:[NSIndexPath indexPathWithIndex:_decorationIndex]];
            attr_decoration.frame = CGRectMake(0, maxY, screenWidth, 20);
            [_attributesArray addObject:attr_decoration];
            _decorationIndex ++;
            
            maxY += 20;
            
            //header 名角
            UICollectionViewLayoutAttributes *attr_ = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            attr_.frame = CGRectMake(0, maxY, screenWidth, 45);
            [_attributesArray addObject:attr_];
            
            maxY += 45;
            
            //名角下面的黑色色块
//            UICollectionViewLayoutAttributes *attr_decoration1 = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decorationView" withIndexPath:[NSIndexPath indexPathWithIndex:_decorationIndex]];
//            //attr_decoration1.frame = CGRectMake(0, maxY, screenWidth, 3);
//            attr_decoration1.frame = CGRectMake(0, maxY, screenWidth, 0);
//            [_attributesArray addObject:attr_decoration1];
//            _decorationIndex ++;
//            
//            //maxY += 3;
//            maxY += 0;
            
        }
    }
    
    for (NSInteger i = 0; i < secondSectionCount; i ++) {
                
        x = 0;
        width = screenWidth;
        height = 108; //固定高度
        
        y = maxY + 108 * (i) + BORDER_WIDTH1 * (i+1);
        
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:1];
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];
        attr.frame = CGRectMake(x, y, width, height);
        attr.alpha = 1;
        [_attributesArray addObject:attr];
        [_attributesArrayForSec1 addObject:[attr copy]];//如果不用copy的话，后面改动其中的内容会造成_attributesArray内容被修改，导致界面布局错误
        
        if (i == secondSectionCount - 1) {
            
            maxY = y + height + BORDER_WIDTH1;
            
            //小咔上面的黑色色块
            UICollectionViewLayoutAttributes *attr_decoration1 = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decorationView" withIndexPath:[NSIndexPath indexPathWithIndex:_decorationIndex]];
            attr_decoration1.frame = CGRectMake(0, maxY, screenWidth, 20);
            [_attributesArray addObject:attr_decoration1];
            _decorationIndex ++;
            
            maxY += 20;
            
            //header 小咔
            UICollectionViewLayoutAttributes *attr_ = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
            attr_.frame = CGRectMake(0, maxY, screenWidth, 45);
            [_attributesArray addObject:attr_];
            
            maxY += 45;
            
            break;
        }

    }
    
    for (NSInteger i = 0; i < thirdSectionCount; i ++) {
        switch (i % 17) {
                
            case 0:
            {
                //黑色色块
                UICollectionViewLayoutAttributes *attr_decoration1 = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decorationView" withIndexPath:[NSIndexPath indexPathWithIndex:_decorationIndex]];
                //attr_decoration1.frame = CGRectMake(0, maxY, screenWidth, 3);
                attr_decoration1.frame = CGRectMake(0, maxY, screenWidth, 0);
                [_attributesArray addObject:attr_decoration1];
                _decorationIndex ++;
                
                //maxY += BORDER_WIDTH1 + 3;
                maxY += 0;
                
                x = maxX;
                y = maxY;
                width = 750 * 244 / 750 / 2 * screenWidth * 2 / 750;
                height = width * 220 / 244;
                
                maxX = maxX + width + BORDER_WIDTH;
                break;
            }
                
            case 1:
                x = maxX;
                y = maxY;
                width = 750 * 256 / 750 / 2 * screenWidth * 2 / 750;
                height = width * 220 / 256;
                
                maxX = maxX + width + BORDER_WIDTH;
                break;
                
            case 2:
                x = maxX;
                y = maxY;
                width = 750 * 242 / 750 / 2 * screenWidth * 2 / 750;
                height = width * 220 / 242;
                
                maxX = 0;
                maxY += height + BORDER_WIDTH1;
                
                break;
                
            case 3:
                x = maxX;
                y = maxY;
                width = 750 * 372 / 750 / 2 * screenWidth * 2 / 750 + 1;
                height = (width - 1) * 278 / 372;
                maxX += width + BORDER_WIDTH1;
                break;
                
            case 4:
            {
                x = maxX;
                y = maxY;
                width = 750 * 374 / 750 / 2 * screenWidth * 2 / 750;
                height = width * 278 / 374;
                maxX = 0;
                //maxY += height + 3 + BORDER_WIDTH + BORDER_WIDTH;
                maxY += height + BORDER_WIDTH1;
                
                break;
            }
                
            case 5:
            {
                //黑色色块
                UICollectionViewLayoutAttributes *attr_decoration1 = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decorationView" withIndexPath:[NSIndexPath indexPathWithIndex:_decorationIndex]];
                attr_decoration1.frame = CGRectMake(0, maxY, screenWidth, 3);
                [_attributesArray addObject:attr_decoration1];
                _decorationIndex ++;
                
                maxY += BORDER_WIDTH1 + 3;
                x = maxX;
                y = maxY;
                width = 750 * 371 / 750 / 2 * screenWidth * 2 / 750 + 1;
                height = (width - 1) * 314 / 371;
                maxX += width + BORDER_WIDTH1;
                break;
            }
                
            case 6:
                x = maxX;
                y = maxY;
                width = 750 * 375 / 750 / 2 * screenWidth * 2 / 750;
                height = width * 314 / 375;
                maxX = 0;
                maxY += height + BORDER_WIDTH1;
                break;
                
            case 7:
                x = maxX;
                y = maxY;
                width = 750 * 371 / 750 / 2 * screenWidth * 2 / 750 + 1;
                height = (width - 1) * 314 / 371;
                maxX += width + BORDER_WIDTH1;
                break;
                
            case 8:
            {
                x = maxX;
                y = maxY;
                width = 750 * 375 / 750 / 2 * screenWidth * 2 / 750;
                height = width * 314 / 375;
                maxX = 0;
                //maxY += height + 3 + BORDER_WIDTH + BORDER_WIDTH;
                maxY += height + BORDER_WIDTH1;
                
                break;
            }
                
            case 9:
            {
                //黑色色块
                UICollectionViewLayoutAttributes *attr_decoration1 = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decorationView" withIndexPath:[NSIndexPath indexPathWithIndex:_decorationIndex]];
                attr_decoration1.frame = CGRectMake(0, maxY, screenWidth, 3);
                [_attributesArray addObject:attr_decoration1];
                _decorationIndex ++;
                
                maxY += BORDER_WIDTH1 + 3;
                
                x = maxX;
                y = maxY;
                width = 750 * 327 / 750 / 2 * screenWidth * 2 / 750 + 1;
                height = (width - 1) * 318 / 327;
                maxX += width + BORDER_WIDTH1;
                break;
            }
                
            case 10:
                x = maxX;
                y = maxY;
                width = 750 * 419 / 750 / 2 * screenWidth * 2 / 750;
                height = width * 318 / 419;
                maxX = 0;
                maxY += height + BORDER_WIDTH1;
                break;
                
            case 11:
                x = maxX;
                y = maxY;
                width = 750 * 375 / 750 / 2 * screenWidth * 2 / 750 + 1;
                height = (width - 1) * 250 / 375;
                maxX += width + BORDER_WIDTH1;
                break;
                
            case 12:
            {
                x = maxX;
                y = maxY;
                width = 750 * 371 / 750 / 2 * screenWidth * 2 / 750;
                height = width * 250 / 371;
                maxX = 0;
                maxY += height + BORDER_WIDTH1;
                
                break;
            }
                
            case 13:
            {
                //黑色色块
                UICollectionViewLayoutAttributes *attr_decoration1 = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decorationView" withIndexPath:[NSIndexPath indexPathWithIndex:_decorationIndex]];
                attr_decoration1.frame = CGRectMake(0, maxY, screenWidth, 3);
                [_attributesArray addObject:attr_decoration1];
                _decorationIndex ++;
                
                maxY += BORDER_WIDTH1 + 3;
                
                x = maxX;
                y = maxY;
                width = 750 * 327 / 750 / 2 * screenWidth * 2 / 750 + 1;
                height = (width - 1) * 458 / 327;
                maxX += width + BORDER_WIDTH1;
                break;
            }
                
            case 14:
                x = maxX;
                y = maxY;
                width = 750 * 419 / 750 / 2 * screenWidth * 2 / 750;
                height = width * 458 / 419;
                maxX = 0;
                maxY += height + BORDER_WIDTH1;
                break;
                
            case 15:
                x = maxX;
                y = maxY;
                width = 750 * 378 / 750 / 2 * screenWidth * 2 / 750 + 1;
                height = (width - 1) * 320 / 378;
                maxX += width + BORDER_WIDTH1;
                break;
                
            case 16:
            {
                x = maxX;
                y = maxY;
                width = 750 * 368 / 750 / 2 * screenWidth * 2 / 750;
                height = width * 320 / 368;
                
                maxX = 0;
                maxY += height + BORDER_WIDTH1;
                
                //黑色色块
                UICollectionViewLayoutAttributes *attr_decoration1 = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decorationView" withIndexPath:[NSIndexPath indexPathWithIndex:_decorationIndex]];
                attr_decoration1.frame = CGRectMake(0, maxY, screenWidth, 3);
                [_attributesArray addObject:attr_decoration1];
                _decorationIndex ++;
                
                maxY += BORDER_WIDTH1 + 3;
                
                break;
            }
                
            default:
                break;
        }
        
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:2];
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];
        attr.frame = CGRectMake(x, y, width, height);
        [_attributesArray addObject:attr];
    }
    
    //最下面的黑色色块
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:_decorationIndex];
    UICollectionViewLayoutAttributes *attr_decoration_bottom = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"attr_decoration_bottom" withIndexPath:indexPath];
    [_removedIndexPathsFordecoration addObject:indexPath];
    _decorationIndex ++;
    
    if (maxX == 0) {
        //一行满
        attr_decoration_bottom.frame = CGRectMake(0, maxY, screenWidth, 1000);
        
    }
    else {
        
        //一行未满
        attr_decoration_bottom.frame = CGRectMake(0, maxY + BORDER_WIDTH1 + height, screenWidth, 1000);
        
        //缺的部分用黑色色块填充
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:_decorationIndex];
        UICollectionViewLayoutAttributes *attr_decoration_right = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"attr_decoration_right" withIndexPath:indexPath];
        [_removedIndexPathsFordecoration addObject:indexPath];
        _decorationIndex ++;
        
        //attr_decoration_right.frame = CGRectMake(maxX, maxY, screenWidth - maxX, height + BORDER_WIDTH1);
        attr_decoration_right.frame = CGRectMake(maxX, maxY, screenWidth - maxX, height + 0);
        [_attributesArray addObject:attr_decoration_right];
        
    }
    
    [_attributesArray addObject:attr_decoration_bottom];
    
    _maxHeight = attr_decoration_bottom.frame.origin.y;
    
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //ZNLog(@"rectHeight:%f, count:%lu", rect.size.height, (unsigned long)_attributesArray.count);
    //ZNLog(@"%@", _attributesArray);
    return _attributesArray;
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//}


- (CGSize)collectionViewContentSize {
    //ZNLog(@"maxHeight:%f", _maxHeight);
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, _maxHeight);
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    
    if (itemIndexPath.section == 1) {
        
        UICollectionViewLayoutAttributes *attr = [_attributesArrayForSec1 objectAtIndex:itemIndexPath.row];
        
        CGRect frame = attr.frame;
        
        //飞进来的方向错开
        CGFloat x = itemIndexPath.row % 2 ? SCREEN_WIDTH : -frame.size.width;
        
        frame.origin.x = x;
        
        attr.frame = frame;
        
        attr.alpha = 0.0;
        
        return attr;
    }
    
    return nil;
    
}


- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    
    if (itemIndexPath.section == 1) {
        
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:itemIndexPath];
        CGRect frame = cell.frame;
        
        //飞出去的方向错开
        CGFloat x = itemIndexPath.row % 2 ? - SCREEN_WIDTH : frame.size.width;
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
        
        attr.frame = CGRectMake(x, frame.origin.y, frame.size.width, frame.size.height);
        
        attr.alpha = 0.0;
        
        return attr;
        
    }
    
    return nil;
    
}

- (nullable UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingDecorationElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)decorationIndexPath {
    
    return nil;//不返回空的话 页面刷新时 会有很奇怪的动画
}

- (nullable UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingDecorationElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)decorationIndexPath {
    
    return nil;//不返回空的话 页面刷新时 会有很奇怪的动画
}

- (NSArray<NSIndexPath *> *)indexPathsToDeleteForDecorationViewOfKind:(NSString *)elementKind {
    //ZNLog(@"_temp_RemovedIndexPathsFordecoration :%@", _temp_RemovedIndexPathsFordecoration);
    return _temp_RemovedIndexPathsFordecoration;
}


@end
