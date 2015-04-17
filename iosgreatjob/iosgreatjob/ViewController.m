//
//  ViewController.m
//  iosgreatjob
//
//  Created by Jean-Charles Sisk on 4/17/15.
//  Copyright (c) 2015 Jean-Charles Sisk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>

@property (nonatomic, strong) UIImagePickerController *picker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.picker.delegate = self;
    
    [self presentViewController:self.picker
                       animated:YES
                     completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.picker dismissViewControllerAnimated:YES
                                    completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSDictionary *metaData = [info objectForKey:UIImagePickerControllerMediaMetadata];
    //NSLog(@"metaData: %@", metaData);
    NSLog(@"image: %@", image);
    
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.picker dismissViewControllerAnimated:YES
                                    completion:nil];
}

@end
