//
//  AddFoodViewController.h
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLPAutoCompleteTextField.h"
#import "RZCellSizeManager.h"
#import "FoodDetailTableViewCell.h"
#import "EnterAmountViewController.h"

@interface AddFoodViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, FoodDetailTableViewCellDelegate, EnterAmountViewControllerDelegate>{
    NSArray *foundFoodArray;
}

@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) RZCellSizeManager *sizeManager;

@end
