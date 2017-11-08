//
//  ViewController.m
//  XTransition
//
//  Created by 许宇航 on 2017/11/6.
//  Copyright © 2017年 许宇航. All rights reserved.
//

#import "B_ViewController.h"
#import "A_ViewController.h"
#import "C_ViewController.h"
@interface B_ViewController ()

@end

@implementation B_ViewController
-(UIView *)ACell
{
    if (!_ACell) {
        
        _ACell = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, 400)];
        _ACell.backgroundColor = [UIColor yellowColor];
        _ACell.text = @"B控制器";
        _ACell.textColor = [UIColor whiteColor];
        [self.view addSubview:_ACell];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(aCellTapClick)];
        [_ACell addGestureRecognizer:tap];
    }
    return _ACell;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    self.navigationController.delegate = self;
    self.view.backgroundColor = RGB(240, 240, 240);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.ACell.backgroundColor = self.color;
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)aCellTapClick
{
//    点击普通view进行动画跳转。
    C_ViewController *vc = [[C_ViewController alloc]init];
    vc.color = self.color;
    vc.title = @"C_控制器";
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark <UINavigationControllerDelegate>
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if ([toVC isKindOfClass:[A_ViewController class]] ||[toVC isKindOfClass:[C_ViewController class]] ) {
        X_Transition *inverseTransition = [X_Transition transitionWithViewArray:@[@[@"ACell",@"ACell"]]];
        return inverseTransition;
    }else{
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
