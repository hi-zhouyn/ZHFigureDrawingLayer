//
//  ZHDrawingGraffitiLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingGraffitiLayer.h"

//涂鸦
@implementation ZHDrawingGraffitiLayer

- (instancetype)initWithStartPoint:(CGPoint)startPoint
{
    self = [super init];
    if (self) {
        [self.pointArray addObject:[NSValue valueWithCGPoint:startPoint]];
        self.path = [UIBezierPath bezierPath].CGPath;
    }
    return self;
}

- (void)movePathWithEndPoint:(CGPoint)endPoint
{
    self.endPoint = endPoint;
    self.startPoint = ((NSValue*)self.pointArray.lastObject).CGPointValue;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.path];
    [path moveToPoint:((NSValue*)self.pointArray.lastObject).CGPointValue];
    [path addLineToPoint:endPoint];
    self.path = path.CGPath;
    
    [self.pointArray addObject:[NSValue valueWithCGPoint:endPoint]];
}

@end
