//
//  CGSafeTextField.m
//  SafeKeyboard
//
//  Created by bamq on 2017/11/30.
//  Copyright © 2017年 Aresoft (Shanghai) Tech Co.,Ltd. All rights reserved.
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
    return NO;
}

@end
