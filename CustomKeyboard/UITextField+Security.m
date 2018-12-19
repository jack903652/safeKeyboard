//
//  UITextField+Security.m
//  SwPractice
//
//  Created by bamq on 2017/5/31.
//  Copyright © bamq. All rights reserved
//

#import "UITextField+Security.h"
#import <objc/runtime.h>
static char secureKey;
static char strKey;
@implementation UITextField (Security)
@dynamic isPlaintext;
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
-(void)setIsPlaintext:(BOOL)isPlaintext{
    objc_setAssociatedObject(self, &secureKey, @(isPlaintext), OBJC_ASSOCIATION_COPY);
    if (isPlaintext) {
        self.text = self.secureText;
    }else{
        NSMutableString *d = [NSMutableString stringWithString:@""];
        for (int i = 0 ; i<self.secureText.length; i++) {
            [d appendString:ASTERISK];
        }
        self.text = d;
    }
}
-(BOOL)isPlaintext{
    NSNumber *x = objc_getAssociatedObject(self, &secureKey);
    return x.boolValue;
}
@end
