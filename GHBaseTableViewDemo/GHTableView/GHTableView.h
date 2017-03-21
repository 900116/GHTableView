//
//  YCBaseTableView.h
//  yidao_driver
//
//  Created by YongCheHui on 2016/12/15.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+GHTableView.h"

@interface GHTableView : UITableView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray* datas;
/*
 是否为group类型的（分组table）
 默认是NO,如果为YES,则
 -(void)gh_setDatas:(NSArray*)datas;
 -(void)gh_addDatas:(NSArray*)datas;
 所传的参数必须为NSArray<NSArray*>* 二维数组
 */
@property(nonatomic,assign) BOOL showSection;
/*
 是否显示分组的header的title
 默认是NO
 如果是YES（前提是showSection必须为YES）
 */
@property(nonatomic,assign) BOOL showSectionHeaderTitle;
/*
 是否显示分组的footer的title
 默认是NO
 如果是YES（前提是showSection必须为YES）
 */
@property(nonatomic,assign) BOOL showSectionFooterTitle;
/*
 是否显示右边的分组控制栏
 如果是YES（前提是showSection必须为YES）
 默认是NO
 */
@property(nonatomic,assign) BOOL showSectionRightBar;

/*
 分组的header的titles数组
 */
@property(nonatomic,copy) NSArray* sectionHeaderTitles;

/*
 分组的footer的titles数组
 */
@property(nonatomic,copy) NSArray* sectionFooterTitles;

/*
 分组的右侧控制栏的titles数组
 如果showSectionRightBar为YES sectionRightBarTitles为nil
 则按照sectionHeaderTitles处理
 （如果showSectionRightBar为YES  sectionRightBarTitles和sectionHeaderTitles 至少有一个不为nil）
 */
@property(nonatomic,copy) NSArray* sectionRightBarTitles;

/*
 Cell是否为动态高度
 默认为NO
 高度需要重写Cell类的方法
 +(CGFloat)gh_cellHeightWithModel:(id)model;
 */
@property(nonatomic,assign) BOOL needCacheHeights;

/*
 是否可以编辑，默认为NO
 */
@property(nonatomic,assign) BOOL canEdit;

/*
 是否可以移动，默认为NO
 */
@property(nonatomic,assign) BOOL canMove;

/*
 是否自动取消选择
 默认是YES ：  cell变灰的一瞬间会恢复正常
 如果为NO：cell将一直变灰
 */
@property(nonatomic,assign) BOOL autoDeselect;

/*
 当canMove为YES时可用
 */
@property(nonatomic,copy) void(^moveActionHandler)(NSIndexPath* from,NSIndexPath* to);

/*
 当canEdit为YES时可用
 */
@property(nonatomic,copy) void(^editActionHandler)(UITableViewCellEditingStyle style,NSIndexPath* indexPath);

/*
 点击Cell时的回调
 */
@property(nonatomic,copy) void(^selectHandler)(id model,NSIndexPath* idp);

/*
 刷新Cell时回调，如果仅仅根据model刷新cell可以不必设定
 重写cell的-(void)gh_setModelData:(id)data;方法即可刷新数据
 如果有额外操作时可设定该值
 */
@property(nonatomic,copy) void(^refreshCell)(UITableViewCell* cell,id model,NSIndexPath *idp);

/*
 刷新indexPath，配置Cell类
 */
@property(nonatomic,copy) Class(^cellClass_configureWithIndexPath)(NSIndexPath* inp);

/*
 sectionHeader高度
 */
@property(nonatomic,copy) CGFloat(^sectionHeaderHeightHandler)(NSInteger section);
/*
 sectionFooter高度
 */
@property(nonatomic,copy) CGFloat(^sectionFooterHeightHandler)(NSInteger section);
/*
 定制sectionHeaderTitleView
 */
@property(nonatomic,copy) UIView*(^sectionHeaderView)(NSInteger section,NSString* sectionTitles);

/*
 定制sectionFooterTitleView
 */
@property(nonatomic,copy) UIView*(^sectionFooterView)(NSInteger section,NSString* sectionTitles);

/*
 滑到底部回调
 */
@property(nonatomic,copy) void(^scrollToBottomHandler)();

/*
 该方法至关重要，Class为cell的类对象例如[UITableViewCell class]
 nib为是否是nib
 
 关于Cell的Identifier：
 默认为Cell的类名，如果想自定义则需要重写Cell的方法
 +(NSString*)cellIdentifier;
 */
-(void)addCellCls:(Class)cellCls nib:(BOOL)nib;

/*
 设定数据源，如果showSection为YES，必须是NSArray<NSArray*>* 二维数组
 否则为NSArray<Model*>*
 调用此方法后tableview会自动刷新 ，无需调用reloadData
 */
-(void)gh_setDatas:(NSArray*)datas;

/*
 添加数据源，如果showSection为YES，必须是NSArray<NSArray*>* 二维数组
 否则为NSArray<Model*>*
 调用此方法后tableview会自动刷新 ，无需调用reloadData
 */
-(void)gh_addDatas:(NSArray*)datas;
@end
