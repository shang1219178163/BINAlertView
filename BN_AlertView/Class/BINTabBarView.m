//
//  BINTabBarView.m
//  BN_AlertViewZero
//
//  Created by hsf on 2018/3/28.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "BINTabBarView.h"

@interface BINTabBarView()<UIScrollViewDelegate>

@property (strong, nonatomic, readwrite) NSArray *items;

@end

@implementation BINTabBarView

+ (BINTabBarView *)viewWithRect:(CGRect)frame items:(NSArray *)items{
    BINTabBarView * view = [[BINTabBarView alloc]initWithFrame:frame items:items];
    return view;
    
}

-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items{
    self = [super initWithFrame:frame];
    if (self) {
        NSAssert(items.count >= kCount_Item, @"items不能少于%@",@(kCount_Item));
        
        self.frame = frame;
        _items = items;
        
        _itemViews = [NSMutableArray arrayWithCapacity:0];
        _scrollTableViews = [NSMutableArray arrayWithCapacity:0];
        
        //top
        [self addSubview:self.topScrollView];
        [self.topScrollView addSubview:self.slideView];
        CGFloat itemWidth = CGRectGetWidth(self.slideView.frame);
        CGFloat contentSizeWidth =  _items.count <= kCount_Item ? CGRectGetWidth(self.frame) : itemWidth *  _items.count;
        self.topScrollView.contentSize = CGSizeMake(contentSizeWidth, kH_topView);
        
        //scrollView
        [self addSubview:self.scrollView];
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) *  _items.count, CGRectGetHeight(self.frame) - kH_topView);
        
    }
    return self;
    
}

#pragma mark -- scrollView的代理方法
///拖拽后调用的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    [self modifyTopScrollViewPositiong:scrollView];

}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.scrollView]) {
        _currentPage = self.scrollView.contentOffset.x/CGRectGetWidth(self.frame);
        [self updateTableWithPageNumber:_currentPage];
        DDLog(@"__%@",@(_currentPage));

        return;
    }
    [self modifyTopScrollViewPositiong:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([_scrollView isEqual:scrollView]) {
        
        CGRect frame = self.slideView.frame;
        NSInteger count =  _items.count < kCount_Item ?  _items.count : kCount_Item;
        frame.origin.x = scrollView.contentOffset.x/count;

        self.slideView.frame = frame;
        
    }
}

#pragma mark - - other Funtions

-(void)modifyTopScrollViewPositiong:(UIScrollView *)scrollView{
    if ([self.topScrollView isEqual:scrollView]) {
        CGFloat contentOffsetX = self.topScrollView.contentOffset.x;
        
        CGFloat itemWidth = CGRectGetWidth(self.slideView.frame);
        NSInteger count = (NSInteger)contentOffsetX / (NSInteger)itemWidth;
        CGFloat    step = (NSInteger)contentOffsetX % (NSInteger)itemWidth;
        CGFloat sumStep = itemWidth * count;
        if (step > itemWidth/2) {
            sumStep = itemWidth * (count + 1);
            
        }
        [self.topScrollView setContentOffset:CGPointMake(sumStep, 0) animated:YES];
        return;
    }
}

#pragma mark --根据scrollView的滚动位置复用tableView，减少内存开支
-(void)updateTableWithPageNumber:(NSUInteger)pageNumber{
    
    [self changeBackColorWithPage:pageNumber];
    
    NSInteger tabviewTag = pageNumber % 2;
    CGRect tableNewFrame = CGRectMake(pageNumber * CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - kH_topView);
    
    UITableView *reuseTableView = _scrollTableViews[tabviewTag];
    reuseTableView.frame = tableNewFrame;
    [reuseTableView reloadData];
    
    DDLog(@"tabviewTag__%@",@(tabviewTag));
}

- (void)changeBackColorWithPage:(NSInteger)currentPage {
    for (int i = 0; i < _itemViews.count; i ++) {
        UIView *tempView = _itemViews[i];
        
        UIButton *button = tempView.subviews[0];
        if (i == currentPage) {
            tempView.backgroundColor = [UIColor greenColor];
            button.titleLabel.textColor = [UIColor redColor];
        } else {
            tempView.backgroundColor = [UIColor grayColor];
            button.titleLabel.textColor = [UIColor whiteColor];
        }
    }
}

- (UIButton *)createBtnWithRect:(CGRect)rect title:(NSString *)title tag:(NSInteger)tag{
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    return button;
}

#pragma mark --点击顶部的按钮所触发的方法
-(void)handleActionBtn:(id)sender{
    UIButton *button = sender;
    [self.scrollView setContentOffset:CGPointMake(button.tag * CGRectGetWidth(self.frame), 0) animated:YES];
    
}

-(void)setSelectedPage:(NSInteger)selectedPage{
    [self.scrollView setContentOffset:CGPointMake(selectedPage * CGRectGetWidth(self.frame), 0) animated:YES];

}

#pragma mark - -layz
-(UIScrollView *)topScrollView{
    
    if (!_topScrollView) {
        CGFloat itemWidth = CGRectGetWidth(self.slideView.frame);
        
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), kH_topView)];
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.showsVerticalScrollIndicator = YES;
        _topScrollView.bounces = NO;
        _topScrollView.delegate = self;
        
        CGFloat contentSizeWidth =  _items.count <= kCount_Item ? CGRectGetWidth(self.frame) : itemWidth *  _items.count;
        _topScrollView.contentSize = CGSizeMake(contentSizeWidth, kH_topView);
        
        for (int i = 0; i <  _items.count; i ++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, kH_topView)];
            view.backgroundColor = i % 2 == 0 ? [UIColor lightGrayColor] : [UIColor grayColor];
            
            UIButton * button = [self createBtnWithRect:CGRectMake(0, 0, itemWidth, kH_topView) title:_items[i] tag:i];
            [view addSubview:button];
            
            [_itemViews addObject:view];
            [_topScrollView addSubview:view];
        }
        
    }
    return _topScrollView;
}

-(UIView *)slideView{
    if (!_slideView) {
        CGFloat itemWidth = CGRectGetWidth(self.frame) / kCount_Item;
        _slideView = [[UIView alloc] initWithFrame:CGRectMake(0, kH_topView - kH_slideView, itemWidth, kH_slideView)];
        _slideView.backgroundColor = [UIColor redColor];
        
    }
    return _slideView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kH_topView, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - kH_topView)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        
        //创建2个tableview左右滑动的时候互相复用
        for (NSInteger i = 0; i < 2; i ++) {
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - kH_topView)];
            //        tableView.delegate = self;
            //        tableView.dataSource = self;
            tableView.tag = i;
            
            [_scrollTableViews addObject:tableView];
            [_scrollView addSubview:tableView];
        }
    }
    return _scrollView;
}

//#pragma mark -- talbeView的代理方法
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSMutableArray *tempArray = _dataList[_currentPage];
//    return tempArray.count;
//}
//
//-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    static NSString * cellIdentifier = @"cell";
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//
//    if (cell == nil) {
//
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
//    }
//    //    cell.backgroundColor = [UIColor orangeColor];
//
//    if ([tableView isEqual:_scrollTableViews[_currentPage%2]]) {
//        cell.textLabel.text = _dataList[_currentPage][indexPath.row];
//    }else{
//        cell.textLabel.text = @"111111";
//    }
//
//    return cell;
//}
@end
