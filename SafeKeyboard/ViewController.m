//
//  ViewController.m
//  SafeKeyboard
//
//  Created by bamq on 2017/11/30.
//  Copyright © 2017年 Aresoft (Shanghai) Tech Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import "CustomKeyboard.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat w = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGSafeTextField *safeTextField  = [[CGSafeTextField alloc] initWithFrame:CGRectMake((w -200)/2, 50, 200, 40)];
    safeTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:safeTextField];
    [CustomKeyboardView createWithView:safeTextField keyboardType:CustomKeyboardTypeLetter|CustomKeyboardTypeNumber|CustomKeyboardTypeCharacters random:YES title:@"安全键盘"];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
