//
//  NutrientDetail.h
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface NutrientDetail : RLMObject

@property NSString *pk;
@property NSString *name;
@property NSString *unit;
@property float value;

-(id)initWithDictionary:(NSDictionary *)dict andName:(NSString *)name pk:(NSString *)pk;
-(NSString *)getValueUnit;

@end
RLM_ARRAY_TYPE(NutrientDetail)