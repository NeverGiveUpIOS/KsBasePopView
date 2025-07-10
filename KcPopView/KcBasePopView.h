//
//  tempView.h
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AlertContainerType) {
    AlertContainerTypeCurView,
    AlertContainerTypeWindow
};

@class KcPopupView;
@class KcBaseAnimator;


@interface KcBasePopView : UIView

@property (nonatomic, assign) BOOL isDismissible;
@property (nonatomic, strong) UIColor *bagColor;
@property (nonatomic, weak) KcPopupView *currentPopup;

- (instancetype)initWithFrame:(CGRect)frame;

// 显示在Center
- (void)showCenterWithContainerType:(AlertContainerType)containerType isFadeIn:(BOOL)isFadeIn;
- (void)showLeftWithContainerType:(AlertContainerType)containerType leadingMargin:(CGFloat)leadingMargin;
- (void)showRightWithContainerType:(AlertContainerType)containerType trailingMargin:(CGFloat)trailingMargin;
- (void)showDownWithContainerType:(AlertContainerType)containerType topMargin:(CGFloat)topMargin;
- (void)showUpWithContainerType:(AlertContainerType)containerType bottomMargin:(CGFloat)bottomMargin;

// 自定义消失
- (void)dismissView;

@end

NS_ASSUME_NONNULL_END
