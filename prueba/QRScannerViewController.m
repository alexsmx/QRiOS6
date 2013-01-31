//
//  QRScannerViewController.m
//  prueba
//
//  Created by Alejandro on 1/28/13.
//  Copyright (c) 2013 somapps. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "QRScannerViewController.h"

@interface QRScannerViewController ()
@property (nonatomic, retain) ZXCapture* capture;

@property (weak, nonatomic) IBOutlet UITextView *decodedLabel;

@property (weak, nonatomic) IBOutlet UIView *vistaQR;

- (NSString*)displayForResult:(ZXResult*)result;

@end

@implementation QRScannerViewController


- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewWillAppear:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    if(animated){
        NSLog(@"prueba");
        [self.capture stop];
        self.decodedLabel = nil;
    }
}
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
    // Do any additional setup after loading the view, typically from a nib.
    self.capture = [[ZXCapture alloc] init];
    self.capture.delegate = self;
    self.capture.rotation = 0.0f;
    // Use the back camera
    self.capture.camera = self.capture.front;
    self.capture.layer.frame = self.vistaQR.bounds;
    [self.vistaQR.layer addSublayer:self.capture.layer];
    //   [self.view bringSubviewToFront:self.decodedLabel];
    CGAffineTransform xform = CGAffineTransformMakeRotation(M_PI/(-2.0));
    self.vistaQR.transform = xform;
    [self.capture start];

}


- (void)viewWillUnload{
    [self viewWillUnload];
    
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
#pragma mark - Private Methods

- (NSString*)displayForResult:(ZXResult*)result {
    NSString *formatString;
    switch (result.barcodeFormat) {
        case kBarcodeFormatAztec:
            formatString = @"Aztec";
            break;
            
        case kBarcodeFormatCodabar:
            formatString = @"CODABAR";
            break;
            
        case kBarcodeFormatCode39:
            formatString = @"Code 39";
            break;
            
        case kBarcodeFormatCode93:
            formatString = @"Code 93";
            break;
            
        case kBarcodeFormatCode128:
            formatString = @"Code 128";
            break;
            
        case kBarcodeFormatDataMatrix:
            formatString = @"Data Matrix";
            break;
            
        case kBarcodeFormatEan8:
            formatString = @"EAN-8";
            break;
            
        case kBarcodeFormatEan13:
            formatString = @"EAN-13";
            break;
            
        case kBarcodeFormatITF:
            formatString = @"ITF";
            break;
            
        case kBarcodeFormatPDF417:
            formatString = @"PDF417";
            break;
            
        case kBarcodeFormatQRCode:
            formatString = @"QR Code";
            break;
            
        case kBarcodeFormatRSS14:
            formatString = @"RSS 14";
            break;
            
        case kBarcodeFormatRSSExpanded:
            formatString = @"RSS Expanded";
            break;
            
        case kBarcodeFormatUPCA:
            formatString = @"UPCA";
            break;
            
        case kBarcodeFormatUPCE:
            formatString = @"UPCE";
            break;
            
        case kBarcodeFormatUPCEANExtension:
            formatString = @"UPC/EAN extension";
            break;
            
        default:
            formatString = @"Unknown";
            break;
    }
    
    return [NSString stringWithFormat:@"Scanned!\n\nFormat: %@\n\nContents:\n%@", formatString, result.text];
}


#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture*)capture result:(ZXResult*)result {
    if (result) {
        // We got a result. Display information about the result onscreen.
        [self.decodedLabel performSelectorOnMainThread:@selector(setText:) withObject:[self displayForResult:result] waitUntilDone:YES];
        
        // Vibrate
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [self.capture stop];
        
    }
}

- (void)captureSize:(ZXCapture*)capture width:(NSNumber*)width height:(NSNumber*)height {
    NSLog(@"Your message, here %@, %@",height,width);
}


@end
