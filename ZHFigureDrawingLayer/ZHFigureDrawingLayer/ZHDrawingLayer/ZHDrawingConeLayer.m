//
//  ZHDrawingConeLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingConeLayer.h"

@implementation ZHDrawingConeLayer

//绘制圆锥
- (void)movePathWithEndPoint:(CGPoint)endPoint
{
    self.endPoint = endPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //    CGFloat radius = [self distanceBetweenStartPoint:self.startPoint endPoint:endPoint];
    //    CGFloat angle = [self angleWithFirstPoint:self.startPoint andSecondPoint:endPoint];
    CGFloat width = fabs(endPoint.x - self.startPoint.x);
    CGFloat height = fabs(endPoint.y - self.startPoint.y);
    CGFloat endY = 0.f;
    CGRect rectToFill;
    if (endPoint.y > self.startPoint.y) {
        endY = endPoint.y - height/6;
        rectToFill = CGRectMake(self.startPoint.x - width/2, endPoint.y - height/3, width, height/3);
        UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:rectToFill];
        [path appendPath:ovalPath];
        
    }else{
        endY = endPoint.y + height/6;
        rectToFill = CGRectMake(self.startPoint.x - width/2, endPoint.y, width, height/3);
        UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:rectToFill];
        [path appendPath:ovalPath];
        
    }
    //绘制周线
    [path moveToPoint:CGPointMake(self.startPoint.x - width/2, endY)];
    [path addLineToPoint:self.startPoint];
    [path addLineToPoint:CGPointMake(self.startPoint.x + width/2, endY)];
    
    //绘制中间线
    //    [self setLineDashPattern: [NSArray arrayWithObjects:
    //                               [NSNumber numberWithInt:10],
    //                               [NSNumber numberWithInt:5],
    //                               nil]];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, self.startPoint.x - width/2, endY);
    CGPathAddLineToPoint(pathRef, NULL, self.startPoint.x + width/2, endY);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:pathRef];
    
    [path appendPath:bezierPath];
    CGPathRelease(pathRef);
    self.path = path.CGPath;
}

@end
