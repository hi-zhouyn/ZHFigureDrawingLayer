//
//  ZHFigureDrawingLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHFigureDrawingLayer.h"
#import "ZHDrawingGraffitiLayer.h"
#import "ZHDrawingArrowLayer.h"
#import "ZHDrawingLineLayer.h"
#import "ZHDrawingDottedlineLayer.h"
#import "ZHDrawingRulerArrowLayer.h"
#import "ZHDrawingRulerLineLayer.h"
#import "ZHDrawingOvalLayer.h"
#import "ZHDrawingCircleLayer.h"
#import "ZHDrawingRectLayer.h"
#import "ZHDrawingTriangleLayer.h"
#import "ZHDrawingArcLayer.h"
#import "ZHDrawingCosineLayer.h"
#import "ZHDrawingTrapezoidLayer.h"
#import "ZHDrawingRhombusLayer.h"
#import "ZHDrawingRegularPolygonLayer.h"
#import "ZHDrawingPentagonLayer.h"
#import "ZHDrawingHexagonLayer.h"
#import "ZHDrawingAxisLayer.h"
#import "ZHDrawingRighTangleLayer.h"
#import "ZHDrawingThreeDCoordinateLayer.h"
#import "ZHDrawingSphereLayer.h"
#import "ZHDrawingTriangularPyramidLayer.h"
#import "ZHDrawingConeLayer.h"
#import "ZHDrawingCylinderLayer.h"
#import "ZHDrawingCuboidLayer.h"

@implementation ZHFigureDrawingLayer

- (instancetype)init {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.lineJoin = kCALineJoinRound;
        self.lineCap = kCALineCapRound;
        self.strokeColor = [UIColor blackColor].CGColor;
        self.fillColor = [UIColor clearColor].CGColor;
        self.lineWidth = 2;
        self.pointArray = [NSMutableArray array];
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.strokeColor = lineColor.CGColor;
}

- (void)setLayerLineWidth:(CGFloat)layerLineWidth
{
    if (layerLineWidth <= 1) {
        layerLineWidth = 1;
    } else if (layerLineWidth >= 20) {
        layerLineWidth = 20;
    }
    _layerLineWidth = layerLineWidth;
    self.lineWidth = layerLineWidth;
}

+ (instancetype)createLayerWithStartPoint:(CGPoint)startPoint type:(ZHFigureDrawingType)type
{
    ZHFigureDrawingLayer *layer;
    switch (type) {
        case ZHFigureDrawingTypeGraffiti:
            layer = [[ZHDrawingGraffitiLayer alloc] initWithStartPoint:startPoint];
            break;
        case ZHFigureDrawingTypeArrow:
            layer = [[ZHDrawingArrowLayer alloc] init];
            break;
        case ZHFigureDrawingTypeLine:
            layer = [[ZHDrawingLineLayer alloc] init];
            break;
        case ZHFigureDrawingTypeDottedline:
            layer = [[ZHDrawingDottedlineLayer alloc] init];
            break;
        case ZHFigureDrawingTypeRulerArrow:
            layer = [[ZHDrawingRulerArrowLayer alloc] init];
            break;
        case ZHFigureDrawingTypeRulerLine:
            layer = [[ZHDrawingRulerLineLayer alloc] init];
            break;
        case ZHFigureDrawingTypeOval:
            layer = [[ZHDrawingOvalLayer alloc] init];
            break;
        case ZHFigureDrawingTypeCircle:
            layer = [[ZHDrawingCircleLayer alloc] init];
            break;
        case ZHFigureDrawingTypeRect:
            layer = [[ZHDrawingRectLayer alloc] init];
            break;
        case ZHFigureDrawingTypeTriangle:
            layer = [[ZHDrawingTriangleLayer alloc] init];
            break;
        case ZHFigureDrawingTypeArc:
            layer = [[ZHDrawingArcLayer alloc] init];
            break;
        case ZHFigureDrawingTypeCosine:
            layer = [[ZHDrawingCosineLayer alloc] init];
            break;
        case ZHFigureDrawingTypeTrapezoid:
            layer = [[ZHDrawingTrapezoidLayer alloc] init];
            break;
        case ZHFigureDrawingTypeRhombus:
            layer = [[ZHDrawingRhombusLayer alloc] init];
            break;
        case ZHFigureDrawingTypePentagon://五边形
            layer = [[ZHDrawingPentagonLayer alloc] init];
            break;
        case ZHFigureDrawingTypeHexagon://六边形
            layer = [[ZHDrawingHexagonLayer alloc] init];
            break;
        case ZHFigureDrawingTypeAxis:
            layer = [[ZHDrawingAxisLayer alloc] init];
            break;
        case ZHFigureDrawingTypeRighTangle:
            layer = [[ZHDrawingRighTangleLayer alloc] init];
            break;
        case ZHFigureDrawingTypeThreeDCoordinate:
            layer = [[ZHDrawingThreeDCoordinateLayer alloc] init];
            break;
        case ZHFigureDrawingTypeSphere:
            layer = [[ZHDrawingSphereLayer alloc] init];
            break;
        case ZHFigureDrawingTypeTriangularPyramid:
            layer = [[ZHDrawingTriangularPyramidLayer alloc] init];
            break;
        case ZHFigureDrawingTypeCone:
            layer = [[ZHDrawingConeLayer alloc] init];
            break;
        case ZHFigureDrawingTypeCylinder:
            layer = [[ZHDrawingCylinderLayer alloc] init];
            break;
        case ZHFigureDrawingTypeCuboid:
            layer = [[ZHDrawingCuboidLayer alloc] init];
            break;
        default:
            break;
    }
    layer.startPoint = startPoint;
    layer.drawingType = type;
//    layer.paintSize = ;
    return layer;
}

