//
//  ZHFigureDrawingToolView.m
//  ZHFigureDrawingLayer
//
//  Created by 周亚楠 on 2019/10/16.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHFigureDrawingToolView.h"
#import "ZHFigureToolCollectionViewCell.h"

@interface ZHFigureDrawingToolView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *toolCollectionView;
@property (nonatomic, strong) UIButton *cleanButton;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ZHFigureDrawingToolView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        [self toolCollectionView];
    }
    return self;
}


- (void)showInView:(UIView *)view
{
    if (!view) {
        return;
    }
    CGFloat height = 250;

    self.bgView = [[UIView alloc] init];
    [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)]];
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.f];
    [view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.top.equalTo(view.mas_bottom);
        make.height.mas_equalTo(height);
    }];
    [self.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom).offset(-height);
        }];
        [self.superview layoutIfNeeded];
    }];
}

- (void)hideView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.f];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.superview.mas_bottom);
        }];
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)claeanButtonClick:(UIButton *)sender
{
    if (self.toolBlock) {
        self.toolBlock(self,2, 0, nil);
        [self hideView];
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZHFigureToolCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZHFigureToolCollectionViewCell class]) forIndexPath:indexPath];
    if (!indexPath.section) {
        NSDictionary *dict = self.dataArr[indexPath.section][indexPath.row];
        cell.toolImageView.image = [UIImage imageNamed:dict[@"name"]];
        cell.toolImageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        cell.toolImageView.layer.masksToBounds = YES;
        cell.toolImageView.layer.cornerRadius = self.figureIndex == indexPath.item ? 18 : 15.f;
    } else {
        UIColor *color = self.dataArr[indexPath.section][indexPath.row];
        cell.toolImageView.image = nil;
        cell.toolImageView.backgroundColor = color;
        cell.toolImageView.layer.masksToBounds = YES;
        cell.toolImageView.layer.cornerRadius = self.colorIndex == indexPath.item ? 18 : 15.f;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.toolBlock) {
        if (!indexPath.section) {
            NSDictionary *dict = [self.dataArr firstObject][indexPath.row];
            self.figureIndex = indexPath.item;
            self.toolBlock(self,indexPath.section, [dict[@"tag"] integerValue], nil);
        }else {
            UIColor *color = self.dataArr[indexPath.section][indexPath.row];
            self.colorIndex = indexPath.item;
            self.toolBlock(self,indexPath.section, 0, color);
        }
        [collectionView reloadData];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.section) {
        if (self.figureIndex == indexPath.item) {
            return CGSizeMake(36, 36);
        }else {
            return CGSizeMake(30, 30);
        }
    }else {
        if (self.colorIndex == indexPath.item) {
            return CGSizeMake(36, 36);
        }else {
            return CGSizeMake(30, 30);
        }
    }
}

- (UIImage *)imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma lazy loading

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithObjects:
                    @[@{@"tag":@"1",@"name":@"class_graffiti"},
                      @{@"tag":@"2",@"name":@"class_arrow"},
                      @{@"tag":@"3",@"name":@"class_straightline"},
                      @{@"tag":@"4",@"name":@"class_dottedline"},
                      @{@"tag":@"5",@"name":@"class_rulerarrow"},
                      @{@"tag":@"6",@"name":@"class_rulerline"},
                      @{@"tag":@"7",@"name":@"class_oval"},
                      @{@"tag":@"8",@"name":@"class_circular"},
                      @{@"tag":@"9",@"name":@"class_rectangle"},
                      @{@"tag":@"10",@"name":@"class_triangle"},
                      @{@"tag":@"11",@"name":@"class_arc"},
                      @{@"tag":@"12",@"name":@"class_sinecosine"},
                      @{@"tag":@"13",@"name":@"class_trapezoid"},
                      @{@"tag":@"14",@"name":@"class_diamond"},
                      @{@"tag":@"15",@"name":@"class_pentagon"},
                      @{@"tag":@"16",@"name":@"class_hexagon"},
                      @{@"tag":@"17",@"name":@"class_coordinate"},
                      @{@"tag":@"18",@"name":@"class_cartesiancoordinates"},
                      @{@"tag":@"19",@"name":@"class_threedcoordinate"},
                      @{@"tag":@"20",@"name":@"class_sphere"},
                      @{@"tag":@"21",@"name":@"class_triangularpyramid"},
                      @{@"tag":@"22",@"name":@"class_cone"},
                      @{@"tag":@"23",@"name":@"class_cylinder"},
                      @{@"tag":@"24",@"name":@"class_cuboid"}],
                    @[[UIColor blackColor],
                      [UIColor darkGrayColor],
                      [UIColor lightGrayColor],
                      [UIColor grayColor],
                      [UIColor redColor],
                      [UIColor greenColor],
                      [UIColor blueColor],
                      [UIColor cyanColor],
                      [UIColor yellowColor],
                      [UIColor magentaColor],
                      [UIColor orangeColor],
                      [UIColor purpleColor],
                      [UIColor brownColor]], nil];
        
    }
    return _dataArr;
}

- (UIButton *)cleanButton
{
    if (!_cleanButton) {
        _cleanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cleanButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_cleanButton addTarget:self action:@selector(claeanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _cleanButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _cleanButton.layer.masksToBounds = YES;
        _cleanButton.layer.cornerRadius = 15.f;
        [self addSubview:_cleanButton];
        [_cleanButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-20);
        }];
    }
    return _cleanButton;
}

- (UICollectionView *)toolCollectionView
{
    if (!_toolCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(30, 30);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _toolCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _toolCollectionView.showsVerticalScrollIndicator = NO;
        _toolCollectionView.showsHorizontalScrollIndicator = NO;
        _toolCollectionView.backgroundColor = [UIColor clearColor];
        _toolCollectionView.delegate = self;
        _toolCollectionView.dataSource = self;
        [_toolCollectionView registerClass:[ZHFigureToolCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ZHFigureToolCollectionViewCell class])];
        [self addSubview:_toolCollectionView];
        [_toolCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.bottom.equalTo(self.cleanButton.mas_top).offset(-10);
        }];
    }
    return _toolCollectionView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
