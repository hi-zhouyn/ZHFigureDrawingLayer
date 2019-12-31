# ZHFigureDrawingLayer
![ZHFigureDrawingLayer](/Image/show.gif)
![ZHFigureDrawingLayer](/Image/IMG_3989.PNG)
## 文档
[简书文档](https://www.jianshu.com/p/5d9df9cc1a4d)
## 简介
ZHFigureDrawingLayer一款图形白板绘制工具，支持以下多种数学图形绘制。支持线条颜色、粗细等基本功能设置，新增支持撤销、还原、删除还原操作等功能。

```
typedef enum : NSUInteger {
    ZHFigureDrawingTypeGraffiti = 1,        //涂鸦
    ZHFigureDrawingTypeArrow,               //单箭头
    ZHFigureDrawingTypeLine,                //直线
    ZHFigureDrawingTypeDottedline,          //虚线
    ZHFigureDrawingTypeRulerArrow,          //双箭头直线
    ZHFigureDrawingTypeRulerLine,           //双杠直线
    ZHFigureDrawingTypeOval,                //椭圆
    ZHFigureDrawingTypeCircle,              //圆形
    ZHFigureDrawingTypeRect,                //矩形
    ZHFigureDrawingTypeTriangle,            //三角形
    ZHFigureDrawingTypeArc,                 //圆弧
    ZHFigureDrawingTypeCosine,              //正余弦
    ZHFigureDrawingTypeTrapezoid,           //梯形
    ZHFigureDrawingTypeRhombus,             //菱形
    ZHFigureDrawingTypePentagon,            //五边形
    ZHFigureDrawingTypeHexagon,             //六边形
    ZHFigureDrawingTypeAxis,                //坐标系
    ZHFigureDrawingTypeRighTangle,          //直角坐标系
    ZHFigureDrawingTypeThreeDCoordinate,    //三维坐标系
    ZHFigureDrawingTypeSphere,              //球体
    ZHFigureDrawingTypeTriangularPyramid,   //三菱锥
    ZHFigureDrawingTypeCone,                //圆锥
    ZHFigureDrawingTypeCylinder,            //圆柱
    ZHFigureDrawingTypeCuboid,              //立方体
} ZHFigureDrawingType;
```

## 方法定义
```
/**
 初始化
 @param startPoint      开始点
 @param type            图形类型
 */
+ (instancetype)createLayerWithStartPoint:(CGPoint)startPoint type:(ZHFigureDrawingType)type;

@property (nonatomic, assign) ZHFigureDrawingType drawingType;   //图形类型
@property (nonatomic, strong) NSMutableArray *pointArray;        //记录图形绘制点
@property (nonatomic, assign) CGPoint startPoint;                //起始坐标
@property (nonatomic, assign) CGPoint endPoint;                  //终点坐标
@property (nonatomic, strong) UIColor *lineColor;                //画笔颜色（默认黑色）
@property (nonatomic, assign) CGSize paintSize;                  //画布大小
@property (nonatomic, assign) CGFloat layerLineWidth;            //线宽（1~20,默认2）

- (void)movePathWithStartPoint:(CGPoint)startPoint;
- (void)movePathWithEndPoint:(CGPoint)endPoint;

- (UIBezierPath *)createArrowWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
- (CGFloat)distanceBetweenStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
- (CGFloat)angleWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint;
- (CGFloat)angleEndWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint;
```
## 意见建议
如果感觉此项目对你有帮助，欢迎Star！如果使用过程中遇到问题或者有更好的建议,欢迎在Issues提出！
## 更新记录
* 2019-12-09 增加线宽设置（layerLineWidth，1~20,默认2）
* 2019-12-02 增加撤销、还原、删除还原功能
