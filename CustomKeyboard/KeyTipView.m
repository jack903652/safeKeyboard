//
//  KeyTipView.m
//  SafeKeyboard
//
//  Created by bamq on 2022/12/13.
//  Copyright © 2022 Aresoft (Shanghai) Tech Co.,Ltd. All rights reserved.
//

#import "KeyTipView.h"
#import "CustomKeyboard.h"
@interface KeyTipView()
///背景
@property(nonatomic,copy)UIImageView *backImageView;
@end
@implementation KeyTipView
//84,157
//50

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _backImageView.image = [CustomKeyboardView imageInBoundleWithName:@"keyTip.png"];
        _backImageView.highlightedImage = [CustomKeyboardView imageInBoundleWithName:@"keyTip.png"];
        [self addSubview:_backImageView];
        
        _tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _backImageView.frame.size.width, 80.0/157.0*frame.size.height)];
        [_backImageView addSubview:_tLabel];
        _tLabel.font = [UIFont boldSystemFontOfSize:28];
        _tLabel.textAlignment = NSTextAlignmentCenter;
        _tLabel.textColor = [UIColor blackColor];
    }
    return self;
}
-(void)updateFrame:(CGRect)frame{
    [_backImageView setFrame:frame];
    [_tLabel setFrame:CGRectMake(0, 0, _backImageView.frame.size.width, 75.0/157.0*frame.size.height)];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
