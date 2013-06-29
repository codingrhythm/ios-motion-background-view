//
//  UIMotionBackGroundView.m
//  Motion Background
//
//  Created by Zhu Yuzhou on 6/29/13.
//  Copyright (c) 2013 zhuyuzhou. All rights reserved.
//

#import "UIMotionBackGroundView.h"
#import <CoreMotion/CoreMotion.h>

#define MOTION_FACTOR 25.0f
#define MOTION_THREADHOLD 0.8

@implementation UIMotionBackGroundView
{
    CMMotionManager *motionManager;
    double iniPicth;
    double pitchDiff;
    
    double iniRoll;
    double rollDiff;
    
    UIImage *bgImage;
    
    CGSize bgSize;
}

- (id)initWithVisibleSize:(CGSize)size andBackgroundImage:(UIImage *)image
{
    bgSize = CGSizeMake(size.width + 2 * MOTION_FACTOR, size.height + 2 * MOTION_FACTOR);
    bgImage = image;
    
    return [self initWithFrame:CGRectMake(-MOTION_FACTOR, -MOTION_FACTOR, bgSize.width, bgSize.height)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setImage:bgImage];
        [self setContentMode:UIViewContentModeScaleAspectFill];
        
        motionManager = [[CMMotionManager alloc] init];
        
        //Gyroscope
        if([motionManager isGyroAvailable])
        {
            /* Start the gyroscope if it is not active already */
            if([motionManager isGyroActive] == NO)
            {
                /* Update us 100 times a second */
                [motionManager setGyroUpdateInterval:1.0f/100.0f];
                
                /* Add on a handler block object */
                
                [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                                   withHandler: ^(CMDeviceMotion *motion, NSError *error)
                 {
                     CMAttitude *attitude = motion.attitude;
                     
                     if (iniPicth == 0){
                         iniPicth = attitude.pitch;
                     }else{
                         pitchDiff = attitude.pitch - iniPicth;
                         
                         pitchDiff = pitchDiff > MOTION_THREADHOLD ? MOTION_THREADHOLD : pitchDiff;
                         pitchDiff = pitchDiff < -MOTION_THREADHOLD ? -MOTION_THREADHOLD : pitchDiff;
                         
                     }
                     
                     if (iniRoll == 0){
                         iniRoll = attitude.roll;
                     }else{
                         rollDiff = attitude.roll - iniRoll;
                         
                         rollDiff = rollDiff > MOTION_THREADHOLD ? MOTION_THREADHOLD : rollDiff;
                         rollDiff = rollDiff < -MOTION_THREADHOLD ? -MOTION_THREADHOLD : rollDiff;
                     }
                     
                     [self setFrame:CGRectMake(-MOTION_FACTOR - (rollDiff * MOTION_FACTOR),
                                               -MOTION_FACTOR - (pitchDiff * MOTION_FACTOR),
                                               bgSize.width,
                                               bgSize.height)];
                 }];
                
            }
        }
        else
        {
            NSLog(@"Gyroscope not Available!");
        }

    }
    return self;
}

@end
