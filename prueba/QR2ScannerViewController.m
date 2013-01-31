//
//  QR2ScannerViewController.m
//  prueba
//
//  Created by Alejandro on 1/28/13.
//  Copyright (c) 2013 somapps. All rights reserved.
//

#import "QR2ScannerViewController.h"

@interface QR2ScannerViewController ()
@property (weak, nonatomic) IBOutlet UITextView *texto;
@property (weak, nonatomic) IBOutlet UIView *vistaqr;

@property (weak,nonatomic) ZXCapture  *capture;
@end

@implementation QR2ScannerViewController
@synthesize capture;


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
    self.capture = [[ZXCapture alloc] init];
    self.capture.delegate = self;
    self.capture.rotation=90.0; 
    self.capture.camera = self.capture.back;
    self.capture.layer.frame = self.vistaqr.bounds;
    [self.vistaqr.layer addSublayer:self.capture.layer];
    [self.capture start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTexto:nil];
    [self setVistaqr:nil];
    [super viewDidUnload];
}


#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture*)capture result:(ZXResult*)result {
    if (result) {
        // We got a result. Display information about the result onscreen.
        //[self.decodedLabel performSelectorOnMainThread:@selector(setText:) withObject:[self displayForResult:result] waitUntilDone:YES];
        
        // Vibrate
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

- (void)captureSize:(ZXCapture*)capture width:(NSNumber*)width height:(NSNumber*)height {
    NSLog(@"Your message, here %@, %@",height,width);
}


@end
