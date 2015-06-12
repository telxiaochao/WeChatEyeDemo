//
//  XCPathAnimationControl.m
//  WeChatEyeDemo
//
//  Created by 58 on 15/6/11.
//  Copyright (c) 2015年 58. All rights reserved.
//

#import "XCPathAnimationControl.h"
static const float indexY = 145;
static  float indexX ;
@interface XCPathAnimationControl()
/** The layer that is animated as the user pulls down */
@property (strong) CAShapeLayer *pullToRefreshShape;

/** The layer that is animated as the user pulls down */
@property (strong) CAShapeLayer *pullToRefreshShape1;
@property (strong) CAShapeLayer *pullToRefreshShape2;
@property (strong) CAShapeLayer *pullToRefreshShape3;

/** The layer that is animated as the app is loading more data */
@property (strong) CAShapeLayer *loadingShape;


/** A view that contain both the pull to refresh and loading layers */
@property (strong) UIView *loadingIndicator;
@end
@implementation XCPathAnimationControl
- (instancetype)init
{
    self = [super initWithThreshold:70 height:70 animationView:nil];
    if (self) {
        indexX = (CGRectGetWidth([[UIScreen mainScreen] bounds])/2)-125 ;
        [self setupLoadingIndicator];
        self.animationView = _loadingIndicator;
        __weak XCPathAnimationControl *weakSelf = self;
        
        [weakSelf.pullToRefreshShape addAnimation:[weakSelf pullDownAnimation]
                                           forKey:@"Write 'Load' as you drag down"];
        [weakSelf.pullToRefreshShape1 addAnimation:[weakSelf pullDownAnimation]
                                            forKey:@"Write 'Load' as you drag down"];
        [weakSelf.pullToRefreshShape2 addAnimation:[weakSelf pullDownAnimation]
                                            forKey:@"Write 'Load' as you drag down"];
        [weakSelf.pullToRefreshShape3 addAnimation:[weakSelf pullDownAnimation]
                                            forKey:@"Write 'Load' as you drag down"];
        
        self.userIsDraggingAnimation = ^(CGFloat fractionDragged){
            weakSelf.pullToRefreshShape.timeOffset = fractionDragged;
            weakSelf.pullToRefreshShape1.timeOffset = fractionDragged;
            weakSelf.pullToRefreshShape2.timeOffset = fractionDragged;
            weakSelf.pullToRefreshShape3.timeOffset = fractionDragged;
            
        };
        
        
        self.thresholdReachedAnimation = ^(){
            [weakSelf.loadingShape addAnimation:[weakSelf circleAnimation]
                                         forKey:@"Write that word"];
        };
        
        self.disappearingAnimation = ^(){
            weakSelf.pullToRefreshShape.timeOffset = 0;
            weakSelf.pullToRefreshShape1.timeOffset = 0;
            weakSelf.pullToRefreshShape2.timeOffset = 0;
            weakSelf.pullToRefreshShape3.timeOffset = 0;
            [weakSelf.loadingShape removeAllAnimations];
        };
        self.disappearingTimeInterval = 0.3;
    }
    return self;
}

- (void)setupLoadingIndicator
{
    CAShapeLayer *topRightShape = [CAShapeLayer layer];
    topRightShape.path = [self loadTopRightOneHalfPath];
    
    CAShapeLayer *topLeftShape = [CAShapeLayer layer];
    topLeftShape.path = [self loadTopLeftOneHalfPath];
    
    CAShapeLayer *loadShape2 = [CAShapeLayer layer];
    loadShape2.path = [self loadButtonLeftOneHalfPath];
    
    CAShapeLayer *loadShape3 = [CAShapeLayer layer];
    loadShape3.path = [self loadButtonRightOneHalfPath];
    
    CAShapeLayer *ingShape  = [CAShapeLayer layer];
    ingShape.path  = [self circlePath];
    
    UIView *loadingIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, -45, 230, 70)];
    self.loadingIndicator = loadingIndicator;
    self.loadingIndicator.backgroundColor = [UIColor clearColor];
    for (CAShapeLayer *shape in @[topRightShape, ingShape,topLeftShape,loadShape2,loadShape3 ]) {
        shape.strokeColor = [UIColor grayColor].CGColor;// 边缘线的颜色
        shape.fillColor   = [UIColor clearColor].CGColor;// 闭环填充的颜色

        shape.lineCap   = kCALineCapRound;
        shape.lineJoin  = kCALineJoinRound;
        shape.lineWidth = 0.8;
        shape.position = CGPointMake(75, 0);
        
        shape.strokeEnd = .0;
        
        [loadingIndicator.layer addSublayer:shape];
    }
    
    topRightShape.speed = 0; // pull to refresh layer is paused here
    topLeftShape.speed = 0; // pull to refresh layer is paused here
    loadShape2.speed = 0; // pull to refresh layer is paused here
    loadShape3.speed = 0; // pull to refresh layer is paused here
