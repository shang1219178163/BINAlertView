//
//  BINTableViewHandleSections.m
//  WeiHouBao
//
//  Created by hsf on 2017/9/26.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BINTableViewHandleSections.h"

@interface BINTableViewHandleSections ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *items ;
@property (nonatomic, copy) CellHeightBlock         heightConfigureBlock ;
@property (nonatomic, copy) ReturnCellBlock         returnCellBlock ;
@property (nonatomic, copy) DidSelectCellBlock      didSelectCellBlock ;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath ;

@property (nonatomic, assign) NSInteger sectionCountPer;

@end

@implementation BINTableViewHandleSections

- (id)initWithItems:(NSArray *)anItems
    cellHeightBlock:(CellHeightBlock)aHeightBlock
    returnCellBlock:(ReturnCellBlock)returnCellBlock
     didSelectBlock:(DidSelectCellBlock)didselectBlock
{
    self = [super init] ;
    if (self) {
        self.items = anItems ;
        self.heightConfigureBlock = aHeightBlock ;
        self.returnCellBlock = returnCellBlock ;
        self.didSelectCellBlock = didselectBlock ;
    }
    
    return self ;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.section] ;
}

- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table
{
    table.dataSource = self ;
    table.delegate   = self ;
}

#pragma mark --
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.sectionCountPer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    return self.returnCellBlock(tableView,indexPath,item) ;
}

#pragma mark --
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    return self.heightConfigureBlock(indexPath,item) ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    id item = [self itemAtIndexPath:indexPath] ;
    self.didSelectCellBlock(indexPath,item) ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.returnSectionViewBlock) {
        return self.returnSectionViewHeightBlock(section,YES);
    }else{
        return 0.0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.returnSectionViewBlock) {
        return self.returnSectionViewBlock(section,YES);
    }else{
        return nil;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (self.returnSectionViewBlock) {
        return self.returnSectionViewHeightBlock(section,NO);
    }else{
        return 0.0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (self.returnSectionViewBlock) {
        return self.returnSectionViewBlock(section,NO);
    }else{
        return nil;
    }
    
}

-(void)setSectionCount:(NSInteger)sectionCount{
    self.sectionCountPer = sectionCount;
    
}

-(void)setSectionRowCount:(NSInteger)sectionRowCount{
    self.sectionCountPer = sectionRowCount;
    
}

@end
