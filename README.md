# XTransition
# 这是一个在控制器之间切换时，使A控制器的view在过度到B控制器时以动画的形式平稳的展示。
  ![image](https://github.com/Mrxu2/XTransition/blob/master/github2.gif ) 
# UINavigationControllerDelegate - 使用方法
```java
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if ([toVC isKindOfClass:[A_ViewController class]] ||[toVC isKindOfClass:[B_ViewController class]] ) {
        X_Transition *inverseTransition = [X_Transition transitionWithViewArray:@[@[@"ACell",@"ACell"]]];
        return inverseTransition;
    }else{
        return nil;
    }
}
```

# 注意格式
 X_Transition *inverseTransition = [X_Transition transitionWithViewArray:@[@[@"ACell",@"ACell"]]];
 
 格式 ：2维数组,@[@[原图控件name,结果图控件name]];用kvc加载的; 
 
 @[@[@"ACell",@"ACell"]]
 
