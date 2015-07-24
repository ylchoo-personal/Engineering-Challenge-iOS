//
//  RoundCornerView.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 20/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "RoundCornerView.h"

@implementation RoundCornerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//-(void)awakeFromNib{
//    self.layer.cornerRadius = _cornerRadius;
//    self.layer.borderColor = _borderColour.CGColor;
//    self.layer.borderWidth = _borderWidth;
//}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.layer.cornerRadius = _cornerRadius;
    self.layer.borderColor = _borderColour.CGColor;
    self.layer.borderWidth = _borderWidth;
    self.layer.masksToBounds = YES;
}

@end
