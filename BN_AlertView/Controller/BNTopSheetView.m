//
//  BNTopSheetView.m
//  BN_AlertView
//
//  Created by Bin Shang on 2019/1/15.
//  Copyright © 2019 SouFun. All rights reserved.
//

#import "BNTopSheetView.h"

@implementation BNTopSheetView

-(void)dealloc{
    [self.btn.titleLabel removeObserver:self forKeyPath:@"text" context:nil];
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.btn.titleLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
   
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

#pragma mark - - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *itemList = self.list[indexPath.row];
    bool isHidden = [itemList[1] floatValue] <= 0.0  ? true : false;
    return isHidden == true ? 0.0 : tableView.rowHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *itemList = self.list[indexPath.row];

    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
//    cell.imageView.image = [UIImage imageNamed:@"dragon"];
    cell.textLabel.text = itemList[0];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    bool isHidden = [itemList[1] floatValue] <= 0.0  ? true : false;
    cell.hidden = isHidden;
    cell.accessoryType = self.indexP == indexPath ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    if (self.block != nil) {
        return self.block(tableView, indexPath);
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self dismiss];
    if (self.blockOne != nil) {
        self.blockOne(tableView, self.indexP);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - - observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        [self.btn sizeToFit];
        self.btn.titleEdgeInsets = UIEdgeInsetsMake(0, -CGRectGetWidth(self.btn.imageView.frame), 0, CGRectGetWidth(self.btn.imageView.frame));
        self.btn.imageEdgeInsets = UIEdgeInsetsMake(0, CGRectGetWidth(self.btn.titleLabel.frame) + 5.0, 0, -CGRectGetWidth(self.btn.titleLabel.frame) - 5.0);
    }
}

#pragma mark - - funtions

- (void)setupTitleView{
    @weakify(self)
    [self.btn addActionHandler:^(UIControl * _Nonnull obj) {
        @strongify(self);
        [UIApplication.sharedApplication.keyWindow endEditing:true];
        if (CGAffineTransformEqualToTransform(CGAffineTransformIdentity, self.btn.imageView.transform)) {
            [self show:self.parController];
            
        } else {
            [self dismiss];
            
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.parController.navigationItem.titleView = self.btn;
    
}

- (void)show:(UIViewController *)inController{
    [self.parController.view addSubview:self.containView];
    
    CGRect rect = self.tableView.frame;
    rect.origin.y = -CGRectGetHeight(self.tableView.frame);
    self.tableView.frame = rect;
    
    self.containView.alpha = 0;
    [UIView animateWithDuration:kAnimDuration animations:^{
        self.containView.alpha = 1.0;
        self.btn.imageView.transform = CGAffineTransformRotate(self.btn.imageView.transform, M_PI);
        
        CGRect rectTmp = self.tableView.frame;
        rectTmp.origin.y += CGRectGetHeight(self.tableView.frame);
        self.tableView.frame = rectTmp;
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:kAnimDuration animations:^{
        self.containView.alpha = 0.0;
        self.btn.imageView.transform = CGAffineTransformIdentity;
        
        CGRect rectTmp = self.tableView.frame;
        rectTmp.origin.y -= CGRectGetHeight(self.tableView.frame);
        self.tableView.frame = rectTmp;
    } completion:^(BOOL finished) {
        [self.containView removeFromSuperview];
        
    }];
}


- (void)setIndexP:(NSIndexPath *)indexP{
    _indexP = indexP;
    
    [self.tableView reloadData];
}

#pragma mark - -lazy
- (NSMutableArray *)list{
    if (!_list) {
        _list = [NSMutableArray array];
        _list = @[
                 @[@"标题名称:0", @"50.0",],
                 @[@"标题名称:1", @"50.0",],
                 @[@"标题名称:2", @"50.0",],
                 @[@"标题名称:3", @"50.0",],
                 @[@"标题名称:4", @"50.0",],
                 ].mutableCopy;
    }
    return _list;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = ({
            UIButton *view = [UIButton buttonWithType: UIButtonTypeCustom];
            [view setTitle:@"请选择" forState:UIControlStateNormal];
            view.frame = CGRectMake(0, 0, 150, 35);
            [view setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            [view setImage:UIImageNamed(kIMG_arrowDown) forState:UIControlStateNormal];
            
            view.adjustsImageWhenHighlighted = false;
            
            view.titleEdgeInsets = UIEdgeInsetsMake(0, -CGRectGetWidth(view.imageView.frame), 0, CGRectGetWidth(view.imageView.frame));
            view.imageEdgeInsets = UIEdgeInsetsMake(0, CGRectGetWidth(view.titleLabel.frame) + 5.0, 0, -CGRectGetWidth(view.titleLabel.frame) - 5.0);
            view;
        });
    }
    return _btn;
}

-(UIView *)containView{
    if (!_containView) {
        _containView = [[UIView alloc]initWithFrame:self.parController.view.bounds];
        _containView.backgroundColor = UIColorDim(0, 0.3);
        
        self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(_containView.frame), CGRectGetHeight(_containView.frame)*0.4);
        [_containView addSubview:self.tableView];
    }
    return _containView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView* table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
            table.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            table.separatorInset = UIEdgeInsetsZero;
            table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            table.rowHeight = 50;
            table.backgroundColor = UIColor.backgroudColor;
            //        table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
            [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
            if ([self conformsToProtocol:@protocol(UITableViewDataSource)]) table.dataSource = self;
            if ([self conformsToProtocol:@protocol(UITableViewDelegate)]) table.delegate = self;
            table;
        });
    }
    return _tableView;
}

@end
