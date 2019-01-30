//
//  BNRightView.m
//  BNCollectionView
//
//  Created by hsf on 2018/5/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNFilterView.h"

#import "BNGloble.h"
#import "BNCategory.h"

#import "BNGView.h"

static CGFloat kH_title = 35;
static CGFloat kH_View = 35;

static CGFloat kRatio_W = 0.75;

@interface BNFilterView ()<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic, strong) UISegmentedControl * segmentCtrl;

@property (nonatomic, strong) UIView * containView;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSMutableArray * viewList;

@property (nonatomic, strong) UIView * btnsView;

@end

@implementation BNFilterView

#pragma mark - - LifeCycle

#pragma mark - - sharedInstance
+ (instancetype)shared{
    static BNFilterView * instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BNFilterView alloc] init];
    });
    return instance;
}

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
        [self.containView addSubview:self.label];
        [self.containView addSubview:self.tableView];
        
        
        self.label.text = @"    筛选";
        self.direction = @0;
        

        CGRect rect = self.btnsView.frame;
        rect.origin.y = CGRectGetHeight(self.containView.frame) - 49;
        self.btnsView.frame = rect;
        [self.containView addSubview:self.btnsView];
        
        [self.label addObserver:self forKeyPath:@"text" options:0 context:nil];
        [self.containView addObserver:self forKeyPath:@"frame" options:0 context:nil];
        
//        self.dataList = @[
//                            @{
//                                kItem_header  :   @"时间",
////                                kItem_footer  :   @"footer_0",
//                                kItem_obj   :   @[
//                                                  @"去模型_00", @"去模型_01",
//                                                  ],
//                                kItem_objSeleted   :   @[
//                                                        @(YES),@(NO),
//
//                                                        ].mutableCopy,
//                                },
//                              @{
//                                kItem_header  :   @"状态",
////                                kItem_footer  :   @"footer_2",
//                                kItem_obj   :   @[
//                                                  @"去模型_30", @"去模型_31", @"去模型_32",
//                                                  @"去模型_33",
//
//                                                  ],
//                                kItem_objSeleted   :   @[
//                                                        @(YES),@(NO),@(NO),
//                                                        @(NO),
//
//                                                        ].mutableCopy,
//                                  },
//                          ];
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

- (void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    
    self.viewList = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * dic in _dataList) {
        NSParameterAssert([dic[kItem_obj] count] == [dic[kItem_objSeleted] count]);
        
        NSDictionary * params = @{
                               kGview_items :   dic[kItem_obj],
                               kGview_itemsSelected :   dic[kItem_objSeleted],

                               kGview_numberOfRow   :   @3,
                               kGview_itemHeight    :   @30,
                               kGview_padding       :   @10,
                               kGview_type          :   @0,
                               kGview_isSingle      :   @(YES),

                               };
        CGRect rect = CGRectMake(15, 15, CGRectGetWidth(self.tableView.frame) - 15*2, 0);
        BNGView * view = [BNGView viewRect:rect params:params];
        [self.viewList addObject:view];
  
    }
    
}

-(void)setDirection:(NSNumber *)direction{
    _direction = direction;
    
    switch ([_direction integerValue]) {
        case 1:
        {
            self.containView.frame = CGRectMake(-kScreenWidth*kRatio_W, 0, kScreenWidth*kRatio_W, kScreenHeight);
            
            self.label.frame = CGRectMake(0, 20, CGRectGetWidth(self.containView.frame), kH_title);
            self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.label.frame), CGRectGetWidth(self.containView.frame), CGRectGetHeight(self.containView.frame) - CGRectGetMaxY(self.label.frame));
        }
        break;
        default:
        {
            self.containView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth*kRatio_W, kScreenHeight);

            self.label.frame = CGRectMake(0, 20, CGRectGetWidth(self.containView.frame), kH_title);
            self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.label.frame), CGRectGetWidth(self.containView.frame), CGRectGetHeight(self.containView.frame) - CGRectGetMaxY(self.label.frame));
            
        }
            break;
    }
}

