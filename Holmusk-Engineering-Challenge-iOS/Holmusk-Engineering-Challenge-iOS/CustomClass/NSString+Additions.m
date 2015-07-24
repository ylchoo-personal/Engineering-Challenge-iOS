//
//  NSString+Additions.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 20/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString(Additions)

-(BOOL)isEmptyString
// Returns YES if the string is nil or equal to @""
{
    // Note that [string length] == 0 can be false when [string isEqualToString:@""] is true, because these are Unicode strings.
    NSString *string = self;
    if (((NSNull *) string == [NSNull null]) || (string == nil) ) {
        return YES;
    }
    string = [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

@end
