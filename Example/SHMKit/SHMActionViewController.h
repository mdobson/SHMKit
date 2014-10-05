//
//  SHMActionViewController.h
//  SHMKit
//
//  Created by Matthew Dobson on 10/4/14.
//  Copyright (c) 2014 Matt Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHMKit/SHMAction.h>

@interface SHMActionViewController : UIViewController

@property (nonatomic, strong) SHMAction *action;

- (void)setSHMAction:(SHMAction *)action;

@end
