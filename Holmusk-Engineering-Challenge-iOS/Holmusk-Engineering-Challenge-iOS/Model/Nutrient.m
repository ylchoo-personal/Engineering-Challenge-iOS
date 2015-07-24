//
//  Nutrient.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "Nutrient.h"

@implementation Nutrient

+ (NSString *)primaryKey {
    return @"pk";
}

-(id)initWithDictionary:(NSDictionary *)dict pk:(NSString *)pk{
    self = [super init];
    if (self) {
        _pk = pk;
        NSDictionary *nutrientDict = dict[@"extra"];
        _extra = (RLMArray<NutrientDetail> *)[[RLMArray alloc] initWithObjectClassName:@"NutrientDetail"];
        if ([nutrientDict isKindOfClass:[NSDictionary class]]) {
            NSArray *allkey = [nutrientDict allKeys];
            for (NSString *key in allkey) {
                if (![nutrientDict[key] isKindOfClass:[NSNull class]]) {
                    [_extra addObject:[[NutrientDetail alloc] initWithDictionary:nutrientDict[key] andName:key pk:_pk]];
                }
            }
        }
        
        nutrientDict = dict[@"important"];
        _important = (RLMArray<NutrientDetail> *)[[RLMArray alloc] initWithObjectClassName:@"NutrientDetail"];
        if ([nutrientDict isKindOfClass:[NSDictionary class]]) {
            NSArray *allkey = [nutrientDict allKeys];
            for (NSString *key in allkey) {
                if (![nutrientDict[key] isKindOfClass:[NSNull class]]) {
                    [_important addObject:[[NutrientDetail alloc] initWithDictionary:nutrientDict[key] andName:key pk:_pk]];
                }
            }
        }
        
        _unhandled = (RLMArray<NutrientDetail> *)[[RLMArray alloc] initWithObjectClassName:@"NutrientDetail"];
        nutrientDict = dict[@"unhandled"];
        if ([nutrientDict isKindOfClass:[NSDictionary class]]) {
            NSArray *allkey = [nutrientDict allKeys];
            for (NSString *key in allkey) {
                if (![nutrientDict[key] isKindOfClass:[NSNull class]]) {
                    [_unhandled addObject:[[NutrientDetail alloc] initWithDictionary:nutrientDict[key] andName:key pk:_pk]];
                }
            }
        }
    }
    return self;
}

@end
