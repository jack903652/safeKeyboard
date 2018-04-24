//
//  CustomInputAccessoryView.m
//  SwPractice
//
//  Created by bamq on 2017/5/31.
//  Copyright © 2017年 Aresoft (Shanghai) Tech Co.,Ltd. All rights reserved.
//

#import "CustomInputAccessoryView.h"
#define KEYBOARD_TYPE_LETTER @"Abc"
#define KEYBOARD_TYPE_CHARACTER @"#+="
#define KEYBOARD_TYPE_NUMBER @"12."
#define KEYBOARD_TYPE_DIGITAL @"123"

@interface CustomInputAccessoryView()
@property(nonatomic,copy)void (^finishBlock)(void);
@property(nonatomic,strong)UIButton *finishBtn;
@property(nonatomic,strong)UIButton *changeTypeBtn;
@property(nonatomic,strong)NSMutableArray *keyboardTitles;
@end
@implementation CustomInputAccessoryView
-(instancetype)initWithFrame:(CGRect)frame keyboardType:(CustomKeyboardType)keyboardType{
    self =[super initWithFrame:frame];
    if (self) {
        _keyboardTitles =[NSMutableArray array];
        if (keyboardType &CustomKeyboardTypeNumber) {
            [_keyboardTitles addObject:KEYBOARD_TYPE_NUMBER];
        }
        if (keyboardType &CustomKeyboardTypeLetter) {
            [_keyboardTitles addObject:KEYBOARD_TYPE_LETTER];
        }
        if (keyboardType &CustomKeyboardTypeCharacters) {
            [_keyboardTitles addObject:KEYBOARD_TYPE_CHARACTER];
        }
        if (keyboardType &CustomKeyboardTypeDigital) {
            [_keyboardTitles addObject:KEYBOARD_TYPE_DIGITAL];
        }

        if (_keyboardTitles.count >1) {
            _changeTypeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            _changeTypeBtn.frame = CGRectMake(0, 0, 50, 40);
            [_changeTypeBtn setTitle:_keyboardTitles[1] forState:UIControlStateNormal];
            [_changeTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _changeTypeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [_changeTypeBtn addTarget:self action:@selector(changeTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_changeTypeBtn];
        }
        
        _textLabel =[[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) -200)/2, 0, 200, CGRectGetHeight(self.bounds))];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
        
        _finishBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _finishBtn.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-50, 0, 50, 40);
        [_finishBtn setTitle:NSLocalizedStringFromTable(@"完成", @"CustomKeyboard", nil) forState:UIControlStateNormal];
        [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_finishBtn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_finishBtn];
        
    }
    return self;
}
-(CustomKeyboardType)keyboardFromString:(NSString *)title{
    if ([title isEqualToString:KEYBOARD_TYPE_LETTER]) {
        return CustomKeyboardTypeLetter;
    }else if ([title isEqualToString:KEYBOARD_TYPE_CHARACTER]){
        return CustomKeyboardTypeCharacters;
    }else if ([title isEqualToString:KEYBOARD_TYPE_NUMBER]){
        return CustomKeyboardTypeNumber;
    }else if ([title isEqualToString:KEYBOARD_TYPE_DIGITAL]){
        return CustomKeyboardTypeDigital;
    } else{
        return CustomKeyboardTypeLetter;
    }
}
-(void)changeTypeAction:(UIButton *)sender{
    NSString *text = [sender titleForState:UIControlStateNormal];
    NSInteger idx = [self.keyboardTitles indexOfObject:text];
    NSInteger currentIdx = (idx +1) % self.keyboardTitles.count;
    [self.changeTypeBtn setTitle:self.keyboardTitles[currentIdx] forState:UIControlStateNormal];
    if (self.changeTypeBlock) {
        self.changeTypeBlock([self keyboardFromString:text]);
    }
    
}

-(void)finishBlock:(void (^)(void))block{
    self.finishBlock =block;
}
-(void)finishAction:(UIButton *)sender{
    if (self.finishBlock) {
        self.finishBlock();
    }
}
@end
