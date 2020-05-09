//
//  ZHDrawingCosineLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingCosineLayer.h"

@implementation ZHDrawingCosineLayer

//正余弦
- (void)movePathWithEndPoint:(CGPoint)endPoint{
    
    self.endPoint = endPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = endPoint.y - self.startPoint.y;
    CGFloat width = endPoint.x - self.startPoint.x;
    [path moveToPoint:self.startPoint];
    
    for (float x = 0.0; x < fabs(endPoint.x - self.startPoint.x); x++)
    {
        float startX;
        if (width > 0) {
            startX = x;
        }else{
            startX = -x;
        }
        float yCosine = sin(x / 50 * M_PI) * height + self.startPoint.y;
        CGPoint cosinePoint = CGPointMake(startX + self.startPoint.x, yCosine);
        //增加边界控制
        CGRect paintRect = CGRectMake(0, 0, self.paintSize.width, self.paintSize.height);
        if (!CGRectContainsPoint(paintRect, cosinePoint)){
            return;
        }
        [path addLineToPoint:cosinePoint];
    }
    
    self.path = path.CGPath;
}

@end
