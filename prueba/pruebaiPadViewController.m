//
//  pruebaiPadViewController.m
//  prueba
//
//  Created by Alejandro on 1/24/13.
//  Copyright (c) 2013 somapps. All rights reserved.
//

#import "pruebaiPadViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface pruebaiPadViewController ()

@end

@implementation pruebaiPadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    // N.B. Even when the interface orientation indicates landscape mode
    // this may not really be true. So we insure this is so by testing
    // that the height of the view is less than the width
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        return YES;   
    }
    else
        return NO;
}

@end
