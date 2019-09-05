//
//  ZHDrawingCylinderLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingCylinderLayer.h"

@implementation ZHDrawingCylinderLayer

//绘制圆柱
- (void)movePathWithEndPoint:(CGPoint)endPoint
{
    self.endPoint = endPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat width = endPoint.x - self.startPoint.x;
    CGFloat height = endPoint.y - self.startPoint.y;
    CGRect rectToFill;
    
    rectToFill = CGRectMake(self.startPoint.x, self.startPoint.y, width, height/3);
    UIBezierPath *upOvalPath = [UIBezierPath bezierPathWithOvalInRect:rectToFill];
    [path appendPath:upOvalPath];
    
    rectToFill = CGRectMake(self.startPoint.x, endPoint.y - height/3, width, height/3);
    UIBezierPath *downOvalPath = [UIBezierPath bezierPathWithOvalInRect:rectToFill];
    [path appendPath:downOvalPath];
    
    //绘制周线
    [path moveToPoint:CGPointMake(self.startPoint.x , self.startPoint.y + height/6)];
    [path addLineToPoint:CGPointMake(self.startPoint.x , endPoint.y - height/6)];
    
    [path moveToPoint:CGPointMake(endPoint.x , self.startPoint.y + height/6)];
    [path addLineToPoint:CGPointMake(endPoint.x , endPoint.y - height/6)];
    
    
    //绘制中间线
    //    [self setLineDashPattern: [NSArray arrayWithObjects:
    //                               [NSNumber numberWithInt:10],
    //                               [NSNumber numberWithInt:5],
    //                               nil]];
    
    //    CGMutablePathRef pathRef = CGPathCreateMutable();
    //    CGPathMoveToPoint(pathRef, NULL, self.startPoint.x - width/2, endY);
    //    CGPathAddLineToPoint(pathRef, NULL, self.startPoint.x + width/2, endY);
    //    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:pathRef];
    //    [path appendPath:bezierPath];
    
    self.path = path.CGPath;
}

@end