- (void)handleActionTap:(UITapGestureRecognizer *)tap{
    self.indexPath = self.indexPath ? self.indexPath : [NSIndexPath indexPathForRow:0 inSection:0];
    [self dismiss];
//    if (self.block) {
//        self.block(self, self.indexPath, nil);
//    }
}

- (void)handleActionSender:(UIButton *)sender{
    if (sender.tag == 0) {
        
        [self.dataList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = (NSDictionary *)obj;
            NSMutableArray * arrSelected = dic[kItem_objSeleted];
            [arrSelected enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [arrSelected replaceObjectAtIndex:idx withObject:@(NO)];;
                
            }];
            
            switch (idx) {
                case 0:
                    [arrSelected replaceObjectAtIndex:0 withObject:@(NO)];
                    break;
                    
                default:
                    [arrSelected replaceObjectAtIndex:0 withObject:@(YES)];
                    break;
            }
            
        }];
        
        [self.viewList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BNGView * view = obj;
            view.selectedList = self.dataList[idx][kItem_objSeleted];
            [view layoutSubviews];

        }];
        
    } else {
        [self dismiss];
        if (self.block) {
            self.block(self, self.indexPath, sender.tag);
        }
    }
}


- (void)show{
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    [window addSubview:self];
    [window addSubview:self.containView];


    [UIView animateWithDuration:0.35f animations:^{
        self.alpha = 1;

        CGRect rect = self.containView.frame;
        switch ([self.direction integerValue]) {
            case 1:
                rect.origin.x += CGRectGetWidth(self.containView.frame);

                break;
            default:
                rect.origin.x -= CGRectGetWidth(self.containView.frame);

                break;
        }
        self.containView.frame = rect;

    } completion:nil];
}

- (void)dismiss{
    [UIView animateWithDuration:0.15f animations:^{
        self.alpha = 0;

        CGRect rect = self.containView.frame;
        switch ([self.direction integerValue]) {
            case 1:
                rect.origin.x -= CGRectGetWidth(self.containView.frame);
                
                break;
            default:
                rect.origin.x += CGRectGetWidth(self.containView.frame);
                
                break;
        }
        self.containView.frame = rect;
        
    } completion:^(BOOL finished) {
        [self.containView removeFromSuperview];
        [self removeFromSuperview];

    }];
}

- (id)itemAtSection:(NSInteger)section key:(NSString *)key{
    NSDictionary *dic = self.dataList[section];
    return dic[key];
    
}

#pragma mark - -UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    BNGView * view = self.viewList[indexPath.section];
    CGFloat height = CGRectGetHeight(view.frame) + 15*2;
    return height;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray * array = [self itemAtSection:section key:kItem_obj];
//    return array.count;
    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * array = [self itemAtSection:indexPath.section key:kItem_obj];
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = array[indexPath.row];
    cell.textLabel.textColor = UIColor.themeColor;
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    
    BNGView * view = self.viewList[indexPath.section];
    [cell.contentView addSubview:view];
    
    view.isSingle = self.isSingle;
    view.block = ^(BNGView *view, id item, NSInteger idx) {
//        DDLog(@"___%@,%@,%@",@(indexPath.section),@(idx),view.selectedList);
        NSMutableArray * marr = [self itemAtSection:indexPath.section key:kItem_objSeleted];
        marr = view.selectedList;
        
//        DDLog(@"___%@,%@,%@",@(indexPath.section),@(idx),marr);
//        DDLog(@"_%@",self.dataList);
    };
    
    [cell getViewLayer];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return;
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
//    if (self.block) {
//        self.block(self, self.indexPath, self.segmentCtrl.selectedSegmentIndex);
//    }
//    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSString * title = [self itemAtSection:section key:kItem_header];
    CGFloat height = !title ? 0.01 : kH_View;
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString * title = [self itemAtSection:section key:kItem_header];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = [NSString stringWithFormat:@"    %@",title] ;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = UIColor.greenColor;
    return label;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSString * title = [self itemAtSection:section key:kItem_footer];
    CGFloat height = !title ? 0.01 : kH_View;
    return height;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSString * title = [self itemAtSection:section key:kItem_footer];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = [NSString stringWithFormat:@"    %@",title] ;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = UIColor.yellowColor;
    
    return label;
    
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
//            tableView.backgroundColor = UIColor.backgroudColor;
            tableView.backgroundColor = UIColor.whiteColor;

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
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), kH_title)];
            lab.font = [UIFont systemFontOfSize:16];
            lab.textColor = UIColor.whiteColor;
