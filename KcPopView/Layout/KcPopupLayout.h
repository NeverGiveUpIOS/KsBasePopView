//
//  PopupLayout.h
//  OCPopView
//
//  Created by cks on 2025/7/9.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PopupLayoutType) {
    PopupLayoutTypeCenter,
    PopupLayoutTypeTop,
    PopupLayoutTypeBottom,
    PopupLayoutTypeLeft,
    PopupLayoutTypeRight
};

@interface KcPopupLayout : NSObject
@property (nonatomic, assign) PopupLayoutType type;
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

+ (instancetype)centerWithOffsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY;
+ (instancetype)centerWithOffsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY width:(CGFloat)width height:(CGFloat)height;
+ (instancetype)topWithMargin:(CGFloat)margin offsetX:(CGFloat)offsetX;
+ (instancetype)bottomWithMargin:(CGFloat)margin offsetX:(CGFloat)offsetX;
+ (instancetype)leftWithMargin:(CGFloat)margin offsetY:(CGFloat)offsetY;
+ (instancetype)rightWithMargin:(CGFloat)margin offsetY:(CGFloat)offsetY;
@end
