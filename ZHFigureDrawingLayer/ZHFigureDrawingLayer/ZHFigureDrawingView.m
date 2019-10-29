//
//  ZHFigureDrawingView.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/5.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHFigureDrawingView.h"
#import "ZHFigureDrawingToolView.h"
#import "Masonry.h"

@interface ZHFigureDrawingView ()
@property (nonatomic, assign) BOOL isFirstTouch;//区分点击与滑动手势
@property (nonatomic, strong) ZHFigureDrawingLayer *drawingLayer;
@property (nonatomic, assign) ZHFigureDrawingType drawingType;
@property (nonatomic, strong) UIColor *lineColor;//画笔颜色
@property (nonatomic, assign) NSUInteger figureIndex;
@property (nonatomic, assign) NSUInteger colorIndex;
@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) NSMutableArray *layerArr;
@end

@implementation ZHFigureDrawingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.layerArr = [NSMutableArray array];
        self.drawingType = ZHFigureDrawingTypeGraffiti;
        self.lineColor = [UIColor blackColor];
        [self menuButton];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isFirstTouch = YES;
    if (self.drawingLayer) {
        [self.layerArr addObject:self.drawingLayer];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];
    if (self.isFirstTouch) {
        self.drawingLayer = [ZHFigureDrawingLayer createLayerWithStartPoint:previousPoint type:self.drawingType];
        self.drawingLayer.paintSize = self.frame.size;
        self.drawingLayer.drawingType = self.drawingType;
        self.drawingLayer.lineColor = self.lineColor;
        [self.layer addSublayer:self.drawingLayer];
    }else {
        [self.drawingLayer movePathWithEndPoint:currentPoint];
    }
    self.isFirstTouch = NO;
}

//菜单
- (void)menuButtonClick:(UIButton *)sender
{
    ZHFigureDrawingToolView *toolView = [[ZHFigureDrawingToolView alloc] init];
    toolView.figureIndex = self.figureIndex;
    toolView.colorIndex = self.colorIndex;
    __weak __typeof(&*self)weakSelf = self;
    toolView.toolBlock = ^(ZHFigureDrawingToolView *toolView, NSInteger selType, NSInteger drawingType, UIColor * _Nullable color) {
        __strong __typeof(&*self)strongSelf = weakSelf;
        strongSelf.figureIndex = toolView.figureIndex;
        strongSelf.colorIndex = toolView.colorIndex;
        if (selType == 0) {
            strongSelf.drawingType = drawingType;
        }else if (selType == 1) {
            strongSelf.lineColor = color;
        }else if (selType == 2) {
            [strongSelf removeAllLayerDrawing];
        }
    };
    [toolView showInView:self];
}

- (void)removeAllLayerDrawing
{
    [self.drawingLayer removeFromSuperlayer];
    for (ZHFigureDrawingLayer *drawingLayer in self.layerArr) {
        [drawingLayer removeFromSuperlayer];
    }
    [self.layerArr removeAllObjects];
}

- (UIButton *)menuButton
{
    if (!_menuButton) {
        _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        _menuButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _menuButton.layer.masksToBounds = YES;
        _menuButton.layer.cornerRadius = 20.f;
        [_menuButton addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_menuButton];
        [_menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self).offset(-30);
            make.width.height.mas_equalTo(40);
        }];
    }
    return _menuButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
