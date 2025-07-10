//
//  AMCombineTagsView.h
//  genKiMaatProject
//
//  Created by yy on 2025/7/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMCombineTagsView : UIView

@property (nonatomic, strong) NSArray<NSString *> *tags;

@property (nonatomic, copy) void (^calltagBlick) (NSString *);

@property (nonatomic, assign)  CGFloat contentHeight;

- (void)clearheight;


@end

NS_ASSUME_NONNULL_END
