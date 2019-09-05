//
//  ZHDrawingArcLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingArcLayer.h"

@implementation ZHDrawingArcLayer

//圆弧
-(void)movePathWithEndPoint:(CGPoint)endPoint{
    
    self.endPoint = endPoint;
    
    CGPoint centerPoint = self.startPoint;
    CGFloat radius = [self distanceBetweenStartPoint:centerPoint endPoint:endPoint];
    CGFloat angle = [self angleWithFirstPoint:centerPoint andSecondPoint:endPoint];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:0 endAngle:angle clockwise:NO];
    
    self.path = path.CGPath;
}

@end
