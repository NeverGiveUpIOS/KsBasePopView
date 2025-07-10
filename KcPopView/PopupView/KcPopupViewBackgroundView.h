//
//  PopupViewBackgroundView.h
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BackgroundStyle) {
    BackgroundStyleSolidColor,
    BackgroundStyleBlur
};

@interface KcPopupViewBackgroundView : UIControl
@property (nonatomic, assign) BackgroundStyle style;
@property (nonatomic, assign) UIBlurEffectStyle blurEffectStyle;
@property (nonatomic, strong) UIColor *color;
- (instancetype)initWithFrame:(CGRect)frame;
@end
