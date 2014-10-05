//
//  SHMActionViewController.m
//  SHMKit
//
//  Created by Matthew Dobson on 10/4/14.
//  Copyright (c) 2014 Matt Dobson. All rights reserved.
//

#import "SHMActionViewController.h"
#import "SHMEntityTableViewController.h"
#import <SHMKit/SHMActionField.h>

@interface SHMActionViewController ()

@property (nonatomic, retain) NSMutableDictionary *fields;
@property (nonatomic, retain) SHMEntity *retrievedEntity;

@end

@implementation SHMActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int fieldIncr = 0;
    self.fields = [[NSMutableDictionary alloc] init];
    for (SHMActionField *field in self.action.fields) {
        CGRect fieldFrame = CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMinY(self.view.frame) + 80 + fieldIncr, self.view.frame.size.width - 20, 44);
        if (field.type == Siren_Field_Hidden) {
            UILabel *hiddenLabel = [[UILabel alloc] initWithFrame:fieldFrame];
            hiddenLabel.text = [NSString stringWithFormat:@"%@ : %@", field.name, field.value];
            hiddenLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:hiddenLabel];
            
        } else if (field.type == Siren_Field_Text) {
            UITextField *textField = [[UITextField alloc] initWithFrame:fieldFrame];
            [self.view addSubview:textField];
            textField.placeholder = field.name;
            textField.textAlignment = NSTextAlignmentCenter;
            [self.fields setValue:textField forKey:field.name];
            [self.view addSubview:textField];
        }
        
        fieldIncr += 54;
    }
    
    CGRect buttonFrame = CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMinY(self.view.frame) + 80 + fieldIncr, self.view.frame.size.width - 20, 44);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:self.action.name forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = buttonFrame;
    [self.view addSubview:button];
}

- (void)setSHMAction:(SHMAction *)action {
    self.action = action;
}

- (void)submitAction {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (SHMActionField *field in self.action.fields) {
        if (field.type == Siren_Field_Hidden) {
            params[field.name] = field.value;
        } else if (field.type == Siren_Field_Text) {
            UITextField * input = (UITextField *)self.fields[field.name];
            params[field.name] = input.text;
        }
    }
    
    [self.action performActionWithFields:params andCompletion:^(NSError *err, SHMEntity *entity) {
        if(!err) {
            self.retrievedEntity = entity;
            [self performSegueWithIdentifier:@"unwind" sender:self];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"unwind"]) {
        NSLog(@"%@", self.retrievedEntity.properties);
        [segue.destinationViewController setEntity:self.retrievedEntity];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
