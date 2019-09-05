//
//  ZHDrawingCuboidLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingCuboidLayer.h"

@implementation ZHDrawingCuboidLayer

//绘制立方体
- (void)movePathWithEndPoint:(CGPoint)endPoint
{
    self.endPoint = endPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat width = endPoint.x - self.startPoint.x;
    CGFloat height = endPoint.y - self.startPoint.y;
    
    //绘制虚线
    [path moveToPoint:CGPointMake(self.startPoint.x + width/5, endPoint.y - height/6)];
    [path addLineToPoint:CGPointMake(self.startPoint.x + width/5, self.startPoint.y)];
    
    [path moveToPoint:CGPointMake(self.startPoint.x + width/5, endPoint.y - height/6)];
    [path addLineToPoint:CGPointMake(self.startPoint.x, endPoint.y)];
    
    [path moveToPoint:CGPointMake(self.startPoint.x + width/5, endPoint.y - height/6)];
    [path addLineToPoint:CGPointMake(endPoint.x, endPoint.y - height/6)];
    
    //绘制周线
    [path moveToPoint:CGPointMake(endPoint.x, self.startPoint.y)];
    [path addLineToPoint:CGPointMake(self.startPoint.x + width/5, self.startPoint.y)];
    [path addLineToPoint:CGPointMake(self.startPoint.x, self.startPoint.y + height/6)];
    [path addLineToPoint:CGPointMake(self.startPoint.x, endPoint.y)];
    [path addLineToPoint:CGPointMake(endPoint.x - width/5, endPoint.y)];
    [path addLineToPoint:CGPointMake(endPoint.x - width/5, self.startPoint.y + height/6)];
    [path addLineToPoint:CGPointMake(endPoint.x, self.startPoint.y)];
    [path addLineToPoint:CGPointMake(endPoint.x, endPoint.y - height/6)];
    [path addLineToPoint:CGPointMake(endPoint.x - width/5, endPoint.y)];
    
    //绘制中间线
    [path moveToPoint:CGPointMake(self.startPoint.x, self.startPoint.y + height/6)];
    [path addLineToPoint:CGPointMake(endPoint.x - width/5, self.startPoint.y + height/6)];
    
    self.path = path.CGPath;
}

@end
