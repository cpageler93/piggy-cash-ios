//
//  PCWidgetView.m
//  PiggyCash
//
//  Created by Christoph Pageler on 22.01.2017.
//  Copyright © 2017 Christoph Pageler. All rights reserved.
//

#import "PCWidgetView.h"

@interface PCWidgetView ()

@property (strong, nonatomic) UIView *viewTopBar;
@property (strong, nonatomic) NSLayoutConstraint *lcViewTopBarHeight;
           
@property (strong, nonatomic) UIImageView *imageViewIcon;
@property (strong, nonatomic) NSLayoutConstraint *lcImageViewIconHeight;

@property (strong, nonatomic) UILabel *labelTitle;

@end

@implementation PCWidgetView

#pragma mark - init

- (instancetype)init
{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _borderColor = [UIColor grayColor];
    _iconImage = nil;
    _iconBackgroundColor = [UIColor grayColor];
    _kpiMode = YES;
    
    [self initViewTopBar];
    [self initImageViewIcon];
    [self initLabelTitle];
    
    [self updateAppearance];
}

- (void)initViewTopBar
{
    _viewTopBar = [UIView new];
    _viewTopBar.translatesAutoresizingMaskIntoConstraints = NO;
    _viewTopBar.backgroundColor = [UIColor clearColor];
    [self addSubview:_viewTopBar];
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:_viewTopBar
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeft
                                                       multiplier:1
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:_viewTopBar
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:_viewTopBar
                                                        attribute:NSLayoutAttributeRight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1
                                                         constant:0]
                           ]];
    _lcViewTopBarHeight = [NSLayoutConstraint constraintWithItem:_viewTopBar
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1
                                                        constant:100];
    [_viewTopBar addConstraint:_lcViewTopBarHeight];
    
    [self updateAppearance];
}

- (void)initImageViewIcon
{
    _imageViewIcon = [UIImageView new];
    _imageViewIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [_viewTopBar addSubview:_imageViewIcon];
    [_viewTopBar addConstraints:@[
                                  [NSLayoutConstraint constraintWithItem:_imageViewIcon
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_viewTopBar
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1
                                                                constant:20],
                                  [NSLayoutConstraint constraintWithItem:_imageViewIcon
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_viewTopBar
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0]
                                  ]];
    _lcImageViewIconHeight = [NSLayoutConstraint constraintWithItem:_imageViewIcon
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:100];
    [_imageViewIcon addConstraints:@[
                                     _lcImageViewIconHeight,
                                     [NSLayoutConstraint constraintWithItem:_imageViewIcon
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_imageViewIcon
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1
                                                                   constant:0]
                                     ]];
}

- (void)initLabelTitle
{
    _labelTitle = [UILabel new];
    _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [_viewTopBar addSubview:_labelTitle];
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:_labelTitle
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:_imageViewIcon
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1
                                                         constant:10],
                           [NSLayoutConstraint constraintWithItem:_labelTitle
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:_viewTopBar
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:_labelTitle
                                                        attribute:NSLayoutAttributeRight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:_viewTopBar
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1
                                                         constant:0]
                           ]];
}

#pragma mark - setter

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self updateAppearance];
}

- (void)setIconImage:(UIImage *)iconImage
{
    _iconImage = iconImage;
    [self updateAppearance];
}

- (void)setIconBackgroundColor:(UIColor *)iconBackgroundColor
{
    _iconBackgroundColor = iconBackgroundColor;
    [self updateAppearance];
}

- (void)setKpiMode:(BOOL)kpiMode
{
    _kpiMode = kpiMode;
    [self invalidateIntrinsicContentSize];
    [self updateAppearance];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self updateAppearance];
}

#pragma mark - update

- (void)updateAppearance
{
    self.layer.borderWidth = 1;
    self.layer.borderColor = _borderColor.CGColor;
    
    self.viewTopBar.layer.borderWidth = 1;
    self.viewTopBar.layer.borderColor = _borderColor.CGColor;
    
    _lcViewTopBarHeight.constant = _kpiMode ? [self intrinsicContentSize].height : 70;
    _lcImageViewIconHeight.constant = _kpiMode ? 50 : 40;
    [self layoutIfNeeded];
    
    _imageViewIcon.backgroundColor = _iconBackgroundColor;
    _imageViewIcon.layer.cornerRadius = _lcImageViewIconHeight.constant / 2;
    _imageViewIcon.layer.masksToBounds = YES;
    
    _labelTitle.text = _title;
}

#pragma mark - layout

- (CGSize)intrinsicContentSize
{
    CGSize s = [super intrinsicContentSize];
    if (_kpiMode) {
        s.height = 80;
    } else {
        s.height = 150;
    }
    return s;
}

- (CGSize)iconBackgroundSize
{
    return CGSizeMake(50, 50);
}

@end
