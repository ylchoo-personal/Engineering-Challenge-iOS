//
//  MainViewController.h
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"
#import <Realm/Realm.h>
#import "UserData.h"

@interface MainViewController : UIViewController<BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>{
    NSDateFormatter *dateFormatter;
    NutrientDetail *selectedNutrientDetail;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) IBOutlet BEMSimpleLineGraphView *myGraph;
@property (nonatomic, weak) IBOutlet UIView *graphView;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@end
