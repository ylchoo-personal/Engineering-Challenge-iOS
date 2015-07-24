//
//  AppSharedInstance.h
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSharedInstance : NSObject{
    NSDateFormatter *shortDateFormatter;
}

+(AppSharedInstance*)sharedInstance;

-(NSArray*)getFoodInfo:(NSString *)foodName;

-(NSString *)convertDateToString:(NSDate *)date;
-(NSDate *)convertStringToDate:(NSString *)dateStr;

@end
