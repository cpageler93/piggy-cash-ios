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
@property (strong, nonatomic) UILabel *labelKPIValue;

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
    _titleColor = [UIColor grayColor];
    
    [self initViewTopBar];
    [self initImageViewIcon];
    [self initLabelTitle];
    [self initLabelKPIValue];
    
    [self updateAppearance];
    [self updateContentView];
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
    if (_labelTitle) {
        [_labelTitle removeFromSuperview];
    }
    
    _labelTitle = [UILabel new];
    _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    if (_kpiMode) {
        _labelTitle.font = [UIFont fontWithName:@"Avenir-Black"
                                           size:14];
    } else {
        _labelTitle.font = [UIFont fontWithName:@"Avenir-Medium"
                                           size:20];
    }
    
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
                                                         constant:_kpiMode ? -14 : 0],
                           [NSLayoutConstraint constraintWithItem:_labelTitle
                                                        attribute:NSLayoutAttributeRight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:_viewTopBar
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1
                                                         constant:0]
                           ]];
}

- (void)initLabelKPIValue
{
    if (_labelKPIValue) {
        [_labelKPIValue removeFromSuperview];
    }
    
    if (_kpiMode) {
        _labelKPIValue = [UILabel new];
        _labelKPIValue.translatesAutoresizingMaskIntoConstraints = NO;
        _labelKPIValue.font = [UIFont fontWithName:@"Avenir-Black" size:20];
        [self addSubview:_labelKPIValue];
        [self addConstraints:@[
                               [NSLayoutConstraint constraintWithItem:_labelKPIValue
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_labelTitle
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1
                                                             constant:0],
                               [NSLayoutConstraint constraintWithItem:_labelKPIValue
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_labelTitle
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1
                                                             constant:2],
                               [NSLayoutConstraint constraintWithItem:_labelKPIValue
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_labelTitle
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1
                                                             constant:0]
                               ]];
    }
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
    [self initLabelTitle];
    [self invalidateIntrinsicContentSize];
    [self updateAppearance];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self updateAppearance];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self updateAppearance];
}

- (void)setKpiValue:(NSString *)kpiValue
{
    _kpiValue = kpiValue;
    [self updateAppearance];
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    [self updateContentView];
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
    _imageViewIcon.image = _iconImage;
    _imageViewIcon.contentMode = UIViewContentModeCenter;
    _imageViewIcon.layer.cornerRadius = _lcImageViewIconHeight.constant / 2;
    _imageViewIcon.layer.masksToBounds = YES;
    
    _labelTitle.text = _kpiMode ? [_title uppercaseString] : _title;
    _labelTitle.textColor = _titleColor;
    
    _labelKPIValue.alpha = _kpiMode ? 1 : 0;
    _labelKPIValue.textColor = _iconBackgroundColor;
    _labelKPIValue.text = _kpiValue;
}

- (void)updateContentView
{
    if (!_contentView) { return; }
    if (_contentView.superview != self) {
        [_contentView removeFromSuperview];
        [self addSubview:_contentView];
    }
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:_contentView
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeft
                                                       multiplier:1
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:_contentView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:_viewTopBar
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:_contentView
                                                        attribute:NSLayoutAttributeRight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:_contentView
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1
                                                         constant:0]
                           ]];
    
    [self invalidateIntrinsicContentSize];
}

#pragma mark - layout

- (CGSize)intrinsicContentSize
{
    CGSize s = [super intrinsicContentSize];
    
    if (_kpiMode) {
        s.height = 80;
    } else {
        CGFloat contentViewHeight = 200;
        if (_contentView) {
            CGSize contenteViewIntrinsticSize = [_contentView sizeThatFits:CGSizeMake(s.width, CGFLOAT_MAX)];
            if ([_contentView isKindOfClass:[UITableView class]]) {
                UITableView *tableViewContentView = (UITableView *)_contentView;
                contentViewHeight = tableViewContentView.contentSize.height;
            }
            contentViewHeight = contenteViewIntrinsticSize.height;
        }
        s.height = _lcViewTopBarHeight.constant + contentViewHeight;
    }
    return s;
}

- (CGSize)iconBackgroundSize
{
    return CGSizeMake(50, 50);
}

@end
