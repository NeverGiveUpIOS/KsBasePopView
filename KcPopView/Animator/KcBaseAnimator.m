//
//  BaseAnimator.m
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import "KcBaseAnimator.h"

@implementation KcBaseAnimator

- (instancetype)init {
    self = [super init];
    if (self) {
        _displayDuration = 0.25;
        _dismissDuration = 0.25;
    }
    return self;
}

- (void)applyLayoutToContentView:(UIView *)contentView inPopupView:(KcPopupView *)popupView {
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    switch (self.layout.type) {
        case PopupLayoutTypeCenter: {
            [NSLayoutConstraint activateConstraints:@[
                [contentView.centerXAnchor constraintEqualToAnchor:popupView.centerXAnchor constant:self.layout.offsetX],
                [contentView.centerYAnchor constraintEqualToAnchor:popupView.centerYAnchor constant:self.layout.offsetY]
            ]];
            
            if (self.layout.width > 0) {
                [contentView.widthAnchor constraintEqualToConstant:self.layout.width].active = YES;
            }
            if (self.layout.height > 0) {
                [contentView.heightAnchor constraintEqualToConstant:self.layout.height].active = YES;
            }
            break;
        }
            
        case PopupLayoutTypeTop: {
            [NSLayoutConstraint activateConstraints:@[
                [contentView.topAnchor constraintEqualToAnchor:popupView.topAnchor constant:self.layout.margin],
                [contentView.centerXAnchor constraintEqualToAnchor:popupView.centerXAnchor constant:self.layout.offsetX]
            ]];
            break;
        }
            
        case PopupLayoutTypeBottom: {
            [NSLayoutConstraint activateConstraints:@[
                [contentView.bottomAnchor constraintEqualToAnchor:popupView.bottomAnchor constant:-self.layout.margin],
                [contentView.centerXAnchor constraintEqualToAnchor:popupView.centerXAnchor constant:self.layout.offsetX]
            ]];
            break;
        }
            
        case PopupLayoutTypeLeft: {
            [NSLayoutConstraint activateConstraints:@[
                [contentView.leadingAnchor constraintEqualToAnchor:popupView.leadingAnchor constant:self.layout.margin],
                [contentView.centerYAnchor constraintEqualToAnchor:popupView.centerYAnchor constant:self.layout.offsetY]
            ]];
            break;
        }
            
        case PopupLayoutTypeRight: {
            [NSLayoutConstraint activateConstraints:@[
                [contentView.trailingAnchor constraintEqualToAnchor:popupView.trailingAnchor constant:-self.layout.margin],
                [contentView.centerYAnchor constraintEqualToAnchor:popupView.centerYAnchor constant:self.layout.offsetY]
            ]];
            break;
        }
    }
}

- (void)setupWithPopupView:(KcPopupView *)popupView
               contentView:(UIView *)contentView
           backgroundView:(KcPopupViewBackgroundView *)backgroundView {
    [self applyLayoutToContentView:contentView inPopupView:popupView];
}

- (void)displayWithContentView:(UIView *)contentView
               backgroundView:(KcPopupViewBackgroundView *)backgroundView
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion {
    // 由子类实现
}

- (void)dismissWithContentView:(UIView *)contentView
               backgroundView:(KcPopupViewBackgroundView *)backgroundView
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion {
    // 由子类实现
}
@end
