//
//  Demo1ViewController.m
//  GHBaseTableViewDemo
//
//  Created by YongCheHui on 2017/3/21.
//  Copyright © 2017年 ApesStudio. All rights reserved.
//

#import "Demo1ViewController.h"
#import "GHTableView.h"

@interface Demo1ViewController ()

@end

@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GHTableView* ghtableView = [[GHTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
//   如果仅仅为UITableViewCell 则可以不注册
//    [ghtableView addCellCls:[UITableViewCell class] nib:NO];
//    [ghtableView setCellClass_configureWithIndexPath:^Class(NSIndexPath * idp) {
//        return [UITableViewCell class];
//    }];
    [ghtableView setRefreshCell:^(UITableViewCell *cell, id model, NSIndexPath * idp) {
        cell.textLabel.text = model;
    }];
    [ghtableView setSelectHandler:^(id model, NSIndexPath * idp) {
        NSLog(@"点击%ld",idp.row);
    }];
    [self.view addSubview:ghtableView];
    //进制自动取消选中
    //[ghtableView setAutoDeselect:NO];
    [ghtableView gh_setDatas:@[@"A",@"B",@"C",@"D",@"E"]];
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
