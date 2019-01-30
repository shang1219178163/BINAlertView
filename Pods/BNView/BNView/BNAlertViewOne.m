
//
//  BNAlertViewOne.m
//  BINAlertView
//
//  Created by hsf on 2018/5/25.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "BNAlertViewOne.h"

#import "BNGloble.h"
#import "BNCategory.h"

static CGFloat kH_title = 45;

@interface BNAlertViewOne ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView * containView;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) NSInteger count;

@end

@implementation BNAlertViewOne

#pragma mark - - LifeCycle

-(void)dealloc{
    [self.label removeObserver:self forKeyPath:@"text"];
    [self.containView removeObserver:self forKeyPath:@"frame"];
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionTap:)];
        [self addGestureRecognizer:tap];
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        self.label.frame = CGRectMake(0, 0, CGRectGetWidth(self.containView.frame), kH_title);
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.label.frame), CGRectGetWidth(self.containView.frame), CGRectGetHeight(self.containView.frame) - CGRectGetMaxY(self.label.frame));
        [self.containView addSubview:self.label];
        [self.containView addSubview:self.tableView];

       
        self.label.text = @"请选择";
        [self.label addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self.containView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];

        self.dataList = @[
                          @[
                              @{kItem_header  :   @"header_0",},
                              @{kItem_footer  :   @"footer_0",},
                              @{
                                  kItem_obj   :   @[
                                          @"去模型_00",
                                          @"去模型_01",
                                          @"去模型_02",
                                                    ],
                                  
                                  },
                              ],
                          @[
                              @{kItem_header  :   @"header_1",},
                              @{kItem_footer  :   @"footer_1",},
                              @{
                                  kItem_obj   :   @[
                                          @"去模型_10",
                                          @"去模型_11",
                                          @"去模型_12",
                                          ],
                                  
                                  },
                              ],
                          @[
                              @{kItem_header  :   @"header_2",},
                              @{kItem_footer  :   @"footer_2",},
                              @{
                                  kItem_obj   :   @[
                                          @"去模型_20",
                                          @"去模型_21",
                                          @"去模型_22",
                                          ],
                                  
                                  },
                              ],
                          ];
    }
    return self;
}


#pragma mark - - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"]) {
        
        CGRect rectLab = self.label.frame;
        rectLab.size.width = CGRectGetWidth(self.containView.frame);
        self.label.frame = rectLab;
        
        CGRect rect = self.tableView.frame;
        rect.size.height = CGRectGetHeight(self.containView.frame) - CGRectGetHeight(self.label.frame);
        self.tableView.frame = rect;

    }

    if ([keyPath isEqualToString:@"text"]) {
        if (!change[NSKeyValueChangeNewKey]) {
            self.label.frame = CGRectZero;
            self.tableView.frame = self.containView.bounds;
            
        } else {
            self.label.frame = CGRectMake(0, 0, CGRectGetWidth(self.containView.frame), kH_title);
            
        }
    }
}

- (void)getItemWithObj:(id)obj{
    if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]]){
        ++_count;
        
    }
    
    if([obj isKindOfClass:[NSArray class]]) {
        NSArray *objArr = obj;
        for(id item in objArr){
            [self getItemWithObj:item];
        }
    }
    
    if([obj isKindOfClass:[NSDictionary class]]){
        NSDictionary *objDic = obj;
        for(id key in objDic.allKeys){
            [self getItemWithObj:objDic[key]];
        }
    }

}

-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
    self.data = @{
                    kItem_obj    :   [dic sortedValuesByKey],
                    
                    };
    
}

-(void)setData:(id)data{
    _data = data;
    if ([_data isKindOfClass:[NSDictionary class]]) {
        
        NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
        [((NSDictionary *)_data) enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSAssert([key isEqualToString:kItem_header] || [key isEqualToString:kItem_footer] || [key isEqualToString:kItem_obj], @"key只能为kItem_header/kItem_footer/kItem_obj");
            NSDictionary * dic = @{key   :   obj};
            [marr addObject:dic];
            
        }];
        self.dataList = @[marr];
        
    }
}

- (void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    
    if (dataList.count == 0) {
        [UIWindow showToastWithTips:@"数组元素不能为空!" place:@1];
        DDLog(@"data_%@",self.data);
        return;
    }
    
    _count = 0;
    [self getItemWithObj:dataList];;
//    DDLog(@"count__%@",@(_count));
    

    CGFloat kH_tableView = _count*kH_CellHeight;
    CGFloat kH_label = CGRectGetHeight(self.label.frame);


    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.frame)*0.8, CGRectGetHeight(self.frame) - kH_CellHeight*2);
    CGFloat kH_contain = (kH_tableView + kH_label) < maxSize.height ? (kH_tableView + kH_label) : maxSize.height;
    
    CGRect rect = self.containView.frame;
    rect.size.width = maxSize.width;
    rect.size.height = kH_contain;
    self.containView.frame = rect;

    self.containView.center = self.center;

    [self.tableView reloadData];
}

