// placeholder layout
#import "WaterfallLayout.h"

@interface WaterfallLayout ()
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *cache;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *headerAttributes;
@property (nonatomic, assign) CGFloat contentHeight;
@end

@implementation WaterfallLayout


- (instancetype)init {
    self = [super init];
    if (self) {
        _numberOfColumns = 2;
        _cellPadding = 8.0;
        _cache = [NSMutableArray array];
    }
    return self;
}

- (CGFloat)contentWidth {
    if (!self.collectionView) {
        return 0;
    }
    UIEdgeInsets insets = self.collectionView.contentInset;
    return CGRectGetWidth(self.collectionView.bounds) - insets.left - insets.right;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake([self contentWidth], self.contentHeight);
}

- (void)prepareLayout {
    [super prepareLayout];
    
    UICollectionView *collectionView = self.collectionView;
    if (!collectionView) {
        return;
    }
    
    [self.cache removeAllObjects];
    self.contentHeight = 0;
    
    // Calculate Header
    CGSize headerSize = CGSizeZero;
    if ([self.delegate respondsToSelector:@selector(collectionView:sizeForHeaderInSection:)]) {
        headerSize = [self.delegate collectionView:collectionView sizeForHeaderInSection:0];
    }
    
    if (headerSize.height > 0) {
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        attributes.frame = CGRectMake(0, 0, headerSize.width, headerSize.height);
        self.headerAttributes = attributes;
        self.contentHeight = headerSize.height;
    }
    
    // Calculate column widths
    CGFloat columnWidth = ([self contentWidth] - (self.numberOfColumns - 1) * self.cellPadding) / self.numberOfColumns;
    NSMutableArray *xOffset = [NSMutableArray array];
    for (NSInteger i = 0; i < self.numberOfColumns; i++) {
        [xOffset addObject:@(i * (columnWidth + self.cellPadding))];
    }
    
    NSMutableArray *yOffset = [NSMutableArray array];
    for (NSInteger i = 0; i < self.numberOfColumns; i++) {
        [yOffset addObject:@(self.contentHeight + self.cellPadding)];
    }
    
    // Calculate all cells
    NSInteger itemCount = [collectionView numberOfItemsInSection:0];
    for (NSInteger item = 0; item < itemCount; item++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        
        CGSize itemSize = CGSizeZero;
        if ([self.delegate respondsToSelector:@selector(collectionView:sizeForItemAtIndexPath:)]) {
            itemSize = [self.delegate collectionView:collectionView sizeForItemAtIndexPath:indexPath];
        }
        
        // Find shortest column
        __block NSInteger column = 0;
        __block CGFloat minYOffset = CGFLOAT_MAX;
        [yOffset enumerateObjectsUsingBlock:^(NSNumber *offset, NSUInteger idx, BOOL *stop) {
            if ([offset floatValue] < minYOffset) {
                minYOffset = [offset floatValue];
                column = idx;
            }
        }];
        
        CGRect frame = CGRectMake([xOffset[column] floatValue],
                                 [yOffset[column] floatValue],
                                 columnWidth,
                                 itemSize.height);
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = frame;
        [self.cache addObject:attributes];
        
        self.contentHeight = MAX(self.contentHeight, CGRectGetMaxY(frame));
        yOffset[column] = @([yOffset[column] floatValue] + itemSize.height + self.cellPadding);
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *visibleAttributes = [NSMutableArray array];
    
    if (self.headerAttributes && CGRectIntersectsRect(self.headerAttributes.frame, rect)) {
        [visibleAttributes addObject:self.headerAttributes];
    }
    
    for (UICollectionViewLayoutAttributes *attributes in self.cache) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [visibleAttributes addObject:attributes];
        }
    }
    
    return visibleAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    for (UICollectionViewLayoutAttributes *attributes in self.cache) {
        if ([attributes.indexPath isEqual:indexPath]) {
            return attributes;
        }
    }
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        return self.headerAttributes;
    }
    return nil;
}

- (void)invalidateLayout {
    [super invalidateLayout];
    [self.cache removeAllObjects];
    self.headerAttributes = nil;
    self.contentHeight = 0;
}


@end
