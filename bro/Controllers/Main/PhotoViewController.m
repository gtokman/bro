//
//  PhotoViewController.m
//  bro
//
//  Created by g tokman on 4/13/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "PhotoViewController.h"


@interface PhotoViewController () <AVCapturePhotoCaptureDelegate>
@property AVCaptureSession *session;
@property AVCaptureVideoPreviewLayer *previewLayer;
@property AVCaptureDevice *captureDevice;
@property AVCapturePhotoOutput *photoOutput;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupCaptureSession];
    
}

- (void)setupCaptureSession {
    
}

- (void)setupPreviewLayer {
    
}

- (void)startCaptureSession {
    if ([self.session isRunning]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [self.session startRunning];
        });
    }
}

- (void)stopCaptureSession {
    if ([self.session isRunning]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [self.session stopRunning];
        });
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

+ (PhotoViewController*)photoViewControllerFromStoryboardID {
    return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]
            instantiateViewControllerWithIdentifier:@"PhotoVC"];
}

@end
