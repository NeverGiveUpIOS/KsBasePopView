//
//  PopupViewAnimator.h
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class KcPopupView;
@class KcPopupViewBackgroundView;

@protocol PopupViewAnimator <NSObject>
- (void)setupWithPopupView:(KcPopupView *)popupView
               contentView:(UIView *)contentView
           backgroundView:(KcPopupViewBackgroundView *)backgroundView;
- (void)displayWithContentView:(UIView *)contentView
               backgroundView:(KcPopupViewBackgroundView *)backgroundView
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion;
- (void)dismissWithContentView:(UIView *)contentView
               backgroundView:(KcPopupViewBackgroundView *)backgroundView
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion;
@end
