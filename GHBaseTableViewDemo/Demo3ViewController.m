//
//  Demo3ViewController.m
//  GHBaseTableViewDemo
//
//  Created by YongCheHui on 2017/3/21.
//  Copyright © 2017年 ApesStudio. All rights reserved.
//

#import "Demo3ViewController.h"
#import "GHTableView.h"
@interface Demo3Cell1:UITableViewCell
@end
@implementation Demo3Cell1
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
+(CGFloat)gh_cellHeightWithModel:(id)model
{
    return 30.f;
}
@end

@interface Demo3Cell2:UITableViewCell
@property(nonatomic,weak) UIView* leftView;
@end
@implementation Demo3Cell2
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView* leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self addSubview:leftView];
        self.leftView = leftView;
    }
    return self;
}
+(CGFloat)gh_cellHeightWithModel:(id)model
{
    return 50.f;
}
@end


@interface Demo3ViewController ()

@end

@implementation Demo3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GHTableView* ghtableView = [[GHTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [ghtableView addCellCls:[Demo3Cell1 class] nib:NO];
    [ghtableView addCellCls:[Demo3Cell2 class] nib:NO];
    //用下面方法可以将高度缓存（动态高度提升性能），默认是不缓存的
    //[ghtableView setNeedCacheHeights:YES];
    [ghtableView setCellClass_configureWithIndexPath:^Class(NSIndexPath * idp) {
        if (idp.row % 2 == 0) {
            return [Demo3Cell1 class];
        }
        else
        {
            return [Demo3Cell2 class];
        }
    }];
    [ghtableView setRefreshCell:^(UITableViewCell *cell, id model, NSIndexPath * idp) {
        if ([cell isKindOfClass:[Demo3Cell1 class]]) {
            Demo3Cell1 *cell1 = (Demo3Cell1*)cell;
            cell1.textLabel.text = model;
            
        }
        else
        {
            Demo3Cell2 *cell2 = (Demo3Cell2*)cell;
            cell2.leftView.backgroundColor = model;
        }
    }];
    [ghtableView setSelectHandler:^(id model, NSIndexPath * idp) {
        NSLog(@"点击%ld",idp.row);
    }];
    [self.view addSubview:ghtableView];
    
    [ghtableView gh_setDatas:@[@"A",[UIColor redColor],@"C",[UIColor greenColor],@"E"]];
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
