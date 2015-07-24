//
//  NutrientDetail.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "NutrientDetail.h"

@implementation NutrientDetail

+ (NSString *)primaryKey {
    return @"pk";
}

-(id)initWithDictionary:(NSDictionary *)dict andName:(NSString *)name pk:(NSString *)pk{
    self = [super init];
    if (self) {
        _pk = [NSString stringWithFormat:@"%@_%@", pk, name];
        _name = name;
        _unit = dict[@"unit"];
        _value = [dict[@"value"] floatValue];
    }
    return self;
}

-(NSString *)getValueUnit{
    return [NSString stringWithFormat:@"%f %@", _value, _unit];
}

@end
