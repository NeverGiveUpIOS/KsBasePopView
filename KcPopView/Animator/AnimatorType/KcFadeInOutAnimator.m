//
//  FadeInOutAnimator.m
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import "KcFadeInOutAnimator.h"
#import "KcPopupViewBackgroundView.h"

@implementation KcFadeInOutAnimator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.displayDuration = 0.2;
        self.dismissDuration = 0.15;
    }
    return self;
}

- (void)setupWithPopupView:(KcPopupView *)popupView
               contentView:(UIView *)contentView
           backgroundView:(KcPopupViewBackgroundView *)backgroundView {
    
    [self applyLayoutToContentView:contentView inPopupView:popupView];
    
    contentView.alpha = 0;
    backgroundView.alpha = 0;
}

- (void)displayWithContentView:(UIView *)contentView
               backgroundView:(KcPopupViewBackgroundView *)backgroundView
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion {
    
    [UIView animateWithDuration:self.displayDuration
                     animations:^{
        contentView.alpha = 1;
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
        contentView.alpha = 0;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}
@end
