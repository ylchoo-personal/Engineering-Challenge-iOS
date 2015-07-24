//
//  Portion.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "Portion.h"

@implementation Portion

+ (NSString *)primaryKey {
    return @"pk";
}

+ (NSArray *)ignoredProperties {
    return @[@"isSelected"];
}

-(id)initWithDictionary:(NSDictionary *)dict foodPk:(NSString *)foodPk{
    self = [super init];
    if (self) {
        _pk = [NSString stringWithFormat:@"%@_%@", foodPk, dict[@"name"]];
        _name = dict[@"name"];
        _nutrients = [[Nutrient alloc] initWithDictionary:dict[@"nutrients"] pk:_pk];
    }
    return self;
}

-(NutrientDetail *)getNutrientDetailForNutrient:(NSString *)nutrientName{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", nutrientName];
    RLMResults *result = [self.nutrients.important objectsWithPredicate:predicate];
    if (result.count > 0) {
        return [result lastObject];
    }
    
    result = [self.nutrients.extra objectsWithPredicate:predicate];
    if (result.count > 0) {
        return [result lastObject];
    }
    
    result = [self.nutrients.unhandled objectsWithPredicate:predicate];
    if (result.count > 0) {
        return [result lastObject];
    }
    
    return nil;
}

@end
