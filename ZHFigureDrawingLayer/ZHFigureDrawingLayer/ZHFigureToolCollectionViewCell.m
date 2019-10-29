//
//  ZHFigureToolCollectionViewCell.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/10/16.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHFigureToolCollectionViewCell.h"

@implementation ZHFigureToolCollectionViewCell

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (UIImageView *)toolImageView
{
    if (!_toolImageView) {
        _toolImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _toolImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_toolImageView];
        [_toolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return _toolImageView;
}

@end
