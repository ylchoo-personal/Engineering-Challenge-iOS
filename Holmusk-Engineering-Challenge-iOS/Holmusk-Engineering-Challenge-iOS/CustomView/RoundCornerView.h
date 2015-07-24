//
//  RoundCornerView.h
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 20/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface RoundCornerView : UIView

@property IBInspectable UIColor *borderColour;
@property IBInspectable int borderWidth;
@property IBInspectable int cornerRadius;

@end
