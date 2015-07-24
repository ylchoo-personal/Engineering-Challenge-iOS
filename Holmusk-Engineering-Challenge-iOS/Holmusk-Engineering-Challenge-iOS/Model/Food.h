//
//  Food.h
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Portion.h"
#import "NSString+Additions.h"

@interface Food : RLMObject

@property NSString *id;
@property NSString *name;
@property RLMArray<Portion> *portions;
@property NSString *source;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
RLM_ARRAY_TYPE(Food)