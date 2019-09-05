//
//  ZHFigureDrawingView.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/5.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHFigureDrawingView.h"

@interface ZHFigureDrawingView ()
@property (nonatomic, assign) BOOL isFirstTouch;//区分点击与滑动手势
@property (nonatomic, strong) ZHFigureDrawingLayer *drawingLayer;//当前
@end

@implementation ZHFigureDrawingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.drawingType = ZHFigureDrawingTypeTriangle;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isFirstTouch = YES;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];
    if (self.isFirstTouch) {
        self.drawingLayer = [ZHFigureDrawingLayer createLayerWithStartPoint:previousPoint type:self.drawingType];
        [self.layer addSublayer:self.drawingLayer];
    }else {
        [self.drawingLayer movePathWithEndPoint:currentPoint];
    }
    self.isFirstTouch = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
