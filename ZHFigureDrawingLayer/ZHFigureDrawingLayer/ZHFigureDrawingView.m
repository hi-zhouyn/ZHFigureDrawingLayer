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
@property (nonatomic, strong) UIButton *nextStepButton;
@property (nonatomic, strong) UIButton *previousStepButton;
@property (nonatomic, strong) UIButton *rotateButton;
@property (nonatomic, strong) NSMutableArray *layerArr;
@property (nonatomic, strong) NSMutableArray *previousLayerArr;
@property (nonatomic, strong) NSMutableArray *removeLayerArr;
@end

@implementation ZHFigureDrawingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.previousLayerArr = [NSMutableArray array];
        self.layerArr = [NSMutableArray array];
        self.removeLayerArr = [NSMutableArray array];
        self.drawingType = ZHFigureDrawingTypeGraffiti;
        self.lineColor = [UIColor blackColor];
        [self setButtonCanTouch:0 enable:NO];
        [self setButtonCanTouch:1 enable:NO];
        [self setButtonCanTouch:2 enable:NO];
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
        self.drawingLayer.paintSize = self.frame.size;
        self.drawingLayer.drawingType = self.drawingType;
        self.drawingLayer.lineColor = self.lineColor;
//        self.drawingLayer.layerLineWidth = 4.f;
        [self.layer addSublayer:self.drawingLayer];
    }else {
        [self.drawingLayer movePathWithEndPoint:currentPoint];
    }
    self.isFirstTouch = NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    if (self.drawingLayer && !self.isFirstTouch) {
        [self.layerArr addObject:self.drawingLayer];
        [self.previousLayerArr removeAllObjects];
        [self setButtonCanTouch:0 enable:NO];
        [self setButtonCanTouch:1 enable:YES];
        [self.removeLayerArr removeAllObjects];
        [self setButtonCanTouch:2 enable:NO];
    }
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

//前进一步
- (void)nextStepButtonClick:(UIButton *)sender
{
    if (!sender.selected) {
        return;
    }
    if (!self.previousLayerArr.count) {
        [self setButtonCanTouch:0 enable:NO];
        return;
    }
    ZHFigureDrawingLayer *drawingLayer = [self.previousLayerArr lastObject];
    [self.layerArr addObject:drawingLayer];
    [self.layer addSublayer:drawingLayer];
    [self.previousLayerArr removeObject:drawingLayer];
    [self setButtonCanTouch:0 enable:self.self.previousLayerArr.count?YES:NO];
    [self setButtonCanTouch:1 enable:YES];
}

//撤销一步
- (void)previousStepButtonClick:(UIButton *)sender
{
    if (!sender.selected) {
        return;
    }
    if (!self.layerArr.count) {
        [self setButtonCanTouch:1 enable:NO];
        return;
    }
    ZHFigureDrawingLayer *drawingLayer = [self.layerArr lastObject];
    [self.previousLayerArr addObject:drawingLayer];
    [self.layerArr removeObject:drawingLayer];
    [drawingLayer removeFromSuperlayer];
    [self setButtonCanTouch:0 enable:YES];
    [self setButtonCanTouch:1 enable:self.layerArr.count?YES:NO];
}

//清除所有
- (void)removeAllLayerDrawing
{
    if (!self.layerArr.count) {
        return;
    }
    for (ZHFigureDrawingLayer *drawingLayer in self.layerArr) {
        [self.removeLayerArr addObject:drawingLayer];
        [drawingLayer removeFromSuperlayer];
    }
    [self.previousLayerArr removeAllObjects];
    [self.layerArr removeAllObjects];
    [self setButtonCanTouch:0 enable:NO];
    [self setButtonCanTouch:1 enable:NO];
    [self setButtonCanTouch:2 enable:YES];
}

//还原所有
- (void)rotateButtonClick:(UIButton *)sender
{
    if (!sender.selected) {
        return;
    }
    for (ZHFigureDrawingLayer *drawingLayer in self.removeLayerArr) {
        [self.layer addSublayer:drawingLayer];
    }
    [self.layerArr addObjectsFromArray:self.removeLayerArr];
    [self.removeLayerArr removeAllObjects];
    [self setButtonCanTouch:1 enable:YES];
    [self setButtonCanTouch:2 enable:NO];
}

- (void)setButtonCanTouch:(NSInteger)tag enable:(BOOL)enable
{
    if (tag == 0) {
        self.nextStepButton.selected = enable;
        self.nextStepButton.alpha = enable ? 1 : 0.5;
    } else if (tag == 1) {
        self.previousStepButton.selected = enable;
        self.previousStepButton.alpha = enable ? 1 : 0.5;
    } else if (tag == 2) {
        self.rotateButton.selected = enable;
        self.rotateButton.alpha = enable ? 1 : 0.5;
    }
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
            make.bottom.equalTo(self.previousStepButton.mas_top).offset(-20);
            make.centerX.width.height.equalTo(self.previousStepButton);
        }];
    }
    return _menuButton;
}

- (UIButton *)nextStepButton
{
    if (!_nextStepButton) {
        _nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStepButton setImage:[UIImage imageNamed:@"class_nextstep2"] forState:UIControlStateNormal];
        _nextStepButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _nextStepButton.layer.masksToBounds = YES;
        _nextStepButton.layer.cornerRadius = 20.f;
        [_nextStepButton addTarget:self action:@selector(nextStepButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nextStepButton];
        [_nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.menuButton.mas_top).offset(-20);
            make.centerX.width.height.equalTo(self.previousStepButton);
        }];
    }
    return _nextStepButton;
}

- (UIButton *)previousStepButton
{
    if (!_previousStepButton) {
        _previousStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_previousStepButton setImage:[UIImage imageNamed:@"class_previousstep2"] forState:UIControlStateNormal];
        _previousStepButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _previousStepButton.layer.masksToBounds = YES;
        _previousStepButton.layer.cornerRadius = 20.f;
        [_previousStepButton addTarget:self action:@selector(previousStepButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_previousStepButton];
        [_previousStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.rotateButton.mas_top).offset(-20);
            make.right.equalTo(self).offset(-30);
            make.width.height.mas_equalTo(40);
        }];
    }
    return _previousStepButton;
}

- (UIButton *)rotateButton
{
    if (!_rotateButton) {
        _rotateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rotateButton setImage:[UIImage imageNamed:@"class_rotate"] forState:UIControlStateNormal];
        _rotateButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _rotateButton.layer.masksToBounds = YES;
        _rotateButton.layer.cornerRadius = 20.f;
        [_rotateButton addTarget:self action:@selector(rotateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rotateButton];
        [_rotateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-30);
            make.right.equalTo(self).offset(-30);
            make.width.height.mas_equalTo(40);
        }];
    }
    return _rotateButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
