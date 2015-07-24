//
//  Food.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "Food.h"

@implementation Food

+ (NSArray *)indexedProperties {
    return @[@"name"];
}

+ (NSString *)primaryKey {
    return @"id";
}

-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _id = dict[@"_id"];
        _name = dict[@"name"];
        _portions = (RLMArray<Portion> *)[[RLMArray alloc] initWithObjectClassName:@"Portion"];
        for (NSDictionary *tempDict in dict[@"portions"]) {
            Portion *portion = [[Portion alloc] initWithDictionary:tempDict foodPk:_id];
            [_portions addObject:portion];
        }
        _source = dict[@"source"];
    }
    return self;
}

@end
