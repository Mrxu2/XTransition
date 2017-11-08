//
//  XBaseViewController.h
//  XTransition
//
//  Created by 许宇航 on 2017/11/6.
//  Copyright © 2017年 许宇航. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "X_Transition.h"
#import "UIView+MotionBlur.h"
#import "UIImage+Capture.h"
#import "UIView+XBlock.h"

@interface XBaseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,retain)UIView *BGView;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)UICollectionView *collectionView;

- (UITableViewStyle)tableViewStyle;
-(id)bezierPathByRoundingCorners:(UIRectCorner )corner cornerRadii:(CGSize)size View:(UIView *)view;

@end
