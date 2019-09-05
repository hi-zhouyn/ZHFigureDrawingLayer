//
//  ViewController.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ViewController.h"
#import "ZHFigureDrawingView.h"

@interface ViewController ()
@property (nonatomic, strong) ZHFigureDrawingView *drawingView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawingView];
}

- (ZHFigureDrawingView *)drawingView
{
    if (!_drawingView) {
        _drawingView = [[ZHFigureDrawingView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_drawingView];
    }
    return _drawingView;
}

@end
