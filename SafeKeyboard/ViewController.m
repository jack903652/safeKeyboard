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
    _safeTextField = [[CGSafeTextField alloc] initWithFrame:CGRectMake((w -200)/2, 50, 200, 40)];
    _safeTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_safeTextField];
    CustomKeyboardView *keyboardView = [CustomKeyboardView createWithView:_safeTextField keyboardType:CustomKeyboardTypeLetter|CustomKeyboardTypeNumber|CustomKeyboardTypeCharacters|CustomKeyboardTypeDigital random:YES title:@"安全键盘" length:8];
    _safeTextField.isPlaintext = YES;
    keyboardView.cuBackgroundColor = [UIColor grayColor];
    keyboardView.cuItemColor = [UIColor whiteColor];
    keyboardView.cuItemDarkColor = [UIColor lightGrayColor];
    keyboardView.cuKeyColor = [UIColor blackColor];
    keyboardView.cuKeyFont = [UIFont systemFontOfSize:16 weight:(UIFontWeightHeavy)];
    keyboardView.accessoryColor = [UIColor blackColor];
    keyboardView.accessoryFont = [UIFont systemFontOfSize:16 weight:(UIFontWeightRegular)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)click:(UIButton *)btn{
    btn.selected =!btn.selected;
    self.safeTextField.isPlaintext = btn.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
