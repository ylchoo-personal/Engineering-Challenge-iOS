//
//  Portion.h
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Nutrient.h"

@interface Portion : RLMObject

@property NSString *pk;
@property NSString *name;
@property Nutrient *nutrients;
@property BOOL isSelected;

-(id)initWithDictionary:(NSDictionary *)dict foodPk:(NSString *)foodPk;

-(NutrientDetail *)getNutrientDetailForNutrient:(NSString *)nutrientName;

@end
RLM_ARRAY_TYPE(Portion)
