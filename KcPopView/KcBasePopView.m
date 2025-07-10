//
//  tempView.m
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import "KcBasePopView.h"
#import "KcBaseAnimator.h"
#import "KcPopupLayout.h"
#import "KcDownwardAnimator.h"
#import "KcUpwardAnimator.h"
#import "KcFadeInOutAnimator.h"
#import "KcZoomInOutAnimator.h"
#import "KcLeftwardAnimator.h"
#import "KcRightwardAnimator.h"

@implementation KcBasePopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _isDismissible = YES;
        _bagColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    return self;
}

#pragma mark - 容器视图获取
- (UIView *)getContainerView:(AlertContainerType)type {
    switch (type) {
        case AlertContainerTypeWindow: {
            if (@available(iOS 15.0, *)) {
                for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
                    if ([scene isKindOfClass:[UIWindowScene class]]) {
                        UIWindowScene *windowScene = (UIWindowScene *)scene;
                        for (UIWindow *window in windowScene.windows) {
                            if (window.isKeyWindow) {
                                return window;
                            }
                        }
                    }
                }
            } else {
                return UIApplication.sharedApplication.keyWindow;
            }
            break;
        }
        case AlertContainerTypeCurView: // 一般都是顶层Topview
            return self.superview;
    }
    return nil;
}

#pragma mark - 构建弹窗
- (void)buildPopupWithContainerView:(UIView *)containerView animator:(KcBaseAnimator *)animator layout:(KcPopupLayout *) layout{
    // 4. 创建弹窗
    KcPopupView *popup = [[KcPopupView alloc] initWithContainerView:containerView
                                                        contentView:self
                                                           animator:animator
                                                             layout:layout];
    popup.isDismissible = self.isDismissible;
    popup.backgroundColor = self.bagColor;
    self.currentPopup = popup;
    // 5. 显示弹窗
    [popup displayAnimated:YES completion:nil];
}

#pragma mark - Show In Center
- (void)showCenterWithContainerType:(AlertContainerType)containerType isFadeIn:(BOOL)isFadeIn {
    UIView *containerView = [self getContainerView:containerType];
    if (!containerView) return;
    
    if (isFadeIn) {
        // 2. 配置布局
        KcPopupLayout *layout = [KcPopupLayout centerWithOffsetX:0 offsetY:0];
        // 3. 创建动画器
        KcFadeInOutAnimator *animator = [[KcFadeInOutAnimator alloc] init];
        animator.layout = layout;
        [self buildPopupWithContainerView:containerView animator:animator layout:layout];
    } else {
        // 2. 配置布局（从顶部下滑）
        KcPopupLayout *layout = [KcPopupLayout centerWithOffsetX:0 offsetY:0];
        // 3. 创建动画器
        KcZoomInOutAnimator *animator = [[KcZoomInOutAnimator alloc] init];
        animator.layout = layout;
        [self buildPopupWithContainerView:containerView animator:animator layout:layout];

    }
    
}

#pragma mark - Show In Left
- (void)showLeftWithContainerType:(AlertContainerType)containerType leadingMargin:(CGFloat)leadingMargin {
    UIView *containerView = [self getContainerView:containerType];
    if (!containerView) return;
    KcPopupLayout *layout = [KcPopupLayout leftWithMargin:leadingMargin offsetY:0];
    KcLeftwardAnimator *animator = [[KcLeftwardAnimator alloc] init];
    animator.layout = layout;
    [self buildPopupWithContainerView:containerView animator:animator layout:layout];
}

#pragma mark - Show In Right
- (void)showRightWithContainerType:(AlertContainerType)containerType trailingMargin:(CGFloat)trailingMargin{
    UIView *containerView = [self getContainerView:containerType];
    if (!containerView) return;
    
    KcPopupLayout *layout = [KcPopupLayout rightWithMargin:trailingMargin offsetY:0];

    KcRightwardAnimator *animator = [[KcRightwardAnimator alloc] init];
    animator.layout = layout;
    [self buildPopupWithContainerView:containerView animator:animator layout:layout];
}

#pragma mark - Show In Down
- (void)showDownWithContainerType:(AlertContainerType)containerType topMargin:(CGFloat)topMargin {
    UIView *containerView = [self getContainerView:containerType];
    if (!containerView) return;
    
    KcPopupLayout *layout = [KcPopupLayout topWithMargin:topMargin offsetX:0];
    KcDownwardAnimator *animator = [[KcDownwardAnimator alloc] init];
    animator.layout = layout;
    [self buildPopupWithContainerView:containerView animator:animator layout:layout];

}

#pragma mark - Show In Up
- (void)showUpWithContainerType:(AlertContainerType)containerType bottomMargin:(CGFloat)bottomMargin {
    UIView *containerView = [self getContainerView:containerType];
    if (!containerView) return;
    
    KcPopupLayout *layout = [KcPopupLayout bottomWithMargin:bottomMargin offsetX:0];
    KcUpwardAnimator *animator = [[KcUpwardAnimator alloc] init];
    animator.layout = layout;
    [self buildPopupWithContainerView:containerView animator:animator layout:layout];
}

#pragma mark - 消失方法
- (void)dismissView {
    [self.currentPopup dismissAnimated:YES completion:^{
        [self removeFromSuperview];
    }];
}

- (void)dealloc {
    NSLog(@"KcBasePopView==========dealloc");
}

- (CGSize)intrinsicContentSize {
    return self.frame.size;
}

@end
