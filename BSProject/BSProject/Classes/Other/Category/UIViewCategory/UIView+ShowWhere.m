//
//  UIView+ShowWhere.m
//  BSProject
//
//  Created by Liu-Mac on 18/12/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import "UIView+ShowWhere.h"

@implementation UIView (ShowWhere)

- (BOOL)isShowingOnKeyWindow {
    
    // 获取主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 将当前的view在父控件的frame坐标系转换到keyWindow坐标系下的frame
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    // keyWindow的bounds
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    // self没有隐藏, 透明度>0.01, 在主窗口中, 在主窗口的bounds中
    return (!self.isHidden) && (self.alpha > 0.01) && (self.window == keyWindow) && intersects;
    
}

@end