- (void)movePathWithEndPoint:(CGPoint)endPoint {
    
}

- (void)movePathWithStartPoint:(CGPoint)startPoint {
    
}

#pragma mark - 箭头
- (UIBezierPath *)createArrowWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CGPoint controllPoint = CGPointZero;
    CGPoint pointUp = CGPointZero;
    CGPoint pointDown = CGPointZero;
    CGFloat distance = [self distanceBetweenStartPoint:startPoint endPoint:endPoint];
    CGFloat distanceX = 8.0 * (ABS(endPoint.x - startPoint.x) / distance);
    CGFloat distanceY = 8.0 * (ABS(endPoint.y - startPoint.y) / distance);
    CGFloat distX = 4.0 * (ABS(endPoint.y - startPoint.y) / distance);
    CGFloat distY = 4.0 * (ABS(endPoint.x - startPoint.x) / distance);
    if (endPoint.x >= startPoint.x)
    {
        if (endPoint.y >= startPoint.y)
        {
            controllPoint = CGPointMake(endPoint.x - distanceX, endPoint.y - distanceY);
            pointUp = CGPointMake(controllPoint.x + distX, controllPoint.y - distY);
            pointDown = CGPointMake(controllPoint.x - distX, controllPoint.y + distY);
        }
        else
        {
            controllPoint = CGPointMake(endPoint.x - distanceX, endPoint.y + distanceY);
            pointUp = CGPointMake(controllPoint.x - distX, controllPoint.y - distY);
            pointDown = CGPointMake(controllPoint.x + distX, controllPoint.y + distY);
        }
    }
    else
    {
        if (endPoint.y >= startPoint.y)
        {
            controllPoint = CGPointMake(endPoint.x + distanceX, endPoint.y - distanceY);
            pointUp = CGPointMake(controllPoint.x - distX, controllPoint.y - distY);
            pointDown = CGPointMake(controllPoint.x + distX, controllPoint.y + distY);
        }
        else
        {
            controllPoint = CGPointMake(endPoint.x + distanceX, endPoint.y + distanceY);
            pointUp = CGPointMake(controllPoint.x + distX, controllPoint.y - distY);
            pointDown = CGPointMake(controllPoint.x - distX, controllPoint.y + distY);
        }
    }
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    [arrowPath moveToPoint:endPoint];
    [arrowPath addLineToPoint:pointDown];
    [arrowPath addLineToPoint:pointUp];
    [arrowPath addLineToPoint:endPoint];
    return arrowPath;
}

- (CGFloat)distanceBetweenStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CGFloat xDist = (endPoint.x - startPoint.x);
    CGFloat yDist = (endPoint.y - startPoint.y);
    return sqrt((xDist * xDist) + (yDist * yDist));
}

- (CGFloat)angleWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint
{
    CGFloat dx = secondPoint.x - firstPoint.x;
    CGFloat dy = secondPoint.y - firstPoint.y;
    CGFloat angle = atan2f(dy, dx);
    return angle;
}

- (CGFloat)angleEndWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint
{
    CGFloat dx = secondPoint.x - firstPoint.x;
    CGFloat dy = secondPoint.y - firstPoint.y;
    CGFloat angle = atan2f(fabs(dy), fabs(dx));
    if (dx*dy>0) {
        return M_PI-angle;
    }
    return angle;
}

@end
