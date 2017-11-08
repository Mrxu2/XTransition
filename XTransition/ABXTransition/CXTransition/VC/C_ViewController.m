//
//  C_ViewController.m
//  XTransition
//
//  Created by 许宇航 on 2017/11/6.
//  Copyright © 2017年 许宇航. All rights reserved.
//

#import "C_ViewController.h"
#import "A_ViewController.h"
#import "B_ViewController.h"

@interface C_ViewController ()

@end

@implementation C_ViewController
-(UIView *)ACell
{
    if (!_ACell) {
        _ACell = [[UIView alloc]initWithFrame:CGRectMake(100, 400, mainWidth-200, 200)];
        _ACell.backgroundColor = [UIColor yellowColor];
        _ACell.text = @"C控制器";
        _ACell.textColor = [UIColor whiteColor];
        [self.view addSubview:_ACell];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(aCellTapClick)];
        [_ACell addGestureRecognizer:tap];
        
    }
    return _ACell;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    self.view.backgroundColor = RGB(240, 240, 240);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.ACell.backgroundColor = self.color;
    // Do any additional setup after loading the view.
}
-(void)aCellTapClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark <UINavigationControllerDelegate>
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
