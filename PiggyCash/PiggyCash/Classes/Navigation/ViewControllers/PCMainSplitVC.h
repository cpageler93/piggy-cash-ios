//
//  MainSplitViewController.h
//  PiggyCash
//
//  Created by Christoph Pageler on 21.01.2017.
//  Copyright © 2017 Christoph Pageler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCMainSplitVC : UISplitViewController

@property (nonatomic, getter=isMasterCollapsed, readonly) BOOL masterCollapsed;
- (void)setMasterCollapsed:(BOOL)masterCollapsed
                  animated:(BOOL)animated;

- (void)selectMenuItemAtIndex:(NSUInteger)index;

@end
