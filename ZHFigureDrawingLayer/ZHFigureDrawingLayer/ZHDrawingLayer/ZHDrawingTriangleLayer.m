//
//  ZHDrawingTriangleLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingTriangleLayer.h"

@implementation ZHDrawingTriangleLayer

//三角形
-(void)movePathWithEndPoint:(CGPoint)endPoint{
    
    self.endPoint = endPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:CGPointMake(endPoint.x, self.startPoint.y)];
    [path addLineToPoint:CGPointMake(self.startPoint.x, endPoint.y)];
    [path addLineToPoint:self.startPoint];
    
    self.path = path.CGPath;
}

@end
