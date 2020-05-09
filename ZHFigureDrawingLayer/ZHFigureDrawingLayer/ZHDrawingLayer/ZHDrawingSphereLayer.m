//
//  ZHDrawingSphereLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingSphereLayer.h"

@implementation ZHDrawingSphereLayer

//绘制球体
- (void)movePathWithEndPoint:(CGPoint)endPoint
{
    self.endPoint = endPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat angle = [self angleWithFirstPoint:self.startPoint andSecondPoint:endPoint];
    CGFloat radius = fabs(endPoint.y - self.startPoint.y)/sin(angle);
    
    //增加边界控制
    CGPoint tPoint = CGPointMake(self.startPoint.x, self.startPoint.y - radius);
    CGPoint lPoint = CGPointMake(self.startPoint.x - radius, self.startPoint.y);
    CGPoint bPoint = CGPointMake(self.startPoint.x, self.startPoint.y + radius);
    CGPoint rPoint = CGPointMake(self.startPoint.x + radius, self.startPoint.y);
    CGRect paintRect = CGRectMake(0, 0, self.paintSize.width, self.paintSize.height);
    if (!CGRectContainsPoint(paintRect, tPoint)
        || !CGRectContainsPoint(paintRect, lPoint)
        || !CGRectContainsPoint(paintRect, bPoint)
        || !CGRectContainsPoint(paintRect, rPoint)){
        return;
    }
    
    //绘制圆
    [path addArcWithCenter:self.startPoint radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CGRect rectToFill = CGRectMake(self.startPoint.x - radius, self.startPoint.y - radius/3, radius*2, radius/3*2);
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:rectToFill];
    [path appendPath:ovalPath];
    
    //绘制中间线
    //    [self setLineDashPattern: [NSArray arrayWithObjects:
    //                               [NSNumber numberWithInt:10],
    //                               [NSNumber numberWithInt:5],
    //                               nil]];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, self.startPoint.x - radius, self.startPoint.y);
    CGPathAddLineToPoint(pathRef, NULL, self.startPoint.x + radius, self.startPoint.y);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:pathRef];
    
    [path appendPath:bezierPath];
    CGPathRelease(pathRef);
    self.path = path.CGPath;
    
}

@end
