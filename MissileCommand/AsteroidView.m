//
//  AsteroidView.m
//  MissileCommand
//
//  Created by Nick on 10/24/13.
//  Copyright (c) 2013 Nick. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "AsteroidView.h"
#import "MCSpriteLayer.h"


@implementation AsteroidView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initMakeAsteroid{
    
    CGRect frame = CGRectMake(0, 0, 40, 40);
    
    self = [super initWithFrame:frame];
    
    if(self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _deltaX = 0.0;
        _deltaY = 0.0;
        
        [self loadSprite];
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, .5, .5);
    }
    return self;
}

-(void)loadSprite{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"asteroid.png" ofType:nil];
    CGImageRef img = [UIImage imageWithContentsOfFile:path].CGImage;
    //NSLog(path);
    
    CGSize fixedSize = CGSizeMake(64, 64);
    MCSpriteLayer * asteroid = [MCSpriteLayer layerWithImage:img sampleSize:fixedSize];
    asteroid.position = self.center;//CGPointMake(32,32);

    CABasicAnimation * anim = [CABasicAnimation animationWithKeyPath:@"sampleIndex"];
    anim.fromValue = [NSNumber numberWithInt:1]; // initial frame
    anim.toValue = [NSNumber numberWithInt:30]; // last frame + 1
    anim.duration = 1.0f; // from the first frame to the 6th one in 1 second
    anim.repeatCount = HUGE_VALF; // just keep repeating it
    anim.autoreverses = NO; // do 1, 2, 3, 4, 5, 4, 3, 2
    
    [asteroid addAnimation:anim forKey:nil]; // start
    
    [self.layer addSublayer:asteroid];
}

@end









