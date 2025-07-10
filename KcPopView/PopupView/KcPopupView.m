//
//  PopupView.m
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import "KcPopupView.h"
#import "KcPopupViewBackgroundView.h"

@interface KcPopupView ()
@property (nonatomic, strong) KcPopupViewBackgroundView *backgroundView;
@end

@implementation KcPopupView

- (instancetype)initWithContainerView:(UIView *)containerView
                         contentView:(UIView *)contentView
                            animator:(id<PopupViewAnimator>)animator
                              layout:(KcPopupLayout *)layout {
    self = [super initWithFrame:containerView.bounds];
    if (self) {
        _containerView = containerView;
        _contentView = contentView;
        _animator = animator;
        _layout = layout;
        _backgroundView = [[KcPopupViewBackgroundView alloc] initWithFrame:self.bounds];
        _isDismissible = YES;
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.backgroundView];
    [self addSubview:self.contentView];
    
    [self.backgroundView setUserInteractionEnabled:self.isDismissible];
    [self.backgroundView addTarget:self action:@selector(backgroundViewClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.animator setupWithPopupView:self
                         contentView:self.contentView
                     backgroundView:self.backgroundView];
}

- (void)displayAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self.containerView addSubview:self];
    [self.animator displayWithContentView:self.contentView
                         backgroundView:self.backgroundView
                              animated:animated
                            completion:completion];
}

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self.animator dismissWithContentView:self.contentView
                         backgroundView:self.backgroundView
                              animated:animated
                            completion:^{
        [self removeFromSuperview];
        if (completion) completion();
    }];
}

- (void)backgroundViewClicked {
    [self dismissAnimated:YES completion:nil];
}
@end
