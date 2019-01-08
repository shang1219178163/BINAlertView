//
//  TmpViewController.m
//  BN_AlertViewZero
//
//  Created by hsf on 2018/5/19.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "TmpViewController.h"

@interface TmpViewController ()


@property (nonatomic, assign) BOOL isOpen;//open
@property (nonatomic, strong) UIButton * btnFront;
@property (nonatomic, strong) UIButton * btnBack;

@property (nonatomic, strong) UIView * containView;
@property (nonatomic, strong) NSArray * items;


@end

@implementation TmpViewController

-(UIView *)containView{
    
    if (!_containView) {
        _containView = ({
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
            
            view;
        });
    }
    return _containView;
}

-(UIButton *)btnFront{
    if (!_btnFront) {
        _btnFront = ({
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
            [btn setBackgroundImage:[UIImage imageNamed:@"Twitter_round@2x"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            btn;
            
        });
    }
    return _btnFront;
    
}

-(UIButton *)btnBack{
    if (!_btnBack) {
        _btnBack = ({
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
            [btn setBackgroundImage:[UIImage imageNamed:@"Googleplus_round@2x"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];

            btn;
            
        });
    }
    return _btnBack;
    
}

- (void)handleActionBtn:(UIButton *)sender{
    _isOpen = !_isOpen;
    
    if (_isOpen == YES) {
        [UIView transitionFromView:self.btnFront toView:self.btnBack duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            
            
        }];
        
    }else{
        [UIView transitionFromView:self.btnBack toView:self.btnFront duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            
            
        }];
    }
}

- (void)handleActionBtnSub:(UIButton *)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.containView];
    
    [self.containView addSubview:self.btnBack];
    [self.containView addSubview:self.btnFront];
    
    _items = @[@"Pinterest_round@2x",@"post_type_bubble_chat@2x",@"post_type_bubble_link@2x",];
    
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < _items.count; i++) {
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        [btn setBackgroundImage:[UIImage imageNamed:_items[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(handleActionBtnSub:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.containView insertSubview:btn atIndex:0];
        [marr addObject:btn];
    }
    
    
   
    
    [self.view getViewLayer];

}

- (void)createControls{
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
    
    [self.view addSubview:containerView];
    
    UIView *fromView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    fromView.backgroundColor = [UIColor blueColor];
    UIView *toView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    toView.backgroundColor = [UIColor purpleColor];
    [containerView addSubview:fromView];
    
    [self.view addSubview:fromView];
    
    [CATransaction flush];
    [fromView addActionHandler:^(id obj, id item, NSInteger idx) {
        [UIView transitionFromView:fromView toView:toView duration:0.4f options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL];
        
        
    }];
    
    [toView addActionHandler:^(id obj, id item, NSInteger idx) {
        [UIView transitionFromView:toView toView:fromView duration:0.4f options:UIViewAnimationOptionTransitionFlipFromRight completion:NULL];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
