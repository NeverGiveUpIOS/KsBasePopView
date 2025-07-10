//
//  PopupView.h
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import <UIKit/UIKit.h>
#import "PopupViewAnimator.h"
#import "KcPopupLayout.h"

@interface KcPopupView : UIView
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) id<PopupViewAnimator> animator;
@property (nonatomic, strong) KcPopupLayout *layout;
@property (nonatomic, assign) BOOL isDismissible;

- (instancetype)initWithContainerView:(UIView *)containerView
                         contentView:(UIView *)contentView
                            animator:(id<PopupViewAnimator>)animator
                              layout:(KcPopupLayout *)layout;

- (void)displayAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion;
@end
