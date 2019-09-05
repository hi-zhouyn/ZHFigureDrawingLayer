//
//  ZHDrawingAxisLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingAxisLayer.h"

@implementation ZHDrawingAxisLayer

//绘制坐标系
-(void)movePathWithEndPoint:(CGPoint)endPoint
{
    self.endPoint = endPoint;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint vStartPoint = CGPointZero;
    CGPoint hStartPoint = CGPointZero;
    CGPoint vEndPoint = CGPointZero;
    CGPoint hEndPoint = CGPointZero;
    CGFloat midX = fabs((endPoint.x + self.startPoint.x)/2);
    CGFloat midY = fabs((endPoint.y + self.startPoint.y)/2);
    CGFloat scaleWidth = 30;//刻度
    if (endPoint.x > self.startPoint.x) {
        
        if (endPoint.y > self.startPoint.y) {
            vStartPoint = CGPointMake(midX, endPoint.y);
            vEndPoint = CGPointMake(midX , self.startPoint.y);
            hStartPoint = CGPointMake(self.startPoint.x, midY);
            hEndPoint = CGPointMake(endPoint.x, midY);
        }else{
            vStartPoint = CGPointMake(midX, self.startPoint.y);
            vEndPoint = CGPointMake(midX , endPoint.y);
            hStartPoint = CGPointMake(self.startPoint.x, midY);
            hEndPoint = CGPointMake(endPoint.x, midY);
        }
    }else{
        if (endPoint.y > self.startPoint.y) {
            vStartPoint = CGPointMake(midX, endPoint.y);
            vEndPoint = CGPointMake(midX, self.startPoint.y);
            hStartPoint = CGPointMake(endPoint.x, midY);
            hEndPoint = CGPointMake(self.startPoint.x, midY);
        }else{
            vStartPoint = CGPointMake(midX, self.startPoint.y);
            vEndPoint = CGPointMake(midX, endPoint.y);
            hStartPoint = CGPointMake(endPoint.x, midY);
            hEndPoint = CGPointMake(self.startPoint.x, midY);
        }
    }
    
    [path moveToPoint:vStartPoint];
    [path addLineToPoint:vEndPoint];
    
    [path moveToPoint:hStartPoint];
    [path addLineToPoint:hEndPoint];
    
    
    for (int i = 0; i < fabs(hEndPoint.x - hStartPoint.x - 10)/2/scaleWidth; i ++) {
        if (!i) {
            continue;
        }
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(midX + i * scaleWidth, hEndPoint.y )];
        [bezierPath addLineToPoint:CGPointMake(midX + i * scaleWidth, hEndPoint.y - 3)];
        [bezierPath moveToPoint:CGPointMake(midX - i * scaleWidth, hEndPoint.y )];
        [bezierPath addLineToPoint:CGPointMake(midX - i * scaleWidth, hEndPoint.y - 3)];
        [path appendPath:bezierPath];
    }
    
    for (int i = 0; i < fabs(vEndPoint.y - vStartPoint.y + 10)/2/scaleWidth; i ++) {
        if (!i) {
            continue;
        }
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(vEndPoint.x, midY + i * scaleWidth)];
        [bezierPath addLineToPoint:CGPointMake(vEndPoint.x + 3,midY + i * scaleWidth)];
        [bezierPath moveToPoint:CGPointMake(vEndPoint.x ,midY - i * scaleWidth)];
        [bezierPath addLineToPoint:CGPointMake(vEndPoint.x + 3,midY - i * scaleWidth)];
        [path appendPath:bezierPath];
    }
    
    [path appendPath:[self createArrowWithStartPoint:vStartPoint endPoint:vEndPoint]];
    [path appendPath:[self createArrowWithStartPoint:hStartPoint endPoint:hEndPoint]];
    
    self.path = path.CGPath;
}

@end
