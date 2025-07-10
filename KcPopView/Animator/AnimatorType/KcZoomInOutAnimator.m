//
//  ZoomInOutAnimator.m
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import "KcZoomInOutAnimator.h"
#import "KcPopupViewBackgroundView.h"

@implementation KcZoomInOutAnimator

- (void)setupWithPopupView:(KcPopupView *)popupView
               contentView:(UIView *)contentView
           backgroundView:(KcPopupViewBackgroundView *)backgroundView {
    
    [self applyLayoutToContentView:contentView inPopupView:popupView];
    
    contentView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    backgroundView.alpha = 0;
}

- (void)displayWithContentView:(UIView *)contentView
               backgroundView:(KcPopupViewBackgroundView *)backgroundView
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion {
    
    [UIView animateWithDuration:self.displayDuration
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.8
                        options:0
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
        contentView.transform = CGAffineTransformMakeScale(0.3, 0.3);
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}
@end
