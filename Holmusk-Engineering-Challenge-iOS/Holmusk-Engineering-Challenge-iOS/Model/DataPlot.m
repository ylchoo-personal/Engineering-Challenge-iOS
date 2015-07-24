//
//  DataPlot.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 22/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "DataPlot.h"

@implementation DataPlot

-(id)initWithXValue:(NSString *)dateStr{
    self = [super init];
    if (self) {
        _xValue = dateStr;
        _yValue = 0;
    }
    return self;
}

@end
