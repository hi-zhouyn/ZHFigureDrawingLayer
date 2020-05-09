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
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    
    self.path = path.CGPath;
}

@end
