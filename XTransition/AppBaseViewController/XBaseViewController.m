//
//  XBaseViewController.m
//  XTransition
//
//  Created by 许宇航 on 2017/11/6.
//  Copyright © 2017年 许宇航. All rights reserved.
//

#import "XBaseViewController.h"


@interface XBaseViewController ()

@end

@implementation XBaseViewController

- (UITableViewStyle)tableViewStyle
{
    return UITableViewStylePlain;
}

-(UIView *)BGView
{
    if (!_BGView) {
        WEAKSELF_MACRO
        _BGView = [[UIView alloc]init];
        _BGView.clipsToBounds = YES;
        [self.view addSubview:_BGView];
        [_BGView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _BGView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, mainNavHeight, mainWidth,mainHeight-mainNavHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = RGB(240, 240, 240);
        [self.BGView addSubview:_collectionView];
        _collectionView.contentInset = UIEdgeInsetsMake(mainNavHeight, 0, mainNavHeight, 0);
        WEAKSELF_MACRO
        [_collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.BGView);
        }];
    }
    return _collectionView;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [self.BGView addSubview:_tableView];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        if (@available(iOS 11.0, *)) {
            _tableView.contentInset = UIEdgeInsetsMake(mainNavHeight, 0, mainNavHeight, 0);
        }
        WEAKSELF_MACRO
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.BGView);
        }];
        
        
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    if (@available(iOS 11.0, *)) {
        UIScrollView *scroll =  [UIScrollView appearance] ;
        scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    // Do any additional setup after loading the view.
}
/**
 *  使视图的frame适配安全区域
 */
- (void) viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    if (self.hidesBottomBarWhenPushed) {
        [self.view setFrame:CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMinY(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - self.view.safeAreaInsets.bottom)];
    }
}

-(id)bezierPathByRoundingCorners:(UIRectCorner )corner cornerRadii:(CGSize)size View:(UIView *)view
{
    //    UIRectCornerBottomLeft|UIRectCornerTopLeft
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corner cornerRadii:size];
    
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
    
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    return view;
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
