//
//  UIViewController+UITableView.m
//  HuiZhuBang
//
//  Created by BIN on 2018/1/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UIViewController+UITableView.h"

#import <objc/runtime.h>

@implementation UIViewController (UITableView)

-(UITableView *)tableView{
    return objc_getAssociatedObject(self, _cmd);
    
}

-(void)setTableView:(UITableView *)tableView{
    objc_setAssociatedObject(self, @selector(tableView), tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(NSMutableDictionary *)heightMdict{
    return objc_getAssociatedObject(self, _cmd);

}

-(void)setHeightMdict:(NSMutableDictionary *)heightMdict{
    objc_setAssociatedObject(self, @selector(heightMdict), heightMdict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

//#pragma mark - UITableViewDelegate
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSNumber *height = self.heightMdict[indexPath];
//    if(height){
//        return height.floatValue;
//        
//    }
//    else{
//        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.backgroundColor = [UIColor redColor];
//        return 55;
//        
//    }
//}
//
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSNumber *height = @(cell.frame.size.height);
//    [self.heightMdict setObject:height forKey:indexPath];
//    
//}


@end
