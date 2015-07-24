//
//  Nutrient.h
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "NutrientDetail.h"

@interface Nutrient : RLMObject

@property NSString *pk;
@property RLMArray<NutrientDetail> *unhandled;
@property RLMArray<NutrientDetail> *important;
@property RLMArray<NutrientDetail> *extra;

-(id)initWithDictionary:(NSDictionary *)dict pk:(NSString *)pk;

@end
RLM_ARRAY_TYPE(Nutrient)
