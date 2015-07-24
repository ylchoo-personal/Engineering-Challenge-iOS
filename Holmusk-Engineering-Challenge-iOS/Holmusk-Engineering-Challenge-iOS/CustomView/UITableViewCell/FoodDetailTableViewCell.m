//
//  FoodDetailTableViewCell.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 20/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "FoodDetailTableViewCell.h"

@implementation FoodDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(Portion *)cellData{
    _portion = cellData;
    _portionNameLabel.text = cellData.name;
    
    if (cellData.isSelected) {
        NSMutableArray *array = [NSMutableArray new];
        for (NutrientDetail *detail in cellData.nutrients.important) {
            [array addObject:[detail getValueUnit]];
        }
        if (array.count > 0) {
            _LeftLabel1.text = [[cellData.nutrients.important valueForKey:@"name"] componentsJoinedByString:@"\n"];
            _RightLabel1.text = [array componentsJoinedByString:@"\n"];
            _contentView1.hidden = NO;
        }
        else{
            _LeftLabel1.text = @"";
            _RightLabel1.text = @"";
            _contentView1.hidden = YES;
        }
        
        array = [NSMutableArray new];
        for (NutrientDetail *detail in cellData.nutrients.extra) {
            [array addObject:[detail getValueUnit]];
        }
        if (array.count > 0) {
            _LeftLabel2.text = [[cellData.nutrients.extra valueForKey:@"name"] componentsJoinedByString:@"\n"];
            _RightLabel2.text = [array componentsJoinedByString:@"\n"];
            _contentView2.hidden = NO;
        }
        else{
            _LeftLabel2.text = @"";
            _RightLabel2.text = @"";
            _contentView2.hidden = YES;
        }
    }
    else{
        _LeftLabel1.text = @"";
        _RightLabel1.text = @"";
        _contentView1.hidden = YES;
        _LeftLabel2.text = @"";
        _RightLabel2.text = @"";
        _contentView2.hidden = YES;
    }
}

#pragma mark - IBAction
- (IBAction)enterTapped:(id)sender {
    if ([_cellDelegate respondsToSelector:@selector(enterFoodTapped:)]) {
        [_cellDelegate enterFoodTapped:self];
    }
}

@end
