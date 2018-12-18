//
//  UITextField+Security.h
//  SwPractice
//
//  Created by bamq on 2017/5/31.
//  Copyright © 2017年 Aresoft (Shanghai) Tech Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ASTERISK @"•"
#define WHITESPACE @" "
@interface UITextField (Security)
@property(nonatomic,strong)NSString *secureText;
@property(nonatomic,assign)BOOL isPlaintext;
@end
