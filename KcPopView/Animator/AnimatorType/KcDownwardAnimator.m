//
//  DownwardAnimator.m
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import "KcDownwardAnimator.h"
#import "KcPopupViewBackgroundView.h"

@implementation KcDownwardAnimator

- (void)setupWithPopupView:(KcPopupView *)popupView
               contentView:(UIView *)contentView
           backgroundView:(KcPopupViewBackgroundView *)backgroundView {
    [super setupWithPopupView:popupView contentView:contentView backgroundView:backgroundView];
    
    contentView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(contentView.bounds));
    backgroundView.alpha = 0;
}

- (void)displayWithContentView:(UIView *)contentView
               backgroundView:(KcPopupViewBackgroundView *)backgroundView
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion {
    
    [UIView animateWithDuration:self.displayDuration animations:^{
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
    
    [UIView animateWithDuration:self.dismissDuration animations:^{
        contentView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(contentView.bounds));
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}
@end
