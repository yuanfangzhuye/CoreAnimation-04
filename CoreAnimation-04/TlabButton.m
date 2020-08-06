//
//  TlabButton.m
//  CoreAnimation-04
//
//  Created by tlab on 2020/8/6.
//  Copyright © 2020 yuanfangzhuye. All rights reserved.
//

#import "TlabButton.h"

@interface TlabButton ()

@property (nonatomic, strong) CAEmitterLayer *explosionLayer;

@end

@implementation TlabButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置粒子效果
        [self setupExplosion];
    }
    
    return self;
}


- (void)setupExplosion
{
    //1.粒子
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.name = @"explosionCell";
    
    //透明度变化速度
    cell.alphaSpeed = -1.0f;
    //透明值范围
    cell.alphaRange = 0.1f;
    
    //生命周期
    cell.lifetime = 1;
    //生命周期范围
    cell.lifetimeRange = 0.1f;
    
    //粒子速度
    cell.velocity = 40.0f;
    //粒子速度范围
    cell.velocityRange = 10.0f;
    
    //缩放比例
    cell.scale = 0.08f;
    //缩放比例范围
    cell.scaleRange = 0.02f;
    
    cell.contents = (id)[[UIImage imageNamed:@"spark_red"] CGImage];
    
    //2.发射源
    self.explosionLayer = [CAEmitterLayer layer];
    [self.layer addSublayer:self.explosionLayer];
    
    //发射源尺寸大小
    self.explosionLayer.emitterSize = CGSizeMake(self.bounds.size.width + 40, self.bounds.size.height + 40);
    //粒子从什么形状发射出来，圆形形状
    self.explosionLayer.emitterShape = kCAEmitterLayerCircle;
    //发射模型，轮廓模式，从形状的边界上发射粒子
    self.explosionLayer.emitterMode = kCAEmitterLayerOutline;
    //渲染模式
    self.explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    
    //粒子数组
    self.explosionLayer.emitterCells = @[cell];
}

- (void)layoutSubviews
{
    //发射源位置
    self.explosionLayer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    // 通过关键帧动画实现缩放
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animation];
    // 设置动画路径
    keyframeAnimation.keyPath = @"transform.scale";
    
    if (selected) {
        //从没有点击状态到点击状态，会有爆炸的动画效果
        keyframeAnimation.values = @[@1.5, @2.0, @0.8, @1.0];
        keyframeAnimation.duration = 0.5f;
        
        //计算关键帧方式
        keyframeAnimation.calculationMode = kCAAnimationCubic;
        //为图层添加动画
        [self.layer addAnimation:keyframeAnimation forKey:nil];
        
        //让放大动画先执行完毕，再执行爆炸动画
        [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.25];
    }
    else {
        [self stopAnimation];
    }
}

- (void)startAnimation
{
    // 用KVC设置颗粒个数
    [self.explosionLayer setValue:@1000 forKeyPath:@"emitterCells.explosionCell.birthRate"];
    
    // 开始动画
    self.explosionLayer.beginTime = CACurrentMediaTime();
    
    // 延迟停止动画
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
}

- (void)stopAnimation
{
    // 用KVC设置颗粒个数
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosionCell.birthRate"];
    
    //移除动画
    [self.explosionLayer removeAllAnimations];
}

@end
