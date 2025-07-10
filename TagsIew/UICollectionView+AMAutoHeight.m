//
//  UICollectionView+AMAutoHeight.m
//  genKiMaatProject
//
//  Created by yy on 2025/7/2.
//

#import "UICollectionView+AMAutoHeight.h"

@implementation UICollectionView (AMAutoHeight)

- (CGFloat)contentHeight {
    [self layoutIfNeeded];
    return self.collectionViewLayout.collectionViewContentSize.height;
}


@end
