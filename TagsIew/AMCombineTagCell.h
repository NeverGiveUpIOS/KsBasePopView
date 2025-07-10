//
//  AMCombineTagCell.h
//  genKiMaatProject
//
//  Created by yy on 2025/7/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMCombineTagCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *tagBackgroundColor;
@property (nonatomic, strong) UIColor *tagTextColor;

- (void)configureWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
