//
//  X_Transition.m
//  XTransition
//
//  Created by 许宇航 on 2017/11/6.
//  Copyright © 2017年 许宇航. All rights reserved.
//

#import "X_Transition.h"
#import "UIView+MotionBlur.h"
#import "UIImage+Capture.h"

@interface X_Transition ()
@property (nonatomic, strong) NSArray *transitionViewArray;
@property (nonatomic, assign) CGRect Xframe;
@end

@implementation X_Transition

#pragma mark - 生命周期

#pragma mark - api
+ (instancetype)transitionWithViewArray:(NSArray *)array
{
    X_Transition *transition = [[X_Transition alloc]init];
    transition.transitionViewArray = array;
    return transition;
}
+ (instancetype)transitionWithViewArray:(NSArray *)array Xframe:(CGRect)xframe
{
    X_Transition *transition = [[X_Transition alloc]init];
    transition.transitionViewArray = array;
    transition.Xframe = xframe;
    return transition;
}
#pragma mark - getter / setter


#pragma mark - model event

#pragma mark - view event

#pragma mark - private

/**
 动画持续时间
 */
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    
    //获取从哪里来的控制器
    UIViewController *fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //获取到哪里去的控制器
    UIViewController *toVC   = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    
    //转场需要动画的视图数组
    NSMutableArray *animationViewsArray = [[NSMutableArray alloc] init];
    
    //做动画的视图,注意添加顺序,层次;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    @autoreleasepool {
        for (NSArray *startToEndViewArray in self.transitionViewArray)
        {
            //来源视图处理指针
            UIView *fromVcAnimationView = nil;
            //最终视图处理指针
            UIView *toVcAnimationView = nil;
            //做动画的视图指针
            UIImageView *animationImageView = nil;
            {
                fromVcAnimationView = [fromVC valueForKey:startToEndViewArray[0]];
                //截图
                animationImageView = [[UIImageView alloc] initWithImage:[UIImage captureWithView:fromVcAnimationView]];
                animationImageView.frame = fromVcAnimationView.frame;
                [containerView addSubview:animationImageView];
            }
            
            toVcAnimationView  =  [toVC valueForKey:startToEndViewArray[1]];
            fromVcAnimationView.hidden = YES;
            toVcAnimationView.hidden = YES;
            
            //原图,结果图,动画图
            [animationViewsArray addObject:@[fromVcAnimationView,toVcAnimationView,animationImageView]];
        }
        
    }
    
    //动画效果
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        toVC.view.alpha = 1.0;
        for (NSArray *animationArray in animationViewsArray)
        {
            UIImageView *animationImageView = animationArray[2];
            UIView *resultsView =  animationArray[1];
            //frame变换
            animationImageView.frame = [containerView convertRect:resultsView.frame fromView:resultsView.superview];
        }
        
        
    } completion:^(BOOL finished) {
        if (!finished)return ;
        
        for (NSArray *animationArray in animationViewsArray)
        {
            UIView *fromVcAnimationView = animationArray[0];
            UIView *toVcAnimationView = animationArray[1];
            UIImageView *animationImageView = animationArray[2];
            
            fromVcAnimationView.hidden = NO;
            toVcAnimationView.hidden = NO;
            //删除做动画view
            [animationImageView removeFromSuperview];
        }
        //结束动画,必须调用;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}
@end
