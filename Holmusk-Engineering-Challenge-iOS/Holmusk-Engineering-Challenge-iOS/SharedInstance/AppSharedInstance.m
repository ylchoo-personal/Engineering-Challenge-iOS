//
//  AppSharedInstance.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "AppSharedInstance.h"
#import <Realm/Realm.h>
#import "Food.h"

static AppSharedInstance * appInstance;

@implementation AppSharedInstance

+(AppSharedInstance*)sharedInstance {
    if (!appInstance) {
        appInstance = [[AppSharedInstance alloc] init];
        NSLog(@"%@", [RLMRealm defaultRealmPath]);
    }
    return appInstance;
}

-(NSArray*)getFoodInfo:(NSString *)foodName {
    // Call the foursquare API - here we use an NSData method for our API request,
    // but you could use anything that will allow you to call the API and serialize
    // the response as an NSDictionary or NSArray
    NSString *replacedStr = [foodName stringByReplacingOccurrencesOfString:@" " withString:@"&#32;"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"," withString:@"&#44;"];
    NSData *apiResponse = [[NSData alloc] initWithContentsOfURL:
                           [NSURL URLWithString:[NSString stringWithFormat:@"http://test.holmusk.com/food/search?q=%@", replacedStr]]];
    
    if (apiResponse) {
        // Serialize the NSData object from the response into an NSDictionary
        NSArray *serializedResponse = [NSJSONSerialization JSONObjectWithData:apiResponse
                                                                      options:kNilOptions
                                                                        error:nil];
        if ([serializedResponse isKindOfClass:[NSArray class]]) {
            NSMutableArray *objectArray = [NSMutableArray new];
            
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            // Save one Venue object (and dependents) for each element of the array
            for (NSDictionary *food in serializedResponse) {
                Food *foodObj = [[Food alloc] initWithDictionary:food];
                [Food createOrUpdateInDefaultRealmWithValue:foodObj];
                [objectArray addObject:foodObj];
            }
            [realm commitWriteTransaction];
            
            // Extract the venues from the response as an NSDictionary
            return objectArray;
        }
    }
    return nil;
}

-(NSString *)convertDateToString:(NSDate *)date{
    if (!shortDateFormatter) {
        shortDateFormatter = [NSDateFormatter new];
        [shortDateFormatter setDateFormat:@"d MMM yy"];
    }
    
    return [shortDateFormatter stringFromDate:date];
}

-(NSDate *)convertStringToDate:(NSString *)dateStr{
    if (!shortDateFormatter) {
        shortDateFormatter = [NSDateFormatter new];
        [shortDateFormatter setDateFormat:@"d MMM yy"];
    }
    
    return [shortDateFormatter dateFromString:dateStr];
}

@end
