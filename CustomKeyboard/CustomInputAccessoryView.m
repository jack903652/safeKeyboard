//
//  CustomInputAccessoryView.m
//  SwPractice
//
//  Created by bamq on 2017/5/31.
//  Copyright © bamq. All rights reserved
//

#import "CustomInputAccessoryView.h"
#define KEYBOARD_TYPE_LETTER @"Abc"
#define KEYBOARD_TYPE_CHARACTER @"#+="
#define KEYBOARD_TYPE_NUMBER @"12."
#define KEYBOARD_TYPE_DIGITAL @"数字"
#define KEYBOARD_TYPE_CPICFUNDS @"字母"
#define KEYBOARD_TYPE_ID @"id"
#define KEYBOARD_TYPE_ABC @"ABC"

@interface CustomInputAccessoryView()
@property(nonatomic,copy)void (^finishBlock)(void);
@property(nonatomic,strong)NSMutableArray *keyboardTitles;
///标题
@property(nonatomic,copy)NSString *finishBtnTitle;
@end
@implementation CustomInputAccessoryView
-(instancetype)initWithFrame:(CGRect)frame keyboardTypes:(NSArray *)keyboardTypes finishBtnTitle:(NSString *)finishBtnTitle{
    self =[super initWithFrame:frame];
    if (self) {
        _finishBtnTitle = finishBtnTitle;
        _keyboardTitles =[NSMutableArray array];
        NSArray *keyboardTypeNames = @[KEYBOARD_TYPE_NUMBER,KEYBOARD_TYPE_LETTER,KEYBOARD_TYPE_CHARACTER,KEYBOARD_TYPE_DIGITAL,KEYBOARD_TYPE_CPICFUNDS,KEYBOARD_TYPE_ID,KEYBOARD_TYPE_ABC];
        for (int i = 0; i<keyboardTypes.count; i++) {
            NSNumber *number = keyboardTypes[i];
            CustomKeyboardType type = number.intValue;
            NSString * title = [self keyboardStringFromType:type];
            if (title != nil){
                [_keyboardTitles addObject:title];
            }
        }

        if (_keyboardTitles.count >1) {
            _changeTypeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            _changeTypeBtn.frame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) -50-10), 4, 50, 40);
            [_changeTypeBtn setTitle:_keyboardTitles[1] forState:UIControlStateNormal];
            [_changeTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _changeTypeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            [_changeTypeBtn addTarget:self action:@selector(changeTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_changeTypeBtn];
        }
        
        _textLabel =[[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) -200)/2, 4, 200, CGRectGetHeight(self.bounds))];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
        
        if (_finishBtnTitle) {
            _finishBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            _finishBtn.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-50, 0, 50, 40);
            [_finishBtn setTitle:finishBtnTitle forState:UIControlStateNormal];
            [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _finishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [_finishBtn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_finishBtn];
        }
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
    }else if ([title isEqualToString:KEYBOARD_TYPE_CPICFUNDS]){
        return CustomKeyboardTypeCpicFunds;
    } else if ([title isEqualToString:KEYBOARD_TYPE_ID]){
        return CustomKeyboardTypeID;
    }else if ([title isEqualToString:KEYBOARD_TYPE_ABC]){
        return CustomKeyboardTypeABC;
    }  else{
        return CustomKeyboardTypeLetter;
    }
}

-(NSString *)keyboardStringFromType:(CustomKeyboardType)keyboardType{
    if (keyboardType &CustomKeyboardTypeNumber) {
        return KEYBOARD_TYPE_NUMBER;
    }
    else if (keyboardType &CustomKeyboardTypeLetter) {
        return KEYBOARD_TYPE_LETTER;
    }
    else if (keyboardType &CustomKeyboardTypeCharacters) {
        return KEYBOARD_TYPE_CHARACTER;
    }
    else if (keyboardType &CustomKeyboardTypeDigital) {
        return KEYBOARD_TYPE_DIGITAL;
    }
    else if (keyboardType &CustomKeyboardTypeCpicFunds) {
        return KEYBOARD_TYPE_CPICFUNDS;
    }
    else if (keyboardType &CustomKeyboardTypeID) {
        return KEYBOARD_TYPE_ID;
    }
    else if (keyboardType &CustomKeyboardTypeABC) {
        return KEYBOARD_TYPE_ABC;
    }else{
        return nil;
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
