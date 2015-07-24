//
//  FoodDetailTableViewCell.h
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 20/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@class FoodDetailTableViewCell;

@protocol FoodDetailTableViewCellDelegate <NSObject>
@optional
-(void)enterFoodTapped:(FoodDetailTableViewCell *)sender;
@end
   
@interface FoodDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) Portion *portion;
@property (weak, nonatomic) IBOutlet UIView *contentView1;
@property (weak, nonatomic) IBOutlet UILabel *portionNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *LeftLabel1;
@property (weak, nonatomic) IBOutlet UIView *contentView2;
@property (weak, nonatomic) IBOutlet UILabel *RightLabel1;
@property (weak, nonatomic) IBOutlet UILabel *LeftLabel2;
@property (weak, nonatomic) IBOutlet UILabel *RightLabel2;

@property (strong, nonatomic) id <FoodDetailTableViewCellDelegate> cellDelegate;

-(void)setCellData:(Portion *)cellData;
- (IBAction)enterTapped:(id)sender;

@end
