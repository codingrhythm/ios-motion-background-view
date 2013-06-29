//
//  ViewController.m
//  Motion Background
//
//  Created by Zhu Yuzhou on 6/29/13.
//  Copyright (c) 2013 zhuyuzhou. All rights reserved.
//

#import "ViewController.h"
#import "UIMotionBackGroundView.h"

@interface ViewController (){

}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
	// Do any additional setup after loading the view, typically from a nib.
    
    UIMotionBackGroundView *motionBG = [[UIMotionBackGroundView alloc] initWithVisibleSize:self.view.frame.size
                                                                        andBackgroundImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:motionBG];
    
    // generate icon grid
    for (int i = 0; i <24; i++){
        int col = i % 4;
        int row = (i - col) / 4;
        UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(15 + col * 77, 15 + row * 87, 57, 57)];
        [iconView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:iconView];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
