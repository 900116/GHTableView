//
//  UITableView+YCUIKit.h
//  yidao_driver
//
//  Created by YongCheHui on 2016/12/15.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (GHTableView)
+(NSString*)cellIdentifier;
+(CGFloat)gh_cellHeightWithModel:(id)model;

-(void)gh_setIndexPath:(NSIndexPath*)indexPath;
-(NSIndexPath*)gh_indexPath;
-(void)gh_setModelData:(id)data;
@end
