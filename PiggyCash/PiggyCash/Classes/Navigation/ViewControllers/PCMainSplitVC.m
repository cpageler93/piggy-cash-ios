//
//  MainSplitViewController.m
//  PiggyCash
//
//  Created by Christoph Pageler on 21.01.2017.
//  Copyright © 2017 Christoph Pageler. All rights reserved.
//

#import "PCMainSplitVC.h"

@interface PCMainSplitVC ()

@end

@implementation PCMainSplitVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMasterCollapsed:YES
                    animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - public methods

- (void)setMasterCollapsed:(BOOL)masterCollapsed
                  animated:(BOOL)animated
{
    CGFloat collapsedSize = 100;
    
    void(^animationBlock)(void) = ^(void) {
        self.minimumPrimaryColumnWidth = masterCollapsed ? collapsedSize : UISplitViewControllerAutomaticDimension;
        self.maximumPrimaryColumnWidth = masterCollapsed ? collapsedSize : UISplitViewControllerAutomaticDimension;
    };
    
    if (animated) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3
                                  delay:0
                 usingSpringWithDamping:1
                  initialSpringVelocity:0.3
                                options:0
                             animations:^{
                                 animationBlock();
                             }
                             completion:^(BOOL finished) {
                             }];
        });
    } else {
        animationBlock();
    }
}

@end
