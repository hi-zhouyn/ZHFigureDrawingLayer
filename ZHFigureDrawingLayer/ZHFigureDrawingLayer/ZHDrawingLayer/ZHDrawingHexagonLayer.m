//
//  ZHDrawingHexagonLayer.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/9/4.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHDrawingHexagonLayer.h"

@implementation ZHDrawingHexagonLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.edgeNumber = 6;//指定为6边形
    }
    return self;
}

@end
