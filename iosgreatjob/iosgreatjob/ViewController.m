//
//  ViewController.m
//  iosgreatjob
//
//  Created by Jean-Charles Sisk on 4/17/15.
//  Copyright (c) 2015 Jean-Charles Sisk. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController () <
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>

@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UIButton *button;
@property (nonatomic, strong) UIImage *image;

@end

@implementation ViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self takePicture];
    });
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.button.center = self.view.center;
    self.activityIndicator.frame = CGRectMake(floorf(self.view.frame.size.width/2 - floorf(self.activityIndicator.frame.size.width/2)),
                                              100,
                                              self.activityIndicator.frame.size.width,
                                              self.activityIndicator.frame.size.height);
    
}

#pragma mark - ViewController
- (void)takePicture {
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.picker.delegate = self;
    
    [self presentViewController:self.picker
                       animated:YES
                     completion:nil];
}

- (IBAction)buttonPressed:(id)sender {
    [self takePicture];
}

- (IBAction)uploadImage {
    [self.activityIndicator startAnimating];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSData *imageData = UIImageJPEGRepresentation(self.image, 0.6);
    [manager POST:@"http://sisk.io:8000" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"picture.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        [self.activityIndicator stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.activityIndicator stopAnimating];
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Upload Failed"
                                      message:@"Your picture failed to upload."
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Retry"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self uploadImage];
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];

        UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];

        [alert addAction:cancel];
        [alert addAction:ok];

        [self presentViewController:alert animated:YES completion:nil];
    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.picker dismissViewControllerAnimated:YES
                                    completion:nil];
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self uploadImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.picker dismissViewControllerAnimated:YES
                                    completion:nil];
}

@end
