//
//  ZHDrawingRegularPolygonLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingRegularPolygonLayer.h"

@implementation ZHDrawingRegularPolygonLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.edgeNumber = 3;//最小为正三角形
    }
    return self;
}

//绘制指定多边形
- (void)movePathWithEndPoint:(CGPoint)endPoint
{
    CGFloat radius;
    CGFloat angle = [self angleWithFirstPoint:self.startPoint andSecondPoint:endPoint];
    radius = fabs(endPoint.y - self.startPoint.y)/sin(angle);
    UIBezierPath *path = [UIBezierPath bezierPath];
    BOOL firstPoint = YES;
    
    for (CGFloat angle = self.edgeNumber%2*(-M_PI_2) ; angle <= (2+self.edgeNumber%2*0.5)*M_PI; angle += 2*M_PI/self.edgeNumber) {
        
        CGFloat x = self.startPoint.x + radius * cos(angle);
        CGFloat y = self.startPoint.y + radius * sin(angle);
        CGPoint point = CGPointMake(x, y);
        if (CGRectContainsPoint(CGRectMake(0, 0, self.paintSize.width, self.paintSize.height), point)) {
            if (firstPoint) {
                [path moveToPoint:point];
            }else{
                [path addLineToPoint:point];
            }
            firstPoint = NO;
        }else{
            return;
        }
    }
    self.path = path.CGPath;
    self.endPoint = endPoint;
}

@end
