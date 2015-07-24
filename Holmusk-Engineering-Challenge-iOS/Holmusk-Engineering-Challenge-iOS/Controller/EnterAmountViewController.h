//
//  EnterAmountViewController.h
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 22/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"

@class EnterAmountViewController;

@protocol EnterAmountViewControllerDelegate <NSObject>
@optional
-(void)dismissEnterAmountViewControllerPopup;
@end

@interface EnterAmountViewController : UIViewController<UITextFieldDelegate>{
    UIDatePicker *datePicker;
    NSDateFormatter *dateFormatter;
}

- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)confirmTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *foodLabel;
@property (weak, nonatomic) IBOutlet UILabel *portionLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTimeTextField;

@property (strong, nonatomic) UserData *userData;

@property (strong, nonatomic) id <EnterAmountViewControllerDelegate> enterAmountDelegate;

@end
