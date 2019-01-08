//
//  BN_TabBarView.m
//  BN_AlertViewZero
//
//  Created by hsf on 2018/3/29.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "BN_TabBarView.h"

@interface BN_TabBarView()<UIScrollViewDelegate>


@property (strong, nonatomic, readwrite) NSArray *items;

@end

@implementation BN_TabBarView

-(UISegmentedControl *)segmentCtrl{
    
    if (!_segmentCtrl) {
        /*********************************************************************/
        _segmentCtrl = [[UISegmentedControl alloc] initWithItems:_items];
        _segmentCtrl.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), kH_topView);
        _segmentCtrl.backgroundColor = UIColor.whiteColor;
        _segmentCtrl.tintColor = [UIColor cyanColor];
        _segmentCtrl.selectedSegmentIndex = 0;
        _segmentCtrl.layer.borderWidth = 1;
        _segmentCtrl.layer.borderColor = UIColor.whiteColor.CGColor;
        
        NSDictionary * dict = @{
                                NSForegroundColorAttributeName :   [UIColor blackColor],
                                NSFontAttributeName            :   [UIFont systemFontOfSize:14],
                                
                                };
        
        [_segmentCtrl setTitleTextAttributes:dict forState:UIControlStateNormal];
        [_segmentCtrl addTarget:self action:@selector(handleActionSegment:) forControlEvents:UIControlEventValueChanged];
        [_segmentCtrl setDividerImage:[UIImage imageWithColor:UIColor.whiteColor] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    return _segmentCtrl;
    
}

- (void)handleActionSegment:(UISegmentedControl *)sender{
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * CGRectGetWidth(self.frame), 0) animated:YES];
    [self updateTableWithPageNumber:sender.selectedSegmentIndex];

}

+ (BN_TabBarView *)viewRect:(CGRect)frame items:(NSArray *)items{
    BN_TabBarView * view = [[BN_TabBarView alloc]initWithFrame:frame items:items];
    return view;
    
}

-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        _items = items;
        
        _scrollTableViews = [NSMutableArray arrayWithCapacity:0];
        
        //top
        [self addSubview:self.segmentCtrl];
 
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
        self.segmentCtrl.selectedSegmentIndex =_currentPage;
        [self updateTableWithPageNumber:_currentPage];
        DDLog(@"__%@",@(_currentPage));
        
        return;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([_scrollView isEqual:scrollView]) {
        
//        CGFloat itemWidth = CGRectGetWidth(self.frame)/_items.count;
//        NSInteger count = scrollView.contentOffset.x/itemWidth;
//        [self.segmentCtrl setSelectedSegmentIndex:count];
    }
}

#pragma mark - - other Funtions

#pragma mark --根据scrollView的滚动位置复用tableView，减少内存开支
-(void)updateTableWithPageNumber:(NSUInteger)pageNumber{
    
    NSInteger tabviewTag = pageNumber % 2;
    CGRect tableNewFrame = CGRectMake(pageNumber * CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - kH_topView);
    
    UITableView *reuseTableView = _scrollTableViews[tabviewTag];
    reuseTableView.frame = tableNewFrame;
    [reuseTableView reloadData];
    
    DDLog(@"tabviewTag__%@",@(tabviewTag));
}

-(void)setSelectedPage:(NSInteger)selectedPage{
    self.segmentCtrl.selectedSegmentIndex = selectedPage;
    [self.scrollView setContentOffset:CGPointMake(selectedPage * CGRectGetWidth(self.frame), 0) animated:YES];
    
}

#pragma mark - -layz
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kH_topView, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - kH_topView)];
        _scrollView.backgroundColor = UIColor.whiteColor;
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

@end
