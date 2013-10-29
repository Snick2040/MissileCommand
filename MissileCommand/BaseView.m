//
//  BaseView.m
//  MissileCommand
//
//  Created by Nick on 10/25/13.
//  Copyright (c) 2013 Nick. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initMakeBase{
    
    self = [super initWithFrame:CGRectMake(0, 0, 60, 20)];
    
    if(self){
        self.backgroundColor = [UIColor blueColor];
        _health = 100;
    }
    return self;
}

-(void)setBaseCenter:(CGPoint)centerPoint{
    
    int offSetX = (int)(self.frame.size.width / 2);
    int offSetY = (int)(self.frame.size.height / 2);
    
    //Use centerPoint as bottom center instead
    offSetX = 0;
    
    self.center = CGPointMake(centerPoint.x + offSetX, centerPoint.y - offSetY);
    
}

-(void)setHealth:(int)health{
    
    float blueColor = (float)health/100;
    float redColor = (100-(float)health)/100;
    
    self.backgroundColor = [UIColor colorWithRed:redColor green:0 blue:blueColor alpha:1.0];
    
    _health = health;
}

@end
