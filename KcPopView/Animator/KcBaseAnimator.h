//
//  BaseAnimator.h
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import "PopupViewAnimator.h"
#import "KcPopupLayout.h"
#import "KcPopupView.h"

@interface KcBaseAnimator : NSObject <PopupViewAnimator>
@property (nonatomic, strong) KcPopupLayout *layout;
@property (nonatomic, assign) NSTimeInterval displayDuration;
@property (nonatomic, assign) NSTimeInterval dismissDuration;

- (void)applyLayoutToContentView:(UIView *)contentView inPopupView:(KcPopupView *)popupView;
@end
