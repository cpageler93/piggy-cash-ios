//
//  PCMenuVC.h
//  PiggyCash
//
//  Created by Christoph Pageler on 21.01.2017.
//  Copyright © 2017 Christoph Pageler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PCMenuVCDelegate <NSObject>
@required

- (void)menuVCDidSelectMenuItemAtIndex:(NSUInteger)index;

@end

@interface PCMenuVC : UIViewController

@property (weak, nonatomic) id<PCMenuVCDelegate> delegate;

@end
