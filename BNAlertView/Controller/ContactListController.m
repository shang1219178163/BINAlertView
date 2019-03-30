//
//  ContactListController.m
//  BNAlertView
//
//  Created by hsf on 2018/10/18.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "ContactListController.h"

#import <ContactsUI/ContactsUI.h>

@interface ContactListController ()<CNContactPickerDelegate>

@end

@implementation ContactListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.title = @"联系人列表";
    
    [self createControls];
    
}

- (void)createControls{
    CNContactPickerViewController * contactPickerVc = [CNContactPickerViewController new];
    contactPickerVc.delegate = self;
    [self presentViewController:contactPickerVc animated:YES completion:nil];
    
}
#pragma mark - 选中一个联系人
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{

    NSLog(@"contact:%@",contact);
    for(CNLabeledValue * labeledValue in contact.phoneNumbers) {

        CNPhoneNumber * phoneNumber = labeledValue.value;
        NSLog(@"phoneNum:%@", phoneNumber.stringValue.stringByRemovingPercentEncoding);

    }

}

#pragma mark - 选中一个联系人属性

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
    NSLog(@"contactProperty:%@",contactProperty);
    
}

#pragma mark - 选中一个联系人的多个属性

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray*)contactProperties{
    
    NSLog(@"contactPropertiescontactProperties:%@",contactProperties);
    
}

#pragma mark - 选中多个联系人

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray*)contacts{
    
    NSLog(@"contactscontacts:%@",contacts);
    
    
}

#pragma mark - -touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self createControls];
    
}

@end
