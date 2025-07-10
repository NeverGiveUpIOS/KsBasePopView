// placeholder layout
#import <UIKit/UIKit.h>

@class WaterfallLayout;

@protocol HomeWaterfallLayoutDelegate <NSObject>

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize)collectionView:(UICollectionView *)collectionView sizeForHeaderInSection:(NSInteger)section;

@end


@interface WaterfallLayout : UICollectionViewLayout
@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, assign) CGFloat cellPadding;
@property (nonatomic, weak) id<HomeWaterfallLayoutDelegate> delegate;
@end
