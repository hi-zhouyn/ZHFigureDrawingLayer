//
//  ZHDrawingTriangularPyramidLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingTriangularPyramidLayer.h"

@implementation ZHDrawingTriangularPyramidLayer

//绘制三棱锥
- (void)movePathWithEndPoint:(CGPoint)endPoint
{
    self.endPoint = endPoint;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //绘制周线
    CGFloat midY = 0.f;
    [path moveToPoint:CGPointMake((endPoint.x + self.startPoint.x)/2, self.startPoint.y)];
    
    midY = self.startPoint.y + (endPoint.y - self.startPoint.y)*3/4;
    
    [path addLineToPoint:CGPointMake(self.startPoint.x, midY)];
    [path addLineToPoint:CGPointMake((endPoint.x + self.startPoint.x)/2, endPoint.y)];
    [path addLineToPoint:CGPointMake(endPoint.x, midY)];
    [path addLineToPoint:CGPointMake((endPoint.x + self.startPoint.x)/2, self.startPoint.y)];
    
    //绘制虚线
    //    [self setLineDashPattern: [NSArray arrayWithObjects:
    //                               [NSNumber numberWithInt:10],
    //                               [NSNumber numberWithInt:5],
    //                               nil]];
    //
    //    CGMutablePathRef pathRef = CGPathCreateMutable();
    //    CGPathMoveToPoint(pathRef, NULL, self.startPoint.x, midY);
    //    CGPathAddLineToPoint(pathRef, NULL, endPoint.x, midY);
    //    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:pathRef];
    //    [path appendPath:bezierPath];
    
    [path moveToPoint:CGPointMake(self.startPoint.x, midY)];
    [path addLineToPoint:CGPointMake(endPoint.x, midY)];
    
    //绘制中间线
    [path moveToPoint:CGPointMake((endPoint.x + self.startPoint.x)/2, self.startPoint.y)];
    [path addLineToPoint:CGPointMake((endPoint.x + self.startPoint.x)/2, endPoint.y)];
    
    self.path = path.CGPath;
}

@end
