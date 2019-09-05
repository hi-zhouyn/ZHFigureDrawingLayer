//
//  ZHDrawingPentagonLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingPentagonLayer.h"

@implementation ZHDrawingPentagonLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.edgeNumber = 5;//指定为5边形
    }
    return self;
}

@end
