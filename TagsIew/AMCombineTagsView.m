//
//  AMCombineTagsView.m
//  genKiMaatProject
//
//  Created by yy on 2025/7/2.
//

#import "AMCombineTagsView.h"
#import "AMComBineTagsFlowLayout.h"
#import "AMCombineTagCell.h"
#import "UICollectionView+AMAutoHeight.h"

@interface AMCombineTagsView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation AMCombineTagsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    AMComBineTagsFlowLayout *layout = [[AMComBineTagsFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[AMCombineTagCell class] forCellWithReuseIdentifier:@"TagCollectionViewCell"];
    [self addSubview:_collectionView];
}

- (void)setTags:(NSArray<NSString *> *)tags {
    _tags = tags;
    [_collectionView reloadData];
}

- (void)clearheight {
    [_collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(0);
        make.height.mas_lessThanOrEqualTo(350);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
        make.height.equalTo(@(self.collectionView.contentHeight));
        make.height.mas_lessThanOrEqualTo(350);
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AMCombineTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollectionViewCell" forIndexPath:indexPath];
    if (self.tags.count > 0) {
        [cell configureWithText:self.tags[indexPath.item]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.calltagBlick) {
        self.calltagBlick(self.tags[indexPath.item]);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = self.tags[indexPath.item];
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    
    CGFloat tW = size.width + 28 > SystemScreenWidth - 100 ? SystemScreenWidth - 100 : size.width + 28;
    return CGSizeMake(tW, 27);
}


@end
