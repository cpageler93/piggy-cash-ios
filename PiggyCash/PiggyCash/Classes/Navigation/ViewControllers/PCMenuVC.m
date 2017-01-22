//
//  PCMenuVC.m
//  PiggyCash
//
//  Created by Christoph Pageler on 21.01.2017.
//  Copyright © 2017 Christoph Pageler. All rights reserved.
//

#import "PCMenuVC.h"

@interface PCMenuVC ()

@end

@implementation PCMenuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - actions

- (IBAction)actionMenuItemDashboardTouchUpInside:(UIButton *)sender
{
    [_delegate menuVCDidSelectMenuItemAtIndex:0];
}

- (IBAction)actionMenuItemParticipantsTouchUpInside:(UIButton *)sender
{
    [_delegate menuVCDidSelectMenuItemAtIndex:1];;
}

@end
