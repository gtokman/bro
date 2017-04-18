//
//  PhotoViewController.m
//  bro
//
//  Created by g tokman on 4/13/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "PhotoViewController.h"


@interface PhotoViewController () <AVCapturePhotoCaptureDelegate, ShareMediaDelegate>

@property AVCaptureSession *session;
@property AVCaptureVideoPreviewLayer *previewLayer;
@property AVCaptureDevice *captureDevice;
@property AVCapturePhotoOutput *photoOutput;
@property (weak, nonatomic) IBOutlet UIView *cameraPreviewLayer;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupCaptureSession];
    [self setupPreviewLayer];
    [self startCaptureSession];
}

#pragma mark - AVCaptureSession

- (void)setupCaptureSession {
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;

    // Input
    self.captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];
    if (error) {
        NSLog(@"Error adding capture device to input: %@", error.localizedDescription);
    }
    [self addInputToCaptureSession:deviceInput];

    // Output
    self.photoOutput = [[AVCapturePhotoOutput alloc] init];
    [self addOutputToCaptureSession:self.photoOutput];
}

- (void)addInputToCaptureSession:(AVCaptureInput *)input {
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
}

- (void)addOutputToCaptureSession:(AVCaptureOutput *)output {
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
}

- (void)setupPreviewLayer {
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.frame = self.cameraPreviewLayer.bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.cameraPreviewLayer.layer addSublayer:self.previewLayer];
}

- (void)startCaptureSession {
    if (![self.session isRunning]) {
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

#pragma mark - ShareMediaDelegate

- (void)didSelectUser:(BRUser *)user {
    NSLog(@"User %@", user.email);
}

#pragma mark - AVCapturePhotoCaptureDelegate

- (void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(nullable CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(nullable CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(nullable AVCaptureBracketedStillImageSettings *)bracketSettings error:(nullable NSError *)error {

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"UsersListSegue"]) {
        self.homeVC = [segue destinationViewController];
        self.homeVC.delegate = self;
    }
}

+ (PhotoViewController*)photoViewControllerFromStoryboardID {
    return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]
            instantiateViewControllerWithIdentifier:@"PhotoVC"];
}

@end
