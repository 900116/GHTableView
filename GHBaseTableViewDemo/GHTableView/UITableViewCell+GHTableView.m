//
//  UITableView+YCUIKit.m
//  yidao_driver
//
//  Created by YongCheHui on 2016/12/15.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "UITableViewCell+GHTableView.h"
#import <objc/runtime.h>

@implementation UITableViewCell (GHTableView)
+(NSString*)cellIdentifier
{
    return NSStringFromClass(self.class);
}

-(void)gh_setModelData:(id)data
{
}

static const char * gh_cellIndexPathKey = "ghCellIndexPathKey";

-(void)gh_setIndexPath:(NSIndexPath*)indexPath
{
     objc_setAssociatedObject(self, gh_cellIndexPathKey, indexPath, OBJC_ASSOCIATION_ASSIGN);
}

-(NSIndexPath*)gh_indexPath
{
    return objc_getAssociatedObject(self, gh_cellIndexPathKey);
}

+(CGFloat)gh_cellHeightWithModel:(id)model
{
    return 44.f;
}
@end
