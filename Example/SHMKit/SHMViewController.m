//
//  SHMViewController.m
//  SHMKit
//
//  Created by Matt Dobson on 10/04/2014.
//  Copyright (c) 2014 Matt Dobson. All rights reserved.
//

#import "SHMViewController.h"
#import <SHMKit/SHMParser.h>
#import <SHMKit/SHMParser.h>

@interface SHMViewController ()

@property (nonatomic, retain) SHMParser *parser;

@end

@implementation SHMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.parser = [[SHMParser alloc] initWithSirenRoot:@"http://zetta-cloud-devices.herokuapp.com/"];
    [self.parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
        
    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
