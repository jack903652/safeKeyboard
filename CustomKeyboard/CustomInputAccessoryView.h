//
//  CustomInputAccessoryView.h
//  SwPractice
//
//  Created by bamq on 2017/5/31.
//  Copyright © 2017年 Aresoft (Shanghai) Tech Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, CustomKeyboardType) {
    CustomKeyboardTypeLetter      = 1 << 0,
    CustomKeyboardTypeCharacters  = 1 << 1,
    CustomKeyboardTypeNumber      = 1 << 2,
    CustomKeyboardTypeDigital     = 1 << 3,
};
@interface CustomInputAccessoryView : UIView
@property(nonatomic,strong)UILabel *textLabel;
-(instancetype)initWithFrame:(CGRect)frame keyboardType:(CustomKeyboardType)keyboardType;
-(void)finishBlock:(void (^)(void))block;
@property(nonatomic,copy)void (^changeTypeBlock)(CustomKeyboardType);
@end
