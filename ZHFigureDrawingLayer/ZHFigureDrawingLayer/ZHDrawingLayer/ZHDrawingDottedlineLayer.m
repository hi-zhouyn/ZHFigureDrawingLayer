//
//  ZHDrawingDottedlineLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingDottedlineLayer.h"

@implementation ZHDrawingDottedlineLayer

//绘制虚线
- (void)movePathWithEndPoint:(CGPoint)endPoint{
    
    self.endPoint = endPoint;
    
    [self setLineDashPattern: [NSArray arrayWithObjects:
                               [NSNumber numberWithInt:10],
                               [NSNumber numberWithInt:5],
                               nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.startPoint.x, self.startPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:path];
    
    self.path = bezierPath.CGPath;
    CGPathRelease(path);
}

@end
