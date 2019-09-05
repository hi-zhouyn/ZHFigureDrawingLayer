//
//  ZHDrawingCircleLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingCircleLayer.h"

@implementation ZHDrawingCircleLayer

//圆
- (void)movePathWithEndPoint:(CGPoint)endPoint{
    
    self.endPoint = endPoint;
    
    CGPoint centerPoint = self.startPoint;
    CGFloat radius = [self distanceBetweenStartPoint:centerPoint endPoint:endPoint];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    
    self.path = path.CGPath;
}

@end
