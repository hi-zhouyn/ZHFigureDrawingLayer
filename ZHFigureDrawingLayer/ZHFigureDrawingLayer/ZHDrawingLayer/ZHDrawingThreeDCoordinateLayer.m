//
//  ZHDrawingThreeDCoordinateLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingThreeDCoordinateLayer.h"

@implementation ZHDrawingThreeDCoordinateLayer

//绘制三维坐标
-(void)movePathWithEndPoint:(CGPoint)endPoint
{
    self.endPoint = endPoint;
    
    CGFloat angle = [self angleWithFirstPoint:self.startPoint andSecondPoint:endPoint];
    CGFloat width = fabs(endPoint.x - self.startPoint.x)*7/10 ;
    CGFloat zx = width + self.startPoint.x;
    CGFloat zy = self.startPoint.y - width * fabs(tan(angle));
    //增加边界控制
    CGRect paintRect = CGRectMake(0, 0, self.paintSize.width, self.paintSize.height);
    if (!CGRectContainsPoint(paintRect, CGPointMake(zx, zy))){
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:CGPointMake(endPoint.x, self.startPoint.y)];
    
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:CGPointMake(self.startPoint.x, endPoint.y)];
    
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:CGPointMake(zx,zy)];
    
    CGFloat scaleWidth = 30;//刻度
    NSInteger hWidth = 0;
    NSInteger hMinusWith = 0;
    
    if (endPoint.x > self.startPoint.x) {
        hWidth = scaleWidth;
        hMinusWith = -10;
    }else{
        hWidth = -scaleWidth;
        hMinusWith = 10;
    }
    for (int i = 0; i < fabs(endPoint.x - self.startPoint.x + hMinusWith)/scaleWidth; i ++) {
        if (!i) {
            continue;
        }
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(self.startPoint.x + i * hWidth, self.startPoint.y )];
        [bezierPath addLineToPoint:CGPointMake(self.startPoint.x + i * hWidth, self.startPoint.y - 3)];
        [path appendPath:bezierPath];
    }
    
    NSInteger vWidth = 0;
    NSInteger vMinusWith = 0;
    if (endPoint.y > self.startPoint.y) {
        vWidth = scaleWidth;
        vMinusWith = -10;
    }else{
        vWidth = -scaleWidth;
        vMinusWith = 10;
    }
    for (int i = 0; i < fabs(endPoint.y - self.startPoint.y + vMinusWith)/scaleWidth; i ++) {
        if (!i) {
            continue;
        }
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(self.startPoint.x, self.startPoint.y + i * vWidth)];
        [bezierPath addLineToPoint:CGPointMake(self.startPoint.x + 3,self.startPoint.y + i * vWidth)];
        [path appendPath:bezierPath];
    }
    
    NSInteger zWidth = scaleWidth;
    NSInteger zMinusWith = 0;
    if (endPoint.x > self.startPoint.x) {
        zMinusWith = -10;
    }else{
        zMinusWith = 10;
    }
    for (int i = 0; i < fabs(width/cos(angle) + zMinusWith)/scaleWidth; i ++) {
        if (!i) {
            continue;
        }
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        
        [bezierPath moveToPoint:CGPointMake(self.startPoint.x + i * zWidth * fabs(cos(angle)), self.startPoint.y - i * zWidth * fabs(sin(angle)))];
        [bezierPath addLineToPoint:CGPointMake(self.startPoint.x + i * zWidth* fabs(cos(angle)) - 3 * fabs(sin(angle)), self.startPoint.y - i * zWidth * fabs(sin(angle)) - 3 * fabs(cos(angle)))];
        [path appendPath:bezierPath];
    }
    
    [path appendPath:[self createArrowWithStartPoint:self.startPoint endPoint:CGPointMake(endPoint.x, self.startPoint.y)]];
    [path appendPath:[self createArrowWithStartPoint:self.startPoint endPoint:CGPointMake(self.startPoint.x, endPoint.y)]];
    [path appendPath:[self createArrowWithStartPoint:self.startPoint endPoint:CGPointMake(zx,zy)]];
    
    self.path = path.CGPath;
}

@end
