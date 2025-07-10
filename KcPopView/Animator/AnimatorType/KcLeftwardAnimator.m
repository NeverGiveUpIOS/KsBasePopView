//
//  LeftwardAnimator.m
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import "KcLeftwardAnimator.h"
#import "KcPopupViewBackgroundView.h"

@implementation KcLeftwardAnimator

- (void)setupWithPopupView:(KcPopupView *)popupView
               contentView:(UIView *)contentView
           backgroundView:(KcPopupViewBackgroundView *)backgroundView {
    
    [self applyLayoutToContentView:contentView inPopupView:popupView];
    
    // 初始位置：屏幕左侧外（准备向右滑入）
    contentView.transform = CGAffineTransformMakeTranslation(-popupView.bounds.size.width, 0);
    backgroundView.alpha = 0;
}

- (void)displayWithContentView:(UIView *)contentView
               backgroundView:(KcPopupViewBackgroundView *)backgroundView
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion {
    
    [UIView animateWithDuration:self.displayDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        // 向右滑动到目标位置
        contentView.transform = CGAffineTransformIdentity;
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

- (void)dismissWithContentView:(UIView *)contentView
               backgroundView:(KcPopupViewBackgroundView *)backgroundView
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion {
    
    [UIView animateWithDuration:self.dismissDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        // 向左滑动消失
        contentView.transform = CGAffineTransformMakeTranslation(-contentView.bounds.size.width, 0);
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}
@end