//            lab.textAlignment = NSTextAlignmentCenter;
            
            lab.numberOfLines = 0;
            lab.userInteractionEnabled = YES;
            lab.backgroundColor = UIColor.themeColor;
            
            lab.textColor = UIColor.blackColor;
            lab.backgroundColor = UIColor.backgroudColor;

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
            view.backgroundColor = UIColor.whiteColor;

            view;
        });
    }
    return _containView;
}

//-(UISegmentedControl *)segmentCtrl{
//    if (!_segmentCtrl) {
//        _segmentCtrl = ({
//            NSArray * items = @[@"重置",@"确定",];
//            UISegmentedControl * control = [[UISegmentedControl alloc] initWithItems:items];
//            control.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 40);
//
//            control.backgroundColor = UIColor.whiteColor;
//            control.tintColor = UIColor.themeColor;
//
//            control.selectedSegmentIndex = 0;
//            [control addTarget:self action:@selector(handleActionSender:) forControlEvents:UIControlEventValueChanged];
//
//            control;
//        });
//    }
//    return _segmentCtrl;
//}

-(UIView *)btnsView{
    if (!_btnsView) {
        _btnsView = ({
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containView.frame), 49)];
            NSArray * items = @[@"重置",@"确定",];
            
            view = [self addBtnList:items view:view];
            
//            CGRect rect = CGRectZero;
//            for (NSInteger i = 0; i < items.count; i++) {
//
//                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                rect = CGRectMake(CGRectGetMaxX(rect), 0, CGRectGetWidth(view.frame)/items.count, CGRectGetHeight(view.frame));
//                btn.frame = rect;
//                btn.tag = i;
//                btn.tintColor = UIColor.themeColor;
//                [btn setTitle:items[i] forState:UIControlStateNormal];
//                [btn addTarget:self action:@selector(handleActionSender:) forControlEvents:UIControlEventTouchUpInside];
//
//                btn.backgroundColor = i%2 == 0 ? UIColor.whiteColor : UIColor.themeColor;
//                UIColor *textColor = CGColorEqualToColor(UIColor.whiteColor.CGColor, btn.backgroundColor.CGColor)  ? UIColor.blackColor : UIColor.whiteColor;
//                [btn setTitleColor:textColor forState:UIControlStateNormal];
//
//                [view addSubview:btn];
//            }
            view;
        });
    }
    return _btnsView;
}


- (UIView *)addBtnList:(NSArray *)items view:(UIView *)view{
    CGRect rect = CGRectZero;
    for (NSInteger i = 0; i < items.count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        rect = CGRectMake(CGRectGetMaxX(rect), 0, CGRectGetWidth(view.frame)/items.count, CGRectGetHeight(view.frame));
        btn.frame = rect;
        btn.tag = i;
        btn.tintColor = UIColor.themeColor;
        [btn setTitle:items[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(handleActionSender:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.backgroundColor = i%2 == 0 ? UIColor.whiteColor : UIColor.themeColor;
        UIColor *textColor = CGColorEqualToColor(UIColor.whiteColor.CGColor, btn.backgroundColor.CGColor)  ? UIColor.blackColor : UIColor.whiteColor;
        [btn setTitleColor:textColor forState:UIControlStateNormal];
        
        [view addSubview:btn];
    }
    return view;
    
}


@end
