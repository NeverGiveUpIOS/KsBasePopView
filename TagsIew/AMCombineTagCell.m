//
//  AMCombineTagCell.m
//  genKiMaatProject
//
//  Created by yy on 2025/7/2.
//

#import "AMCombineTagCell.h"

@interface AMCombineTagCell ()

@end

@implementation AMCombineTagCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    _tagLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_tagLabel];
    
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 8, 0, 8));
    }];
    
    self.contentView.layer.masksToBounds = YES;
    self.cornerRadius = 27/2;
    self.tagBackgroundColor = [UIColor getColor:@"F2F2F2"];
    self.tagTextColor = [UIColor getColor:@"999999"];
}

- (void)configureWithText:(NSString *)text {
    _tagLabel.text = text;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.contentView.layer.cornerRadius = cornerRadius;
}

- (void)setTagBackgroundColor:(UIColor *)tagBackgroundColor {
    _tagBackgroundColor = tagBackgroundColor;
    self.contentView.backgroundColor = tagBackgroundColor;
}

- (void)setTagTextColor:(UIColor *)tagTextColor {
    _tagTextColor = tagTextColor;
    _tagLabel.textColor = tagTextColor;
}


@end
