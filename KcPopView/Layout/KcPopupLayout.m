//
//  PopupLayout.m
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import "KcPopupLayout.h"

@implementation KcPopupLayout

+ (instancetype)centerWithOffsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
    KcPopupLayout *layout = [[self alloc] init];
    layout.type = PopupLayoutTypeCenter;
    layout.offsetX = offsetX;
    layout.offsetY = offsetY;
    return layout;
}

+ (instancetype)centerWithOffsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY width:(CGFloat)width height:(CGFloat)height {
    KcPopupLayout *layout = [self centerWithOffsetX:offsetX offsetY:offsetY];
    layout.width = width;
    layout.height = height;
    return layout;
}

+ (instancetype)topWithMargin:(CGFloat)margin offsetX:(CGFloat)offsetX {
    KcPopupLayout *layout = [[self alloc] init];
    layout.type = PopupLayoutTypeTop;
    layout.margin = margin;
    layout.offsetX = offsetX;
    return layout;
}

+ (instancetype)bottomWithMargin:(CGFloat)margin offsetX:(CGFloat)offsetX {
    KcPopupLayout *layout = [[self alloc] init];
    layout.type = PopupLayoutTypeBottom;
    layout.margin = margin;
    layout.offsetX = offsetX;
    return layout;
}

+ (instancetype)leftWithMargin:(CGFloat)margin offsetY:(CGFloat)offsetY {
    KcPopupLayout *layout = [[self alloc] init];
    layout.type = PopupLayoutTypeLeft;
    layout.margin = margin;
    layout.offsetY = offsetY;
    return layout;
}

+ (instancetype)rightWithMargin:(CGFloat)margin offsetY:(CGFloat)offsetY {
    KcPopupLayout *layout = [[self alloc] init];
    layout.type = PopupLayoutTypeRight;
    layout.margin = margin;
    layout.offsetY = offsetY;
    return layout;
}
@end
