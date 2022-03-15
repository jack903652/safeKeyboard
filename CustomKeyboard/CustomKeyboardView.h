//
//  CustomKeyboardView.h
//  SwPractice
//
//  Created by bamq on 2017/5/31.
//  Copyright © bamq. All rights reserved
//

/*  usage
    CGFloat w = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGSafeTextField *safeTextField  = [[CGSafeTextField alloc] initWithFrame:CGRectMake((w -200)/2, 50, 200, 40)];
    safeTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:safeTextField];
    [CustomKeyboardView createWithView:safeTextField keyboardType:CustomKeyboardTypeLetter|CustomKeyboardTypeNumber|CustomKeyboardTypeCharacters random:YES title:@"安全键盘"];
*/
#import <UIKit/UIKit.h>
#import "CustomInputAccessoryView.h"

@interface CustomKeyboardView : UIView<UIInputViewAudioFeedback>
///背景颜色
@property(nonatomic,strong)UIColor *cuBackgroundColor;
///键盘背景颜色
@property(nonatomic,strong)UIColor *cuItemColor;
///键盘背景深色
@property(nonatomic,strong)UIColor *cuItemDarkColor;
///键盘颜色
@property(nonatomic,strong)UIColor *cuKeyColor;
///字体
@property(nonatomic,strong)UIFont *cuKeyFont;
///accessoryColor
@property(nonatomic,strong)UIColor *accessoryColor;
///accessoryColor
@property(nonatomic,strong)UIColor *accessoryBackgroundColor;
///accessoryFont
@property(nonatomic,strong)UIFont *accessoryFont;

-(instancetype)initWithView:(UIView<UIKeyInput> *)view keyboardType:(CustomKeyboardType)keyboardType random:(BOOL)random title:(NSString *)title;
-(instancetype)initWithView:(UIView<UIKeyInput> *)view keyboardType:(CustomKeyboardType)keyboardType random:(BOOL)random title:(NSString *)title finishBtnTitle:(NSString *)finishBtnTitle length:(NSInteger)length;

/**
 实例方法

 @param view textField
 @param keyboardType 键盘
 @param random 是否随机
 @param title 键盘标题
 @param length 是否限制长度,不限制传-1
 @return 实例
 */
+(instancetype)createWithView:(UIView<UIKeyInput> *)view keyboardType:(CustomKeyboardType)keyboardType random:(BOOL)random title:(NSString *)title finishBtnTitle:(NSString *)finishBtnTitle length:(NSInteger)length;
@end
