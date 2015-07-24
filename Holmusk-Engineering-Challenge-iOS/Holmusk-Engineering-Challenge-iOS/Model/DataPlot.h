//
//  DataPlot.h
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 22/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPlot : NSObject

@property (nonatomic, assign) double yValue;
@property (nonatomic, strong) NSString *xValue;

-(id)initWithXValue:(NSString *)dateStr;

@end
