//
//  MissileView.m
//  MissileCommand
//
//  Created by Nick on 10/29/13.
//  Copyright (c) 2013 Nick. All rights reserved.
//

#import "MissileView.h"

@implementation MissileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initMakeMissile{
    
    CGRect frame = CGRectMake(0, 0, 12, 24);
    
    self = [super initWithFrame:frame];
    
    if(self) {
        
        self.backgroundColor = [UIColor blueColor];
        
        _deltaX = 0.0;
        _deltaY = 0.0;
        
        //[self loadSprite];
        //self.transform = CGAffineTransformScale(CGAffineTransformIdentity, .5, .5);
        

    }
    return self;
}

@end
