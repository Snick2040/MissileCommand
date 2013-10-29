//
//  Utility.m
//  MissileCommand
//
//  Created by Nick on 10/24/13.
//  Copyright (c) 2013 Nick. All rights reserved.
//

#import "Utility.h"

@implementation Utility


// Gives you a number from 0 to maxnumber and returns an int
+(int)randomNumberBetweenZeroAnd:(int)maxNumber{
    int randomNum = arc4random() % maxNumber;
    return randomNum;
}


// C function
double randomFloat()
{
    return (double)rand() / (double)RAND_MAX ;
}

@end
