//
//  BNPickerListView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNPickerListView.h"

#import "BNGloble.h"
#import "UIView+Helper.h"
#import "UIScreen+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


@interface BNPickerListView()

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * containView;
@property (nonatomic, strong) UIView * backView;

@property (nonatomic, strong) NSMutableArray * list;

@end

@implementation BNPickerListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = UIScreen.mainScreen.bounds;
        
        [self addSubview:self.containView];
        [self addSubview:self.backView];
        
        self.indexP = [NSIndexPath indexPathForRow:0 inSection:0];
        self.containView.originY = UIScreen.height;
        
        @weakify(self);
        [self.backView addGestureTap:^(UIGestureRecognizer *sender) {
            @strongify(self);
            [self dismiss];
        }];
        
    }
    return self;
}

#pragma mark -tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.rowHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.list[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.accessoryType = self.indexP == indexPath ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    if (self.indexP == indexPath) {
        if (self.block) {
            self.block(self, self.indexP, self.list[self.indexP.row]);
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.indexP != indexPath) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.indexP];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        self.indexP = indexPath.copy;
    }
    if (self.block) {
        self.block(self, indexPath, self.list[indexPath.row]);
    }
    [self dismiss];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = self.title != nil ? tableView.rowHeight : 0.01;
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat height = self.title != nil ? tableView.rowHeight : 0.01;
    return [UIView createSectionView:tableView text:self.title textAlignment:NSTextAlignmentCenter height:height];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = self.title != nil ? tableView.rowHeight : 0.01;
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGFloat height = self.title != nil ? tableView.rowHeight : 0.01;
    return [UIView createSectionView:tableView text:self.title textAlignment:NSTextAlignmentLeft height:height];
}

#pragma mark -funtions
-(void)setItemList:(NSMutableArray *)itemList{
    _itemList = itemList;
    
    [self.list removeAllObjects];
    [itemList enumerateObjectsUsingBlock:^(NSArray *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.list addObject:obj.firstObject];
    }];
    [self.tableView reloadData];
    
}

- (void)setupContainViewSize:(NSArray <NSString *>*)list{
    NSInteger rows = list.count + (self.title != nil ? 1 : 0) + (self.tips != nil ? 1 : 0);
    rows = rows < 6 ? rows : 6;
    
    self.containView.sizeHeight = self.tableView.rowHeight * rows;
}

-(void)show{
    [self setupContainViewSize:self.list];
//    assert(self.itemList != nil);
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    
    self.backView.sizeHeight = UIScreen.height - self.containView.sizeHeight;
    self.containView.originY = UIScreen.height;
    
    [UIView animateWithDuration:kDurationShow animations:^{
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
        self.containView.originY -= self.containView.sizeHeight;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)dismiss{
    [UIView animateWithDuration:kDurationShow animations:^{
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0];
        self.containView.originY = UIScreen.height;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

#pragma mark -lazy

-(UIView *)containView{
    if (!_containView) {
        _containView = [[UIView alloc]initWithFrame:self.bounds];
        [_containView addSubview:self.tableView];
    }
    return _containView;
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:self.bounds];
        _backView.backgroundColor = self.backgroundColor;
    }
    return _backView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            UITableView *view = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.separatorInset = UIEdgeInsetsZero;
            view.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            view.rowHeight = 60;
           
            //        table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
            [view registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
            if ([self conformsToProtocol:@protocol(UITableViewDataSource)]) view.dataSource = self;
            if ([self conformsToProtocol:@protocol(UITableViewDelegate)]) view.delegate = self;
            view;
        });
    }
    return _tableView;
}

-(NSMutableArray *)list{
    if (!_list) {
        _list = @[@"one",@"two",@"three"].mutableCopy;
    }
    return _list;
}

- (NSIndexPath *)indexP{
    if (!_indexP) {
        _indexP = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _indexP;
}

@end
