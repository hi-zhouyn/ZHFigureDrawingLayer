//
//  ZHFigureDrawingToolView.h
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/10/16.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHFigureDrawingToolView;

/**
 selType(选择的功能类型):0~图形选择，1~颜色选择，2~清除
 drawingType:选择的图形类型
 color:画笔颜色
 */
typedef void(^DrawingToolBlock)(ZHFigureDrawingToolView *toolView,NSInteger selType,NSInteger drawingType,UIColor * _Nullable color);

NS_ASSUME_NONNULL_BEGIN

@interface ZHFigureDrawingToolView : UIView

@property (nonatomic, copy) DrawingToolBlock toolBlock;
@property (nonatomic, assign) NSUInteger figureIndex;
@property (nonatomic, assign) NSUInteger colorIndex;

- (void)showInView:(UIView *)view;
- (void)hideView;

@end

NS_ASSUME_NONNULL_END
