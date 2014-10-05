//
//  SHMViewController.m
//  SHMKit
//
//  Created by Matt Dobson on 10/04/2014.
//  Copyright (c) 2014 Matt Dobson. All rights reserved.
//

#import "SHMViewController.h"
#import "SHMEntityTableViewController.h"
#import <SHMKit/SHMParser.h>
#import <SHMKit/SHMParser.h>

@interface SHMViewController ()

@property (nonatomic, retain) SHMParser *parser;
@property (nonatomic, strong) SHMEntity *retrievedEntity;

@end

@implementation SHMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getSirenEndpoint:(id)sender {
    NSString *uri = self.text.text;
    self.parser = [[SHMParser alloc] initWithSirenRoot:uri];
    [self.parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
        if (!err) {
            self.retrievedEntity = entity;
            [self performSegueWithIdentifier:@"entity" sender:self];
        }
    }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"entity"]) {
        [segue.destinationViewController setEntity:self.retrievedEntity];
    }
}

@end
