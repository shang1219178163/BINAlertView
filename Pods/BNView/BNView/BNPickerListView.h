//
//  BNPickerListView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BNPickerListView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * tips;

@property (nonatomic, strong) NSIndexPath * indexP;
@property (nonatomic, strong) NSMutableArray <NSArray *>* itemList;

@property (nonatomic, copy) void(^block)(BNPickerListView * view, NSIndexPath * indexP, NSString * text);

-(void)show;
-(void)dismiss;

@end


