//
//  ZHDrawingArrowLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingArrowLayer.h"

@implementation ZHDrawingArrowLayer

//绘制单箭头直线
- (void)movePathWithEndPoint:(CGPoint)endPoint{
    
    self.endPoint = endPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:endPoint];
    [path appendPath:[self createArrowWithStartPoint:self.startPoint endPoint:endPoint]];
    
    self.path = path.CGPath;
}

@end
