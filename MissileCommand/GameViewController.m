//
//  GameViewController.m
//  MissileCommand
//
//  Created by Nick on 10/24/13.
//  Copyright (c) 2013 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameViewController.h"
#import "AsteroidView.h"
#import "BaseView.h"
#import "MissileView.h"
#import "Utility.h"
#import "ScoreTWC.h"

#define _w self.view.frame.size.width
#define _h self.view.frame.size.height

@interface GameViewController (){
    NSMutableArray * asteroidArray;
    NSMutableArray * baseArray;
    NSMutableArray * missileArray;
    NSTimer * spawnAsteroid;
    UIView * gameBoard;
    UIView * missileTurret;
    UILabel  * scoreLabel;
    int userScore;
    CADisplayLink *displayLink;

}

@end

@implementation GameViewController
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    asteroidArray = [[NSMutableArray alloc]init];
    missileArray = [[NSMutableArray alloc]init];
    
    gameBoard = [[UIView alloc]initWithFrame:CGRectMake(0, 20, _h, _w -20)];
//CGRectMake(0, _w * 0.1, _h, _w * 0.9)];
    gameBoard.backgroundColor = [UIColor blackColor];
    [self.view addSubview:gameBoard];
    
    [self spawnBases];
    
    [self addMissileTurret];
    
    userScore = 0;
    scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %i", userScore];
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.font = [UIFont systemFontOfSize:10];
    [gameBoard addSubview:scoreLabel];

    for (int i = 0; i < 2; i++) {[self spawnAsteroid];}
    
    spawnAsteroid = [NSTimer scheduledTimerWithTimeInterval:2.0f/2.0f
                                                target:self
                                              selector:@selector(spawnAsteroid)
                                              userInfo:nil
                                               repeats:YES];
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(stepWorld)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch * thisTouch = [touches anyObject];
    [self rotateTurrent:[thisTouch locationInView:gameBoard] hasFired:FALSE];
    //NSLog(@"%f, %f", [thisTouch locationInView:gameBoard].x, [thisTouch locationInView:gameBoard].y);
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * thisTouch = [touches anyObject];
    [self rotateTurrent:[thisTouch locationInView:gameBoard] hasFired:FALSE];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * thisTouch = [touches anyObject];
    [self rotateTurrent:[thisTouch locationInView:gameBoard] hasFired:TRUE];
}


-(void)rotateTurrent:(CGPoint)touchLocation hasFired:(BOOL)hasFired{
    
    CGPoint missileCenter = missileTurret.center;
    float angle = atan((missileCenter.y - touchLocation.y)/((missileCenter.x) - (touchLocation.x)));
    if ( touchLocation.x >= gameBoard.frame.size.width / 2) {
        angle = angle + M_PI;
    }
    
    missileTurret.transform = CGAffineTransformMakeRotation(angle + (M_PI/2));
    
    if (hasFired) {
        MissileView * thisMissile = [[MissileView alloc]initMakeMissile];
        
        thisMissile.center = missileCenter;
        thisMissile.transform = CGAffineTransformMakeRotation(angle + (M_PI/2));
        
        float velocity = 2;
        
        /*NSLog(@"x: %f, y: %f angle:%f",
              velocity * sin(angle + (M_PI/2)),
              velocity * cos(angle + (M_PI/2)),
              angle);*/
        angle = fabsf(angle);
        thisMissile.deltaX = -1 * velocity * sin(angle + (M_PI/2));
        thisMissile.deltaY = velocity * cos(angle + (M_PI/2));
        
        [missileArray addObject:thisMissile];
        [gameBoard addSubview:thisMissile];
        
    }
    
}

-(void)addMissileTurret{
    
    missileTurret = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 60)];
    missileTurret.center = CGPointMake((gameBoard.frame.size.width * 0.5),
                                       gameBoard.frame.size.height);
    missileTurret.backgroundColor = [UIColor redColor];
    [gameBoard addSubview:missileTurret];
    
    CALayer * imgLayer = [CALayer layer];
    imgLayer.frame = missileTurret.layer.bounds;
    imgLayer.contents = (id)[UIImage imageNamed:@"MissileTurrent.png"].CGImage;
    [missileTurret.layer addSublayer:imgLayer];
}


-(void)spawnBases{
    
    baseArray = [[NSMutableArray alloc]init];
    
    //Base 1
    BaseView * thisBase = [[BaseView alloc]initMakeBase];
    [thisBase setBaseCenter:CGPointMake(gameBoard.frame.size.width * 0.06,
                                        gameBoard.frame.size.height)];
    [gameBoard addSubview:thisBase];
    [baseArray addObject:thisBase];
    
    //Base 2
    thisBase = [[BaseView alloc]initMakeBase];
    [thisBase setBaseCenter:CGPointMake(gameBoard.frame.size.width * 0.21,
                                        gameBoard.frame.size.height)];
    [gameBoard addSubview:thisBase];
    [baseArray addObject:thisBase];
    
    //Base 3
    thisBase = [[BaseView alloc]initMakeBase];
    [thisBase setBaseCenter:CGPointMake(gameBoard.frame.size.width * 0.36,
                                        gameBoard.frame.size.height)];
    [gameBoard addSubview:thisBase];
    [baseArray addObject:thisBase];
    
    //Base 4
    thisBase = [[BaseView alloc]initMakeBase];
    [thisBase setBaseCenter:CGPointMake(gameBoard.frame.size.width * 0.64,
                                        gameBoard.frame.size.height)];
    [gameBoard addSubview:thisBase];
    [baseArray addObject:thisBase];
    
    //Base 5
    thisBase = [[BaseView alloc]initMakeBase];
    [thisBase setBaseCenter:CGPointMake(gameBoard.frame.size.width * 0.79,
                                        gameBoard.frame.size.height)];
    [gameBoard addSubview:thisBase];
    [baseArray addObject:thisBase];
    
    //Base 6
    thisBase = [[BaseView alloc]initMakeBase];
    [thisBase setBaseCenter:CGPointMake(gameBoard.frame.size.width * 0.94,
                                        gameBoard.frame.size.height)];
    [gameBoard addSubview:thisBase];
    [baseArray addObject:thisBase];
}

