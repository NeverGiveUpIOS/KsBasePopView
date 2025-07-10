//
//  PopupViewBackgroundView.m
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import "KcPopupViewBackgroundView.h"

@interface KcPopupViewBackgroundView ()
@property (nonatomic, strong) UIVisualEffectView *effectView;
@end

@implementation KcPopupViewBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _style = BackgroundStyleSolidColor;
        _blurEffectStyle = UIBlurEffectStyleDark;
        _color = [UIColor colorWithWhite:0 alpha:0.3];
        self.backgroundColor = _color;
    }
    return self;
}

- (void)setStyle:(BackgroundStyle)style {
    _style = style;
    [self refreshBackgroundStyle];
}

- (void)refreshBackgroundStyle {
    [self.effectView removeFromSuperview];
    self.effectView = nil;
    
    if (self.style == BackgroundStyleBlur) {
        self.effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:self.blurEffectStyle]];
        self.effectView.frame = self.bounds;
        [self addSubview:self.effectView];
    }
}
@end
