//
//  SHMViewController.h
//  SHMKit
//
//  Created by Matt Dobson on 10/04/2014.
//  Copyright (c) 2014 Matt Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHMViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *text;

- (IBAction)getSirenEndpoint:(id)sender;

@end