//    ingShape.speed = 10;
    self.pullToRefreshShape = topRightShape;
    self.pullToRefreshShape1 = topLeftShape;
    self.pullToRefreshShape2 = loadShape2;
    self.pullToRefreshShape3 = loadShape3;
    self.loadingShape       = ingShape;
}

/**
 This is the animation that is controlled using timeOffset when the user pulls down
 */
- (CAAnimation *)pullDownAnimation
{

    CABasicAnimation *writeText = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    writeText.fromValue = @0;
    writeText.toValue = @1;
    
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position.y"];
    move.byValue = @(-22);
    move.toValue = @0;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1.0;
    group.animations = @[writeText, move];
    
    return group;
}

/**
 The loading animation is quickly drawing the last the letters (ing)
 */
- (CAAnimation *)circleAnimation
{
    CABasicAnimation *circle = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circle.fromValue = @0;
    circle.toValue   = @1;
    circle.fillMode = kCAFillModeBoth;
    circle.removedOnCompletion = NO;
    circle.duration = 1;
    return circle;
}
//top left
-(CGPathRef)loadTopLeftOneHalfPath{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,     NULL, 99.999984741210938+indexX, 17.5+5);
    //    CGPathAddLineToPoint(path, NULL, 99.999984741210938, 167.5);
    CGPathAddLineToPoint(path, NULL, 98.999984741210938+indexX, 17.51300048828125+5);
    CGPathAddLineToPoint(path, NULL, 97.999984741210938+indexX, 17.552001953125+5);
    CGPathAddLineToPoint(path, NULL, 96.999984741210938+indexX, 17.61700439453125+5);
    CGPathAddLineToPoint(path, NULL, 95.999984741210938+indexX, 17.70799255371094+5);
    CGPathAddLineToPoint(path, NULL, 94.999984741210938+indexX, 17.82501220703125+5);
    CGPathAddLineToPoint(path, NULL, 93.999984741210938+indexX, 17.96798706054688+5);
    CGPathAddLineToPoint(path, NULL, 92.999984741210938+indexX, 18.13699340820312+5);
    CGPathAddLineToPoint(path, NULL, 91.999984741210938+indexX, 18.33200073242188+5);
    CGPathAddLineToPoint(path, NULL, 90.999992370605469+indexX, 18.55299377441406+5);
    CGPathAddLineToPoint(path, NULL, 89.999992370605469+indexX, 18.80000305175781+5);
    CGPathAddLineToPoint(path, NULL, 88.999984741210938+indexX, 19.072998046875+5);
    CGPathAddLineToPoint(path, NULL, 87.999992370605469+indexX, 19.37199401855469+5);
    CGPathAddLineToPoint(path, NULL, 86.999992370605469+indexX, 19.69700622558594+5);
    CGPathAddLineToPoint(path, NULL, 85.999992370605469+indexX, 20.04800415039062+5);
    CGPathAddLineToPoint(path, NULL, 85+indexX, 20+5);
    CGPathAddLineToPoint(path, NULL, 84+indexX, 20.8280029296875+5);
    CGPathAddLineToPoint(path, NULL, 83+indexX, 21.25700378417969+5);
    CGPathAddLineToPoint(path, NULL, 82+indexX, 21.71199035644531+5);
    CGPathAddLineToPoint(path, NULL, 81+indexX, 22.1929931640625+5);
    CGPathAddLineToPoint(path, NULL, 80+indexX, 22.69999694824219+5);
    CGPathAddLineToPoint(path, NULL, 79.000007629394531+indexX, 23.23300170898438+5);
    CGPathAddLineToPoint(path, NULL, 78.000007629394531+indexX, 23.79200744628906+5);
    CGPathAddLineToPoint(path, NULL, 77.000007629394531+indexX, 24.37699890136719+5);
    CGPathAddLineToPoint(path, NULL, 76.000007629394531+indexX, 24.98799133300781+5);
    CGPathAddLineToPoint(path, NULL, 75.000007629394531+indexX, 25.625+5);
    CGPathAddLineToPoint(path, NULL, 74.000007629394531+indexX, 26.28797912597656+5);
    CGPathAddLineToPoint(path, NULL, 73.000007629394531+indexX, 26.97700500488281+5);
    CGPathAddLineToPoint(path, NULL, 72.000007629394531+indexX, 27.69200134277344+5);
    CGPathAddLineToPoint(path, NULL, 71.000007629394531+indexX, 28.43299865722656+5);
    CGPathAddLineToPoint(path, NULL, 70+indexX, 29.19998168945312+5);
    CGPathAddLineToPoint(path, NULL, 69+indexX, 29.99299621582031+5);
    CGPathAddLineToPoint(path, NULL, 68+indexX, 30.81199645996094+5);
    CGPathAddLineToPoint(path, NULL, 67+indexX, 31.65699768066406+5);
    CGPathAddLineToPoint(path, NULL, 66+indexX, 32.52798461914062+5);
    CGPathAddLineToPoint(path, NULL, 65+indexX, 33.42500305175781+5);
    CGPathAddLineToPoint(path, NULL, 63.999996185302734+indexX, 34.34799194335938+5);
    CGPathAddLineToPoint(path, NULL, 63.000003814697266+indexX, 35.29701232910156+5);
    CGPathAddLineToPoint(path, NULL, 62+indexX, 36.27200317382812+5);
    CGPathAddLineToPoint(path, NULL, 60.999992370605469+indexX, 37.27297973632812+5);
    CGPathAddLineToPoint(path, NULL, 59.999992370605469+indexX, 38.29998779296875+5);
    CGPathAddLineToPoint(path, NULL, 59.000003814697266+indexX, 39.35301208496094+5);
    CGPathAddLineToPoint(path, NULL, 58+indexX, 40.43199157714844+5);
    CGPathAddLineToPoint(path, NULL, 57+indexX, 41.5369873046875+5);
    CGPathAddLineToPoint(path, NULL, 56+indexX, 42.66799926757812+5);
    CGPathAddLineToPoint(path, NULL, 55+indexX, 43.82499694824219+5);
    CGPathAddLineToPoint(path, NULL, 54+indexX, 45.00799560546875+5);
    CGPathAddLineToPoint(path, NULL, 53+indexX, 46.21699523925781+5);
    CGPathAddLineToPoint(path, NULL, 52+indexX, 47.45201110839844+5);
    CGPathAddLineToPoint(path, NULL, 51+indexX, 48.7130126953125+5);
    CGPathAddLineToPoint(path, NULL, 50+indexX, 49.7130126953125+5);
    CGAffineTransform t = CGAffineTransformMakeScale(0.7, 0.7);
    return CGPathCreateCopyByTransformingPath(path, &t);
    
}
// top right
- (CGPathRef)loadTopRightOneHalfPath
{
    
    CGMutablePathRef path = CGPathCreateMutable();
    // load
    CGPathMoveToPoint(path,    NULL, 100.99997711181641+indexX, 167.51300048828125-indexY);
    CGPathAddLineToPoint(path, NULL, 101.99998474121094+indexX, 167.552001953125-indexY);
    CGPathAddLineToPoint(path, NULL, 102.99998474121094+indexX, 167.61700439453125-indexY);
    CGPathAddLineToPoint(path, NULL, 103.99998474121094+indexX, 167.7080078125-indexY);
    CGPathAddLineToPoint(path, NULL, 104.99997711181641+indexX, 167.82498168945312-indexY);
    CGPathAddLineToPoint(path, NULL, 105.99997711181641+indexX, 167.96798706054688-indexY);
    CGPathAddLineToPoint(path, NULL, 106.99997711181641+indexX, 168.13699340820312-indexY);
    
    CGPathAddLineToPoint(path, NULL, 107.99997711181641+indexX, 168.33200073242188-indexY);
    CGPathAddLineToPoint(path, NULL, 108.99996948242188+indexX, 168.55299377441406-indexY);
    CGPathAddLineToPoint(path, NULL, 109.99996948242188+indexX, 168.79998779296875-indexY);
    CGPathAddLineToPoint(path, NULL, 110.99996948242188+indexX, 169.072998046875-indexY);
    CGPathAddLineToPoint(path, NULL, 111.99996948242188+indexX, 169.37197875976562-indexY);
    CGPathAddLineToPoint(path, NULL, 112.99996948242188+indexX, 169.69699096679688-indexY);
    
    CGPathAddLineToPoint(path, NULL, 113.99996948242188+indexX, 170.04798889160156-indexY);
    CGPathAddLineToPoint(path, NULL, 114.99996948242188+indexX, 170.42498779296875-indexY);
    CGPathAddLineToPoint(path, NULL, 115.99996948242188+indexX, 170.82797241210938-indexY);
    CGPathAddLineToPoint(path, NULL, 116.99996948242188+indexX, 171.25698852539062-indexY);
    CGPathAddLineToPoint(path, NULL, 117.99995422363281+indexX, 171.71197509765625-indexY);
    CGPathAddLineToPoint(path, NULL, 118.99996185302734+indexX, 172.19297790527344-indexY);
    CGPathAddLineToPoint(path, NULL, 119.99996185302734+indexX, 172.69998168945312-indexY);
    CGPathAddLineToPoint(path, NULL, 120.99996185302734+indexX, 173.23298645019531-indexY);
    CGPathAddLineToPoint(path, NULL, 121.99995422363281+indexX, 173.79197692871094-indexY);
    CGPathAddLineToPoint(path, NULL, 122.99996185302734+indexX, 174.37698364257812-indexY);
    CGPathAddLineToPoint(path, NULL, 123.99996185302734+indexX, 174.98797607421875-indexY);
    CGPathAddLineToPoint(path, NULL, 124.99996185302734+indexX, 175.62496948242188-indexY);
    CGPathAddLineToPoint(path, NULL, 125.99995422363281+indexX, 176.2879638671875-indexY);
    CGPathAddLineToPoint(path, NULL, 126.99995422363281+indexX, 176.97697448730469-indexY);
    CGPathAddLineToPoint(path, NULL, 127.99996185302734+indexX, 177.69197082519531-indexY);
    CGPathAddLineToPoint(path, NULL, 128.99995422363281+indexX, 178.43296813964844-indexY);
    CGPathAddLineToPoint(path, NULL, 129.99995422363281+indexX, 179.19996643066406-indexY);
    CGPathAddLineToPoint(path, NULL, 130.99995422363281+indexX, 179.99296569824219-indexY);
    CGPathAddLineToPoint(path, NULL, 131.99995422363281+indexX, 180.81195068359375-indexY);
    CGPathAddLineToPoint(path, NULL, 132.99995422363281+indexX, 181.65695190429688-indexY);
    CGPathAddLineToPoint(path, NULL, 133.99993896484375+indexX, 182.5279541015625-indexY);
    CGPathAddLineToPoint(path, NULL, 134.99995422363281+indexX, 183.42495727539062-indexY);
    CGPathAddLineToPoint(path, NULL, 135.99995422363281+indexX, 184.34794616699219-indexY);
    CGPathAddLineToPoint(path, NULL, 136.99993896484375+indexX, 185.29693603515625-indexY);
    CGPathAddLineToPoint(path, NULL, 137.99993896484375+indexX, 186.27194213867188-indexY);
    CGPathAddLineToPoint(path, NULL, 138.99993896484375+indexX, 187.27293395996094-indexY);
    CGPathAddLineToPoint(path, NULL, 139.99993896484375+indexX, 188.29994201660156-indexY);
    CGPathAddLineToPoint(path, NULL, 140.99993896484375+indexX, 189.35293579101562-indexY);
    CGPathAddLineToPoint(path, NULL, 141.99993896484375+indexX, 190.43193054199219-indexY);
    CGPathAddLineToPoint(path, NULL, 142.99993896484375+indexX, 191.53694152832031-indexY);
    CGPathAddLineToPoint(path, NULL, 143.99993896484375+indexX, 192.66792297363281-indexY);
    CGPathAddLineToPoint(path, NULL, 144.99993896484375+indexX, 193.82493591308594-indexY);
    CGPathAddLineToPoint(path, NULL, 145.99993896484375+indexX, 195.0079345703125-indexY);
    CGPathAddLineToPoint(path, NULL, 146.99993896484375+indexX, 196.2169189453125-indexY);
    CGPathAddLineToPoint(path, NULL, 147.99993896484375+indexX, 197.45191955566406-indexY);
    CGPathAddLineToPoint(path, NULL, 148.99992370605469+indexX, 198.71292114257812-indexY);
    CGPathAddLineToPoint(path, NULL, 149.99993896484375+indexX, 199.99992370605469-indexY);
    
     [[UIColor whiteColor] setStroke];
    
    CGAffineTransform t = CGAffineTransformMakeScale(0.7, 0.7); // It was slighly to big and I didn't feel like redoing it :D
    return CGPathCreateCopyByTransformingPath(path, &t);
}

