//
//  ZHDrawingRhombusLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingRhombusLayer.h"

@implementation ZHDrawingRhombusLayer

//绘制菱形
- (void)movePathWithEndPoint:(CGPoint)endPoint
{
    self.endPoint = endPoint;
    
    CGFloat midX = self.startPoint.x + (endPoint.x - self.startPoint.x)/2;
    CGFloat midY = self.startPoint.y + (endPoint.y - self.startPoint.y)/2;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(midX, self.startPoint.y)];
    [path addLineToPoint:CGPointMake(self.startPoint.x, midY)];
    [path addLineToPoint:CGPointMake(midX, endPoint.y)];
    [path addLineToPoint:CGPointMake(endPoint.x, midY)];
    [path addLineToPoint:CGPointMake(midX, self.startPoint.y)];
    
    self.path = path.CGPath;
}

@end
