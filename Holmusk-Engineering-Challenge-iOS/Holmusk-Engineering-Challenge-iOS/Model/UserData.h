//
//  UserData.h
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 22/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Food.h"

@interface UserData : RLMObject

@property int pk;
@property Food *food;
@property Portion *selectedPortion;
@property double value;
@property NSDate *datetime;

-(NSString *)getDateString;

@end