-(void)spawnAsteroid{
    
    AsteroidView * asteroid = [[AsteroidView alloc]initMakeAsteroid];
    
    int boardW = gameBoard.frame.size.width;
    int boardH = gameBoard.frame.size.height;
    
    //NSLog(@"w: %i, h: %i", boardW, boardH);
    
    int radX = (int)(boardW * randomFloat());
    int radY = (int)(0);
    //int disToBottom = boardH - radY;
    
    //NSLog(@"radx: %i, rady: %i", radX, radY);
    
    asteroid.center = CGPointMake(radX, radY);
    
    double angle1 = atan((-1 * radX)/boardH);
    double angle2 = atan((_w - radX)/boardH);
    double radAngle = ((angle2 - angle1) * randomFloat()) + angle1;
    
    double velocity = (3.0 * randomFloat()) + 1;
    
    asteroid.deltaX = sin(radAngle) * velocity;  //soh
    asteroid.deltaY = cos(radAngle) * velocity;  //cah
    
    [asteroidArray addObject:asteroid];
    [gameBoard addSubview:asteroid];
}

-(void)stepWorld{
    
    for(int missileIndex = 0; missileIndex < [missileArray count]; missileIndex++){
        MissileView * thisMissile = [missileArray objectAtIndex:missileIndex];
        thisMissile.center = CGPointMake(thisMissile.center.x + thisMissile.deltaX,
                                         thisMissile.center.y + thisMissile.deltaY);
        
        if (thisMissile.center.y < -50 ||
            thisMissile.center.x < -20 ||
            thisMissile.center.x > gameBoard.frame.size.width + 20)
        {
            //NSLog(@"Missile Removed");
            [thisMissile removeFromSuperview];
            [missileArray removeObject:thisMissile];
        }
    }
    
    BOOL missileDestroyedAnAsteroid = FALSE;
    for(int i = 0; i < [asteroidArray count]; i++){
        AsteroidView * thisAsteroid = [asteroidArray objectAtIndex:i];
        
        thisAsteroid.center = CGPointMake(thisAsteroid.center.x + thisAsteroid.deltaX,
                                          thisAsteroid.center.y + thisAsteroid.deltaY);
        
        missileDestroyedAnAsteroid = FALSE;
        for(int missileIndex = 0; missileIndex < [missileArray count]; missileIndex++){
            MissileView * thisMissile = [missileArray objectAtIndex:missileIndex];
            if(CGRectIntersectsRect(thisAsteroid.frame, thisMissile.frame)){
                
                [asteroidArray removeObject:thisAsteroid];
                [thisAsteroid removeFromSuperview];
                
                [missileArray removeObject:thisMissile];
                [thisMissile removeFromSuperview];
                missileDestroyedAnAsteroid = TRUE;
                
                userScore = userScore + 10;
                scoreLabel.text = [NSString stringWithFormat:@"Score: %i", userScore];
                
            }
        }
        
        if (!missileDestroyedAnAsteroid) {
        
            if (thisAsteroid.center.y > gameBoard.frame.size.height) {
                [thisAsteroid removeFromSuperview];
                [asteroidArray removeObject:thisAsteroid];
                //NSLog(@"Removed an Asteroid");
            } else{
                
                for(int baseIndex = 0; baseIndex < [baseArray count]; baseIndex++){
                    BaseView * thisBase = [baseArray objectAtIndex:baseIndex];
                    
                    if(CGRectIntersectsRect(thisAsteroid.frame, thisBase.frame)){
                        [asteroidArray removeObject:thisAsteroid];
                        [thisAsteroid removeFromSuperview];
                        
                        thisBase.health = thisBase.health - 10;
                        //NSLog(@"base: %i, health: %i", baseIndex, thisBase.health);
                        if (thisBase.health <= 0) {
                            NSLog(@"base: %i, health: %i", baseIndex, thisBase.health);
                            [baseArray removeObject:thisBase];
                            [thisBase removeFromSuperview];
                        }
                    }
                }
                
                if ([baseArray count]==0) {
                    [self performSegueWithIdentifier:@"ShowScore" sender:self];
                    [displayLink invalidate];
                    displayLink = nil;
                    break;
                }
            }
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowScore"]) {
        [segue.destinationViewController setNewScore:userScore];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
