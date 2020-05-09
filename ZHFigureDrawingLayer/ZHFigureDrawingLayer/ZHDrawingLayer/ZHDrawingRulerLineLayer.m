//
//  ZHDrawingRulerLineLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingRulerLineLayer.h"

@implementation ZHDrawingRulerLineLayer

//双杠直线
- (void)movePathWithEndPoint:(CGPoint)endPoint{
    
    self.endPoint = endPoint;
    
    CGFloat length = 0;
    UIBezierPath *path = [UIBezierPath bezierPath];
    path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    CGFloat angle = [self angleWithFirstPoint:self.startPoint andSecondPoint:endPoint];
    CGPoint pointMiddle = CGPointMake((self.startPoint.x+endPoint.x)/2, (self.startPoint.y+endPoint.y)/2);
    CGFloat offsetX = length*cos(angle);
    CGFloat offsetY = length*sin(angle);
    CGPoint pointMiddle1 = CGPointMake(pointMiddle.x-offsetX, pointMiddle.y-offsetY);
    CGPoint pointMiddle2 = CGPointMake(pointMiddle.x+offsetX, pointMiddle.y+offsetY);
    [path addLineToPoint:pointMiddle1];
    [path moveToPoint:pointMiddle2];
    [path addLineToPoint:endPoint];
    [path moveToPoint:endPoint];
    angle = [self angleEndWithFirstPoint:self.startPoint andSecondPoint:endPoint];
    CGPoint point1 = CGPointMake(endPoint.x+10*sin(angle), endPoint.y+10*cos(angle));
    CGPoint point2 = CGPointMake(endPoint.x-10*sin(angle), endPoint.y-10*cos(angle));
    
    //增加边界控制
    CGRect paintRect = CGRectMake(0, 0, self.paintSize.width, self.paintSize.height);
    if (!CGRectContainsPoint(paintRect, point1)
        || !CGRectContainsPoint(paintRect, point2)){
        return;
    }
    
    [path addLineToPoint:point1];
    [path addLineToPoint:point2];
    CGPoint point3 = CGPointMake(point1.x-(endPoint.x-self.startPoint.x), point1.y-(endPoint.y-self.startPoint.y));
    CGPoint point4 = CGPointMake(point2.x-(endPoint.x-self.startPoint.x), point2.y-(endPoint.y-self.startPoint.y));
    [path moveToPoint:point3];
    [path addLineToPoint:point4];
    [path setLineWidth:4];
    
    [self setPath:path.CGPath];
    
}

@end
