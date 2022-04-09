//
//  CGSafeTextField.m
//  SafeKeyboard
//
//  Created by bamq on 2017/11/30.
//  Copyright © bamq. All rights reserved
//

#import "CGSafeTextField.h"

@implementation CGSafeTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return YES;
}

@end