- (CGPathRef)loadButtonLeftOneHalfPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    // ing (minus dot)
    CGPathMoveToPoint(path,    NULL, 100.99997711181641+indexX, 232.48699951171875-indexY);
    CGPathAddLineToPoint(path, NULL, 101.99998474121094+indexX, 232.447998046875-indexY);
    CGPathAddLineToPoint(path, NULL, 102.99998474121094+indexX, 232.38301086425781-indexY);
    CGPathAddLineToPoint(path, NULL, 103.99998474121094+indexX, 232.29200744628906-indexY);
    CGPathAddLineToPoint(path, NULL, 104.99997711181641+indexX, 232.17498779296875-indexY);
    CGPathAddLineToPoint(path, NULL, 105.99997711181641+indexX, 232.03201293945312-indexY);
    CGPathAddLineToPoint(path, NULL, 106.99997711181641+indexX, 231.86300659179688-indexY);
    
    CGPathAddLineToPoint(path, NULL, 107.99997711181641+indexX, 231.66799926757812-indexY);
    CGPathAddLineToPoint(path, NULL, 108.99996948242188+indexX, 231.44699096679688-indexY);
    CGPathAddLineToPoint(path, NULL, 109.99996948242188+indexX, 231.20001220703125-indexY);
    CGPathAddLineToPoint(path, NULL, 110.99996948242188+indexX, 230.92701721191406-indexY);
    CGPathAddLineToPoint(path, NULL, 111.99996948242188+indexX, 230.62799072265625-indexY);
    CGPathAddLineToPoint(path, NULL, 112.99996948242188+indexX, 230.30300903320312-indexY);
    
    CGPathAddLineToPoint(path, NULL, 113.99996948242188+indexX, 229.95201110839844-indexY);
    CGPathAddLineToPoint(path, NULL, 114.99996948242188+indexX, 229.57501220703125-indexY);
    CGPathAddLineToPoint(path, NULL, 115.99996948242188+indexX, 229.1719970703125-indexY);
    CGPathAddLineToPoint(path, NULL, 116.99996948242188+indexX, 228.74301147460938-indexY);
    CGPathAddLineToPoint(path, NULL, 117.99995422363281+indexX, 228.28800964355469-indexY);
    CGPathAddLineToPoint(path, NULL, 118.99996185302734+indexX, 227.8070068359375-indexY);
    CGPathAddLineToPoint(path, NULL, 119.99996185302734+indexX, 227.30000305175781-indexY);
    CGPathAddLineToPoint(path, NULL, 120.99996185302734+indexX, 226.76702880859375-indexY);
    CGPathAddLineToPoint(path, NULL, 121.99995422363281+indexX, 226.2080078125-indexY);
    CGPathAddLineToPoint(path, NULL, 122.99996185302734+indexX, 225.62301635742188-indexY);
    CGPathAddLineToPoint(path, NULL, 123.99996185302734+indexX, 225.01202392578125-indexY);
    CGPathAddLineToPoint(path, NULL, 124.99996185302734+indexX, 224.37503051757812-indexY);
    CGPathAddLineToPoint(path, NULL, 125.99995422363281+indexX, 223.7120361328125-indexY);
    CGPathAddLineToPoint(path, NULL, 126.99995422363281+indexX, 223.02304077148438-indexY);
    CGPathAddLineToPoint(path, NULL, 127.99996185302734+indexX, 222.30804443359375-indexY);
    CGPathAddLineToPoint(path, NULL, 128.99995422363281+indexX, 221.56703186035156-indexY);
    CGPathAddLineToPoint(path, NULL, 129.99995422363281+indexX, 220.800048828125-indexY);
    CGPathAddLineToPoint(path, NULL, 130.99995422363281+indexX, 220.00703430175781-indexY);
    CGPathAddLineToPoint(path, NULL, 131.99995422363281+indexX, 219.18804931640625-indexY);
    CGPathAddLineToPoint(path, NULL, 132.99995422363281+indexX, 218.34304809570312-indexY);
    CGPathAddLineToPoint(path, NULL, 133.99993896484375+indexX, 217.4720458984375-indexY);
    CGPathAddLineToPoint(path, NULL, 134.99995422363281+indexX, 216.57504272460938-indexY);
    CGPathAddLineToPoint(path, NULL, 135.99995422363281+indexX, 215.65203857421875-indexY);
    CGPathAddLineToPoint(path, NULL, 136.99993896484375+indexX, 214.70304870605469-indexY);
    CGPathAddLineToPoint(path, NULL, 137.99993896484375+indexX, 213.72805786132812-indexY);
    CGPathAddLineToPoint(path, NULL, 138.99993896484375+indexX, 212.72705078125-indexY);
    CGPathAddLineToPoint(path, NULL, 139.99993896484375+indexX, 211.70005798339844-indexY);
    CGPathAddLineToPoint(path, NULL, 140.99993896484375+indexX, 210.64706420898438-indexY);
    CGPathAddLineToPoint(path, NULL, 141.99993896484375+indexX, 209.56805419921875-indexY);
    CGPathAddLineToPoint(path, NULL, 142.99993896484375+indexX, 208.46307373046875-indexY);
    CGPathAddLineToPoint(path, NULL, 143.99993896484375+indexX, 207.33206176757812-indexY);
    CGPathAddLineToPoint(path, NULL, 144.99993896484375+indexX, 206.17507934570312-indexY);
    CGPathAddLineToPoint(path, NULL, 145.99993896484375+indexX, 204.9920654296875-indexY);
    CGPathAddLineToPoint(path, NULL, 146.99993896484375+indexX, 203.78306579589844-indexY);
    CGPathAddLineToPoint(path, NULL, 147.99993896484375+indexX, 202.54806518554688-indexY);
    CGPathAddLineToPoint(path, NULL, 148.99992370605469+indexX, 201.28707885742188-indexY);
    CGPathAddLineToPoint(path, NULL, 149.99993896484375+indexX, 200.00009155273438-indexY);
     [[UIColor whiteColor] setStroke];
    CGAffineTransform t = CGAffineTransformMakeScale(0.7, 0.7); // It was slighly to big and I didn't feel like redoing it :D
    return CGPathCreateCopyByTransformingPath(path, &t);
}
// top right
- (CGPathRef)loadButtonRightOneHalfPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,    NULL, 100.99997711181641+indexX, 232.48699951171875-indexY);
    CGPathAddLineToPoint(path, NULL, 99.999984741210938+indexX, 232.5-indexY);
    CGPathAddLineToPoint(path, NULL, 98.999984741210938+indexX, 232.48699951171875-indexY);
    CGPathAddLineToPoint(path, NULL, 97.999984741210938+indexX, 232.447998046875-indexY);
    CGPathAddLineToPoint(path, NULL, 96.999984741210938+indexX, 232.38301086425781-indexY);
    CGPathAddLineToPoint(path, NULL, 95.999984741210938+indexX, 232.2919921875-indexY);
    CGPathAddLineToPoint(path, NULL, 94.999984741210938+indexX, 232.17498779296875-indexY);
    CGPathAddLineToPoint(path, NULL, 93.999984741210938+indexX, 232.031982421875-indexY);
    CGPathAddLineToPoint(path, NULL, 92.999984741210938+indexX, 231.86300659179688-indexY);
    CGPathAddLineToPoint(path, NULL, 91.999984741210938+indexX, 231.66798400878906-indexY);
    CGPathAddLineToPoint(path, NULL, 90.999992370605469+indexX, 231.44697570800781-indexY);
    CGPathAddLineToPoint(path, NULL, 89.999992370605469+indexX, 231.19999694824219-indexY);
    CGPathAddLineToPoint(path, NULL, 88.999984741210938+indexX, 230.92698669433594-indexY);
    CGPathAddLineToPoint(path, NULL, 87.999992370605469+indexX, 230.62799072265625-indexY);
    CGPathAddLineToPoint(path, NULL, 86.999992370605469+indexX, 230.30299377441406-indexY);
    CGPathAddLineToPoint(path, NULL, 85.999992370605469+indexX, 229.95201110839844-indexY);
    CGPathAddLineToPoint(path, NULL, 85+indexX, 229.57501220703125-indexY);
    CGPathAddLineToPoint(path, NULL, 84+indexX, 229.1719970703125-indexY);
    CGPathAddLineToPoint(path, NULL, 83+indexX, 228.74299621582031-indexY);
    CGPathAddLineToPoint(path, NULL, 82+indexX, 228.28800964355469-indexY);
    CGPathAddLineToPoint(path, NULL, 81+indexX, 227.8070068359375-indexY);
    CGPathAddLineToPoint(path, NULL, 80+indexX, 227.29998779296875-indexY);
    CGPathAddLineToPoint(path, NULL, 79.000007629394531+indexX, 226.76699829101562-indexY);
    CGPathAddLineToPoint(path, NULL, 78.000007629394531+indexX, 226.2080078125-indexY);
    CGPathAddLineToPoint(path, NULL, 77.000007629394531+indexX, 225.62300109863281-indexY);
    CGPathAddLineToPoint(path, NULL, 76.000007629394531+indexX, 225.01200866699219-indexY);
    CGPathAddLineToPoint(path, NULL, 75.000007629394531+indexX, 224.375-indexY);
    CGPathAddLineToPoint(path, NULL, 74.000007629394531+indexX, 223.71199035644531-indexY);
    CGPathAddLineToPoint(path, NULL, 73.000007629394531+indexX, 223.02301025390625-indexY);
    CGPathAddLineToPoint(path, NULL, 72.000007629394531+indexX, 222.30799865722656-indexY);
    CGPathAddLineToPoint(path, NULL, 71.000007629394531+indexX, 221.56700134277344-indexY);
    CGPathAddLineToPoint(path, NULL, 70+indexX, 220.79998779296875-indexY);
    CGPathAddLineToPoint(path, NULL, 69+indexX, 220.00698852539062-indexY);
    CGPathAddLineToPoint(path, NULL, 68+indexX, 219.18800354003906-indexY);
    CGPathAddLineToPoint(path, NULL, 67+indexX, 218.34300231933594-indexY);
    CGPathAddLineToPoint(path, NULL, 66+indexX, 217.47198486328125-indexY);
    CGPathAddLineToPoint(path, NULL, 65+indexX, 216.57501220703125-indexY);
    CGPathAddLineToPoint(path, NULL, 63.999996185302734+indexX, 215.65199279785156-indexY);
    CGPathAddLineToPoint(path, NULL, 63.000003814697266+indexX, 214.7030029296875-indexY);
    CGPathAddLineToPoint(path, NULL, 62+indexX, 213.72799682617188-indexY);
    CGPathAddLineToPoint(path, NULL, 60.999992370605469+indexX, 212.72697448730469-indexY);
    CGPathAddLineToPoint(path, NULL, 59.999992370605469+indexX, 211.69998168945312-indexY);
    CGPathAddLineToPoint(path, NULL, 59.000003814697266+indexX, 210.64700317382812-indexY);
    CGPathAddLineToPoint(path, NULL, 58+indexX, 209.5679931640625-indexY);
    CGPathAddLineToPoint(path, NULL, 57+indexX, 208.46299743652344-indexY);
    CGPathAddLineToPoint(path, NULL, 56+indexX, 207.33200073242188-indexY);
    CGPathAddLineToPoint(path, NULL, 55+indexX, 206.17500305175781-indexY);
    CGPathAddLineToPoint(path, NULL, 54+indexX, 204.99200439453125-indexY);
    CGPathAddLineToPoint(path, NULL, 53+indexX, 203.78300476074219-indexY);
    CGPathAddLineToPoint(path, NULL, 52+indexX, 202.54800415039062-indexY);
    CGPathAddLineToPoint(path, NULL, 51+indexX, 201.28700256347656-indexY);
    CGPathAddLineToPoint(path, NULL, 50+indexX, 200.28700256347656-indexY);
     [[UIColor whiteColor] setStroke];
    CGAffineTransform t = CGAffineTransformMakeScale(0.7, 0.7);
    return CGPathCreateCopyByTransformingPath(path, &t);
}
- (CGPathRef)circlePath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(75+indexX, 175-indexY, 50, 50));
    CGAffineTransform t = CGAffineTransformMakeScale(0.7, 0.7); // It was slighly to big
    return CGPathCreateCopyByTransformingPath(path, &t);
}


@end
