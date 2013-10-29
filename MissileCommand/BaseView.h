//
//  BaseView.h
//  MissileCommand
//
//  Created by Nick on 10/25/13.
//  Copyright (c) 2013 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

@property (nonatomic) int health;

-(id)initMakeBase;
-(void)setBaseCenter:(CGPoint)centerPoint;

@end
