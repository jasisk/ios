//
//  ViewController.m
//  iosgreatjob
//
//  Created by Jean-Charles Sisk on 4/17/15.
//  Copyright (c) 2015 Jean-Charles Sisk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
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
    
    [self presentViewController:self.picker
                       animated:YES
                     completion:^{
                         
                     }];
}

@end
