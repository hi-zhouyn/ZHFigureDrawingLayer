//
//  ZHDrawingTrapezoidLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingTrapezoidLayer.h"

@implementation ZHDrawingTrapezoidLayer

//梯形
-(void)movePathWithEndPoint:(CGPoint)endPoint{
    
    self.endPoint = endPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width = endPoint.x-self.startPoint.x;
    
    [path moveToPoint:CGPointMake(width/4*1+self.startPoint.x, self.startPoint.y)];
    [path addLineToPoint:CGPointMake(width/4*3+self.startPoint.x, self.startPoint.y)];
    [path addLineToPoint:endPoint];
    [path addLineToPoint:CGPointMake(self.startPoint.x, endPoint.y)];
    [path addLineToPoint:CGPointMake(width/4*1+self.startPoint.x, self.startPoint.y)];
    
    self.path = path.CGPath;
}

@end
