//
//  UpwardAnimator.m
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import "KcUpwardAnimator.h"
#import "KcPopupViewBackgroundView.h"

@implementation KcUpwardAnimator

- (void)setupWithPopupView:(KcPopupView *)popupView
               contentView:(UIView *)contentView
           backgroundView:(KcPopupViewBackgroundView *)backgroundView {
    
    [self applyLayoutToContentView:contentView inPopupView:popupView];
    
    // 初始位置：屏幕底部外
    contentView.transform = CGAffineTransformMakeTranslation(0, popupView.bounds.size.height);
    backgroundView.alpha = 0;
}

- (void)displayWithContentView:(UIView *)contentView
               backgroundView:(KcPopupViewBackgroundView *)backgroundView
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion {
    
    [UIView animateWithDuration:self.displayDuration
                     animations:^{
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
                     animations:^{
        contentView.transform = CGAffineTransformMakeTranslation(0, contentView.bounds.size.height);
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}
@end
