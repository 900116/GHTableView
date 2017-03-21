//
//  YCBaseTableView.m
//  yidao_driver
//
//  Created by YongCheHui on 2016/12/15.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "GHTableView.h"
#import "UITableViewCell+GHTableView.h"

@interface GHTableView()
@property(nonatomic,strong) NSMutableArray* cellHeights;
@property(nonatomic,strong) NSMutableDictionary* cell_dict;
@end

@implementation GHTableView
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)addCellCls:(Class)cellCls nib:(BOOL)nib
{
    if (nib) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellCls) bundle:nil] forCellReuseIdentifier:[cellCls cellIdentifier]];
    }
    else
    {
        [self registerClass:cellCls forCellReuseIdentifier:[cellCls cellIdentifier]];
    }
    [self.cell_dict setObject:cellCls forKey:[cellCls cellIdentifier]];
}

-(Class)cellClassWithCellId:(NSString*)cellId
{
    return self.cell_dict[cellId];
}

-(void)setup{
    self.cell_dict = [NSMutableDictionary new];
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell cellIdentifier]];
    self.datas = [NSMutableArray new];
    self.cellHeights = [NSMutableArray new];
    self.autoDeselect = YES;
    self.delegate = self;
    self.dataSource = self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.showSection) {
        NSArray* subArray = self.datas[section];
        if (![subArray isKindOfClass:[NSArray class]]) {
            NSAssert(YES, @"showSection为YES时，必须是二级结构");
            return 0;
        }
        return subArray.count;
    }
    else
    {
        return _datas.count;
    }
}


-(id)modelWithIndexPath:(NSIndexPath*)idp
{
    if (!self.showSection) {
        return self.datas[idp.row];
    }
    else
    {
        return self.datas[idp.section][idp.row];
    }
}

-(Class)cellClassWithIdp:(NSIndexPath*)idp
{
    if (self.cellClass_configureWithIndexPath) {
        return self.cellClass_configureWithIndexPath(idp);
    }
    else
    {
        return [UITableViewCell class];
    }
}

-(NSString*)cellIdentifierWithInp:(NSIndexPath*)idp
{
    return [[self cellClassWithIdp:idp] cellIdentifier];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self dequeueReusableCellWithIdentifier:[self cellIdentifierWithInp:indexPath] forIndexPath:indexPath];
    id model = [self modelWithIndexPath:indexPath];
    [cell gh_setIndexPath:indexPath];
    [cell gh_setModelData:model];
    if (self.refreshCell) {
        self.refreshCell(cell,model,indexPath);
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (_needCacheHeights) {
        if (self.showSection) {
            return [self.cellHeights[indexPath.section][indexPath.row]floatValue];
        }
        else
        {
            return [self.cellHeights[indexPath.row] floatValue];
        }
    }
    return [[self cellClassWithIdp:indexPath] gh_cellHeightWithModel:[self modelWithIndexPath:indexPath]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!self.showSectionHeaderTitle) {
        return 0.0;
    }
    if (self.sectionHeaderHeightHandler) {
        return self.sectionHeaderHeightHandler(section);
    }
    return 28.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (!self.showSectionFooterTitle) {
        return 0.0;
    }
    if (self.sectionHeaderHeightHandler) {
        return self.sectionHeaderHeightHandler(section);
    }
    return 28.f;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.showSectionHeaderTitle) {
        return self.sectionHeaderTitles[section];
    }
    else
    {
        return nil;
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (self.sectionFooterTitles) {
        return self.sectionFooterTitles[section];
    }
    else
    {
        return nil;
    }
}

-(BOOL)respondsToSelector:(SEL)aSelector
{
    if (aSelector == @selector(sectionIndexTitlesForTableView:)) {
        return self.showSectionRightBar;
    }
    return [super respondsToSelector:aSelector];
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionRightBarTitles?self.sectionRightBarTitles:(self.sectionHeaderTitles?self.sectionHeaderTitles:self.sectionFooterTitles);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.showSection) {
        return self.datas.count;
    }
    else
    {
        return 1;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.canEdit;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.canMove;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.editActionHandler) {
        self.editActionHandler(editingStyle,indexPath);
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (self.moveActionHandler) {
        self.moveActionHandler(sourceIndexPath,destinationIndexPath);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectHandler) {
        self.selectHandler([self modelWithIndexPath:indexPath],indexPath);
    }
    if (self.autoDeselect) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.sectionHeaderView) {
        NSString* sectionTitle = self.sectionRightBarTitles?self.sectionRightBarTitles[section]:self.sectionHeaderTitles[section];
        return self.sectionHeaderView(section,sectionTitle);
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.sectionFooterView) {
        NSString* sectionTitle = self.sectionRightBarTitles?self.sectionRightBarTitles[section]:self.sectionFooterTitles[section];
        return self.sectionFooterView(section,sectionTitle);
    }
    return nil;
}

-(void)refreshHeights:(BOOL)clear datas:(NSArray*)datas
{
    if (_needCacheHeights) {
        if (clear) { //是刷新 还是添加
            [self.cellHeights removeAllObjects];
        }
        if (_showSection) {
            int i = 0;
            for (NSArray* array in datas) {
                NSMutableArray* subArray = [NSMutableArray new];
                int j = 0;
                for (id model in array) {
                    NSIndexPath* idp = [NSIndexPath indexPathForRow:j inSection:i];
                    [subArray addObject:@([[self cellClassWithIdp:idp] gh_cellHeightWithModel:model])];
                    j++;
                }
                [self.cellHeights addObject:subArray];
                i++;
            }
        }
        else
        {
            int i = 0;
            for (id model in datas) {
                NSIndexPath* idp = [NSIndexPath indexPathForRow:i inSection:0];
                [self.cellHeights addObject:@([[self cellClassWithIdp:idp] gh_cellHeightWithModel:model])];
                i++;
            }
        }
    }
}

-(void)gh_setDatas:(NSArray*)datas
{
    self.datas = [datas mutableCopy];
    [self refreshHeights:YES datas:datas];
    [self reloadData];
}

-(void)gh_addDatas:(NSArray*)datas
{
    [self.datas addObject:datas];
    [self refreshHeights:NO datas:datas];
    [self reloadData];
}

-(void)setSectionFooterTitles:(NSArray *)sectionFooterTitles
{
    _sectionFooterTitles = sectionFooterTitles;
    self.showSectionFooterTitle = YES;
    [self reloadData];
}

-(void)setSectionHeaderTitles:(NSArray *)sectionHeaderTitles
{
    _sectionHeaderTitles = sectionHeaderTitles;
    self.showSectionHeaderTitle = YES;
    [self reloadData];
}

-(void)setSectionRightBarTitles:(NSArray *)sectionRightBarTitles
{
    _sectionRightBarTitles = sectionRightBarTitles;
    self.showSectionRightBar = YES;
    [self reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffset = scrollView.contentOffset.y;
    CGFloat distance = scrollView.contentSize.height - height;
    if (distance - contentYoffset <= 0) {
        if (self.scrollToBottomHandler) {
            self.scrollToBottomHandler();
        }
    }
}
@end
