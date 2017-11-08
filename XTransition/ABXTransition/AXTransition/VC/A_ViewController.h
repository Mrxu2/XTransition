//
//  A_ViewController.h
//  XTransition
//
//  Created by 许宇航 on 2017/11/6.
//  Copyright © 2017年 许宇航. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBaseViewController.h"
#import "A_CollectionViewCell.h"
@interface A_ViewController : XBaseViewController<UINavigationControllerDelegate>
@property(nonatomic,retain)UIView *ACell;
@property(nonatomic,retain)A_CollectionViewCell *collectionCell;
@end
