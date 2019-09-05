//
//  ZHDrawingRectLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingRectLayer.h"

@implementation ZHDrawingRectLayer

//矩形
-(void)movePathWithEndPoint:(CGPoint)endPoint{
    
    self.endPoint = endPoint;
    
    CGRect rectToFill = CGRectMake(self.startPoint.x, self.startPoint.y, endPoint.x - self.startPoint.x, endPoint.y - self.startPoint.y);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rectToFill];
    
    self.path = path.CGPath;
}

@end
