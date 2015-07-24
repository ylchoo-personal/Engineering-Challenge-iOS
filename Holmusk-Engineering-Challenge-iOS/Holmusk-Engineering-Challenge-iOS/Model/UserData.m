//
//  UserData.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 22/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "UserData.h"
#import "AppSharedInstance.h"

@implementation UserData

+ (NSString *)primaryKey {
    return @"pk";
}

-(NSString *)getDateString{
    if (self.datetime) {
        return [[AppSharedInstance sharedInstance] convertDateToString:self.datetime];
    }
    else return @"";
}

@end
