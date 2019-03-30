//
//  BNTablePlainView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/22.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNTablePlainView.h"

#import "BNCategory.h"

@implementation BNTablePlainView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        
    }
    return self;
}

#pragma mark - - tableViewDelegate
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
    
    if (self.blockCellForRow != nil) {
        return self.blockCellForRow(tableView, indexPath);
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.blockDidSelectRow != nil) {
        return self.blockDidSelectRow(tableView, indexPath);
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView* table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
            table.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            table.separatorInset = UIEdgeInsetsZero;
            table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            table.rowHeight = 60;
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
