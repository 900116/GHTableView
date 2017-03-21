//
//  Demo2ViewController.m
//  GHBaseTableViewDemo
//
//  Created by YongCheHui on 2017/3/21.
//  Copyright © 2017年 ApesStudio. All rights reserved.
//

#import "Demo2ViewController.h"
#import "GHTableView.h"

@interface Demo2ViewController ()

@end

@implementation Demo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GHTableView* ghtableView = [[GHTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [ghtableView setShowSection:YES];
    [ghtableView setShowSectionRightBar:YES];
    [ghtableView setShowSectionHeaderTitle:YES];
    [ghtableView setShowSectionFooterTitle:YES];
    [ghtableView addCellCls:[UITableViewCell class] nib:NO];
    [ghtableView setCellClass_configureWithIndexPath:^Class(NSIndexPath * idp) {
        return [UITableViewCell class];
    }];
    [ghtableView setRefreshCell:^(UITableViewCell *cell, id model, NSIndexPath * idp) {
        cell.textLabel.text = model;
    }];
    [ghtableView setSelectHandler:^(id model, NSIndexPath * idp) {
        NSLog(@"点击%ld",idp.row);
    }];
    ghtableView.sectionRightBarTitles = @[@"I",@"II"]; //如果setShowSectionRightBar为YES，不写这一行，其值等于headertitles
    [self.view addSubview:ghtableView];

    [ghtableView gh_setDatas:@[@[@"A",@"B",@"C"],@[@"D",@"E"]]];
    ghtableView.sectionFooterTitles = @[@"1",@"2"];
//    [ghtableView setSectionFooterView:^UIView *(NSInteger section, NSString * title) {
//        return [UIView new];
//    }];
    [ghtableView setSectionFooterHeightHandler:^CGFloat(NSInteger section) {
        return 30.f; //如果showSectionFooterTitle为YES，该值默认为28
    }];
    
    ghtableView.sectionHeaderTitles = @[@"I",@"II"];
//    [ghtableView setSectionHeaderView:^UIView *(NSInteger section, NSString * title) {
//        return [UIView new];
//    }];
//    [ghtableView setSectionHeaderHeightHandler:^CGFloat(NSInteger section) {
//        return 30.f;//如果showSectionHeaderTitle为YES，该值默认为28
//    }];
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
