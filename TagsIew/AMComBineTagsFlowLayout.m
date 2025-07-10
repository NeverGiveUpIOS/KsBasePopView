//
//  AMComBineTagsFlowLayout.m
//  genKiMaatProject
//
//  Created by yy on 2025/7/2.
//

#import "AMComBineTagsFlowLayout.h"

@implementation AMComBineTagsFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat leftMargin = self.sectionInset.left;
    CGFloat maxWidth = self.collectionViewContentSize.width - self.sectionInset.right;
    
    NSMutableArray *updatedAttributes = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        if (attribute.representedElementCategory == UICollectionElementCategoryCell) {
            UICollectionViewLayoutAttributes *newAttribute = [attribute copy];
            
            if (newAttribute.frame.origin.x <= leftMargin) {
                leftMargin = self.sectionInset.left;
            } else {
                leftMargin += self.minimumInteritemSpacing;
            }
            
            CGRect frame = newAttribute.frame;
            frame.origin.x = leftMargin;
            newAttribute.frame = frame;
            
            leftMargin += frame.size.width;
            
            // 确保不超过最大宽度
            if (leftMargin > maxWidth) {
                leftMargin = self.sectionInset.left;
                frame.origin.x = leftMargin;
                frame.origin.y += frame.size.height + self.minimumLineSpacing;
                newAttribute.frame = frame;
                
                leftMargin += frame.size.width;
            }
            
            [updatedAttributes addObject:newAttribute];
        } else {
            [updatedAttributes addObject:attribute];
        }
    }
    
    return updatedAttributes;
}


@end
