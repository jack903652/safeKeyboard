//
//  ViewController.m
//  SafeKeyboard
//
//  Created by bamq on 2017/11/30.
//  Copyright © bamq. All rights reserved
//

#import "ViewController.h"
#import "CustomKeyboard.h"
@interface ViewController ()
@property(nonatomic,strong)CGSafeTextField *safeTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat w = CGRectGetWidth([UIScreen mainScreen].bounds);
    _safeTextField = [[CGSafeTextField alloc] initWithFrame:CGRectMake((w -200)/2, 200, 200, 40)];
    _safeTextField.backgroundColor = [UIColor blueColor];
    _safeTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_safeTextField];
    CustomKeyboardView *keyboardView = [CustomKeyboardView createWithView:_safeTextField keyboardTypes:@[@(CustomKeyboardTypeCpicFunds),@(CustomKeyboardTypeDigital)] random:NO title:@"安全键盘" finishBtnTitle:nil length:8];
    keyboardView.allowTapFeedBack = YES;
    _safeTextField.isPlaintext = YES;
    UIColor *bColor = [UIColor colorWithWhite:0.850 alpha:1];
    keyboardView.cuBackgroundColor = bColor;
    keyboardView.cuItemColor = [UIColor whiteColor];
    keyboardView.cuItemDarkColor = [UIColor colorWithWhite:0.75 alpha:1];
    keyboardView.cuKeyColor = [UIColor blackColor];
    keyboardView.cuKeyFont = [UIFont systemFontOfSize:22 weight:(UIFontWeightRegular)];
    keyboardView.accessoryColor = [UIColor blackColor];
    keyboardView.accessoryFont = [UIFont systemFontOfSize:16 weight:(UIFontWeightRegular)];
//    keyboardView.accessoryBackgroundColor = [UIColor colorWithWhite:0.94 alpha:0];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 50, 40, 40);
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn1];
    btn1.frame = CGRectMake(100, 250, 40, 40);
    [btn1 addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor redColor];
    
    UITextField *tTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 300, 200, 40)];
    [tTextField addTarget:self action:@selector(tAction:) forControlEvents:UIControlEventEditingChanged];
    tTextField.secureTextEntry = YES;
    tTextField.backgroundColor = [UIColor lightGrayColor];
    tTextField.textColor= [UIColor redColor];
    [self.view addSubview:tTextField];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)click:(UIButton *)btn{
    btn.selected =!btn.selected;
    self.safeTextField.isPlaintext = btn.selected;
}

-(void)click1:(UIButton *)btn{
    NSLog(@"secureText:%@",self.safeTextField.secureText);
    NSLog(@"text:%@",self.safeTextField.text);
}
-(void)tAction:(UITextField *)textField{
    NSLog(@"%@",textField.text);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
