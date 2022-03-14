//
//  KeyboardCollectionViewCell.m
//  SwPractice
//
//  Created by bamq on 2017/5/31.
//  Copyright © bamq. All rights reserved
//

#import "KeyboardCollectionViewCell.h"

@implementation KeyboardCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor darkTextColor];
        _textLabel = [[UILabel alloc] init];
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_textLabel];
        NSArray *constraints1 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_textLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel)];
        NSArray *constraints2 =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_textLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel)];
        [self addConstraints:constraints1];
        [self addConstraints:constraints2];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2.5;
        
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_imageView];
        NSArray *constraints3 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageView(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)];
        NSArray *constraints4 =[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageView(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self addConstraints:constraints3];
        [self addConstraints:constraints4];
//        [self addConstraint:constraints5];
//        [self addConstraint:constraints6];
        _imageView.hidden = YES;
    }
    return self;
}

@end

