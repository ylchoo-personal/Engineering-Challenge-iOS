//
//  EnterAmountViewController.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 22/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "EnterAmountViewController.h"
#import <Realm/Realm.h>
#import "UIViewController+MJPopupViewController.h"

@interface EnterAmountViewController ()

@end

@implementation EnterAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    datePicker = [[UIDatePicker alloc] init];
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    _dateTimeTextField.inputView = datePicker;
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm aa, dd MMM yyyy"];
    
    _foodLabel.text = _userData.food.name;
    _portionLabel.text = _userData.selectedPortion.name;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextField delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _amountTextField) {
        if ([string isEqualToString:@"."]) {
            if ([textField.text rangeOfString:@"."].location != NSNotFound ) {
                return NO;
            }
        }
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _dateTimeTextField) {
        if (!_userData.datetime) {
            _userData.datetime = [NSDate date];
            _dateTimeTextField.text = [dateFormatter stringFromDate:_userData.datetime];
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _amountTextField) {
        _userData.value = [_amountTextField.text doubleValue];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _amountTextField) {
        [_dateTimeTextField becomeFirstResponder];
    }
    return NO;
}

#pragma mark - IBAction
- (IBAction)dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)confirmTapped:(id)sender {
    [self dismissKeyboard:nil];
    
    if (_userData.value > 0 && _userData.datetime) {
        //update userdata with pk and save to realm
        RLMResults *userDatas = [UserData allObjects];
        _userData.pk = [[userDatas maxOfProperty:@"pk"] intValue] + 1;
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [UserData createOrUpdateInDefaultRealmWithValue:_userData];
        [realm commitWriteTransaction];
        if ([_enterAmountDelegate respondsToSelector:@selector(dismissEnterAmountViewControllerPopup)]) {
            [_enterAmountDelegate dismissEnterAmountViewControllerPopup];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Please fill the needed info"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(IBAction)changeDate:(id)sender {
    _userData.datetime = datePicker.date;
    _dateTimeTextField.text = [dateFormatter stringFromDate:datePicker.date];
}

@end