- (void)handleActionTap:(UITapGestureRecognizer *)tap{
    self.indexPath = self.indexPath ? self.indexPath : [NSIndexPath indexPathForRow:0 inSection:0];
    [self dismiss];
    if (self.block) {
        self.block(self, self.indexPath);
    }
}

- (void)show{
    if (self.dataList.count == 1) {
        NSArray * array = [[self.dataList firstObject]firstObject][kItem_obj];
        if (array.count == 0) {
            [UIWindow showToastWithTips:@"暂无数据!" place:@1];
            return;
        }
    }
    
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    [window addSubview:self];
    [window addSubview:self.containView];
    
    [UIView animateWithDuration:0.15f animations:^{
        self.alpha = 1;
        
    } completion:nil];
    
}

- (void)dismiss{
    [UIView animateWithDuration:0.15f animations:^{
        self.alpha = 0;

    } completion:^(BOOL finished) {
        [self.containView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}


- (id)itemAtSection:(NSInteger)section key:(NSString *)key{
    NSArray *arraySection = self.dataList[section];
    
    for (NSDictionary *dic in arraySection) {
        if ([[dic.allKeys firstObject] isEqualToString:key]) {
            return  dic[key];
        }
    }
    return nil;
   
}

#pragma mark - -UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kH_CellHeight;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * array = [self itemAtSection:section key:kItem_obj];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * array = [self itemAtSection:indexPath.section key:kItem_obj];
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = array[indexPath.row];
    cell.textLabel.textColor = UIColor.themeColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.indexPath != indexPath) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.indexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        self.indexPath = indexPath.copy;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //    self.indexPath = indexPath;
    [self dismiss];
    if (self.block) {
        self.block(self, self.indexPath);
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSString * title = [self itemAtSection:section key:kItem_header];
    CGFloat height = !title ? 0.01 : kH_CellHeight;
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString * title = [self itemAtSection:section key:kItem_header];

    UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = title;
    label.textColor = UIColor.whiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = UIColor.greenColor;
    
    return label;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSString * title = [self itemAtSection:section key:kItem_footer];
    CGFloat height = !title ? 0.01 : kH_CellHeight;
    return height;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSString * title = [self itemAtSection:section key:kItem_footer];

    UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = title;
    label.textColor = UIColor.whiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = UIColor.yellowColor;

    return label;
    
}


#pragma mark - -funtions

+(instancetype)showTitle:(NSString *)title dic:(NSDictionary *)dic handler:(void (^)(BNAlertViewOne * view,NSIndexPath * indexPath))handler{
    BNAlertViewOne * view = [[BNAlertViewOne alloc]init];
    view.label.text = [title validObject] ? title : @"请选择";
    view.dic = dic;
    [view show];
    view.block = handler;
    return view;
}

#pragma mark - -layz

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            UITableView * tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
            tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.separatorInset = UIEdgeInsetsZero;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            //        tableView.separatorColor = UIColor.lineColor;
            tableView.backgroundColor = UIColor.greenColor;
            //        tableView.backgroundColor = UIColor.backgroudColor;
            
            tableView.estimatedRowHeight = 0.0;
            tableView.estimatedSectionHeaderHeight = 0.0;
            tableView.estimatedSectionFooterHeight = 0.0;
            tableView.rowHeight = 50;
            
            //背景视图
            //            UIView *view = [[UIView alloc]initWithFrame:tableView.bounds];
            //            view.backgroundColor = UIColor.cyanColor;
            //            tableView.backgroundView = view;
            tableView.bounces = NO;
            tableView;
        });
    }
    return _tableView;
}

-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 30)];
            lab.font = [UIFont systemFontOfSize:15];
            lab.textColor = UIColor.whiteColor;
            lab.textAlignment = NSTextAlignmentCenter;
            
            lab.numberOfLines = 0;
            lab.userInteractionEnabled = YES;
            lab.backgroundColor = UIColor.themeColor;
            
            lab;
        });
    }
    return _label;
}

-(UIView *)containView{
    if (!_containView) {
        _containView = ({
            UIView * view = [[UIView alloc]initWithFrame:self.bounds];
            view.backgroundColor = UIColor.redColor;
            
            view;
        });
    }
    return _containView;
}


@end
