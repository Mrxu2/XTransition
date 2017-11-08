//
//  A_ViewController.m
//  XTransition
//
//  Created by 许宇航 on 2017/11/6.
//  Copyright © 2017年 许宇航. All rights reserved.
//

#import "A_ViewController.h"
#import "WKCollectionViewLayout.h"
#import "A_CollectionViewCell.h"
#import "B_ViewController.h"

@interface A_ViewController ()

@end

@implementation A_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF_MACRO
    self.title = @"A_控制器";
    WKCollectionViewLayout * flowLayout =[[WKCollectionViewLayout alloc] init];    flowLayout.colCount = 2;
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView registerClass:[A_CollectionViewCell class]forCellWithReuseIdentifier:NSStringFromClass([A_CollectionViewCell class])];
    // Do any additional setup after loading the view.
}

-(UIView *)ACell
{
    if (!_ACell) {
        _ACell = [[UIView alloc]init];
        [self.view addSubview:_ACell];
    }
    
    return _ACell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 0, 0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{//
    
    A_CollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([A_CollectionViewCell class]) forIndexPath:indexPath];
    NSInteger r = arc4random()%255;
    NSInteger g = arc4random()%255;
    NSInteger b = arc4random()%255;
    cell.backgroundColor =RGB(r, g, b);
    cell = [self bezierPathByRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5) View:cell];
    return cell;
    
    return [UICollectionViewCell new];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger arc = arc4random()%50;
    NSInteger heigth = mainWidth/2-10+arc;
    return CGSizeMake(mainWidth/2-8,heigth);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [self setCollection:collectionView Index:indexPath];
    
    UIColor *color = self.ACell.backgroundColor;
    self.navigationController.delegate = self;
    B_ViewController *vc2 = [[B_ViewController alloc] init];
    vc2.color = color;
    vc2.title = @"B_控制器";
    [self.navigationController pushViewController:vc2 animated:YES];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.ACell.hidden = YES;
    self.collectionCell.hidden = NO;
}
-(void)setCollection:(UICollectionView *)collectionView Index:(NSIndexPath *)indexPath
{
    
    A_CollectionViewCell *cell = (A_CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //该cell主要负责隐藏或者展示。
    self.collectionCell = cell;
    self.collectionCell.hidden = YES;
    
    //获取当前cell的位置
    CGRect cellRect = [self.collectionView convertRect:cell.frame toView:self.collectionView];
    CGRect rect2 = [self.collectionView convertRect:cellRect toView:self.view];
    
    //给展示的view 加上数据。 比如对cell上的某一个image进行动画跳转。那么只需要把cell的image附给ACell。
    UIColor *color = cell.backgroundColor;
    self.ACell.backgroundColor = color;
    self.ACell.frame = rect2;
    self.ACell.hidden = NO;
    
    
    
}
#pragma mark <UINavigationControllerDelegate>

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[B_ViewController class]]) {
        
        X_Transition *transition = [X_Transition transitionWithViewArray:@[@[@"ACell",@"ACell"]]];
        
        return transition;
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
