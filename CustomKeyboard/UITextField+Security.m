//
//  UITextField+Security.m
//  SwPractice
//
//  Created by bamq on 2017/5/31.
//  Copyright © 2017年 Aresoft (Shanghai) Tech Co.,Ltd. All rights reserved.
//

#import "UITextField+Security.h"
#import <objc/runtime.h>
static char strKey;
@implementation UITextField (Security)
-(void)setSecureText:(NSString *)secureText{
    objc_setAssociatedObject(self, &strKey, secureText, OBJC_ASSOCIATION_COPY);
//    if (secureText.length <1) {
//        self.text = nil;
//    }else{
//        NSMutableString *string = [[NSMutableString alloc] init];
//        for (int i = 0 ; i<secureText.length; i++) {
//            [string appendString:@"•"];
//        }
//        self.text = string;
//    }
}
-(NSString *)secureText{
    NSString *x = objc_getAssociatedObject(self, &strKey);
    if (x) {
        return  x;
    }else{
        return @"";
    }
}
@end
