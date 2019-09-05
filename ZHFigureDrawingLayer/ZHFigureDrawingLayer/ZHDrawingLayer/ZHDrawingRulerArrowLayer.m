//
//  ZHDrawingRulerArrowLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingRulerArrowLayer.h"

@implementation ZHDrawingRulerArrowLayer

//双箭头直线
- (void)movePathWithEndPoint:(CGPoint)endPoint{
    
    self.endPoint = endPoint;
    
    CGFloat length = 0;
    CGFloat angle = [self angleWithFirstPoint:self.startPoint andSecondPoint:endPoint];
    CGPoint pointMiddle = CGPointMake((self.startPoint.x+endPoint.x)/2, (self.startPoint.y+endPoint.y)/2);
    CGFloat offsetX = length*cos(angle);
    CGFloat offsetY = length*sin(angle);
    CGPoint pointMiddle1 = CGPointMake(pointMiddle.x-offsetX, pointMiddle.y-offsetY);
    CGPoint pointMiddle2 = CGPointMake(pointMiddle.x+offsetX, pointMiddle.y+offsetY);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:pointMiddle1];
    [path moveToPoint:pointMiddle2];
    [path addLineToPoint:endPoint];
    [path appendPath:[self createArrowWithStartPoint:pointMiddle1 endPoint:self.startPoint]];
    [path appendPath:[self createArrowWithStartPoint:pointMiddle2 endPoint:endPoint]];
    
    [self setPath:path.CGPath];
}


@end
