//
//  PCWidgetView.h
//  PiggyCash
//
//  Created by Christoph Pageler on 22.01.2017.
//  Copyright © 2017 Christoph Pageler. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface PCWidgetView : UIView

@property (strong, nonatomic) IBInspectable UIColor *borderColor;
@property (strong, nonatomic) IBInspectable UIColor *iconBackgroundColor;
@property (strong, nonatomic) IBInspectable UIImage *iconImage;

@property (strong, nonatomic) IBInspectable NSString *title;
@property (strong, nonatomic) IBInspectable UIColor *titleColor;

@property (nonatomic) IBInspectable BOOL kpiMode;
@property (strong, nonatomic) IBInspectable NSString *kpiValue;

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end
