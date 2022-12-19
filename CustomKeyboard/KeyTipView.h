//
//  KeyTipView.h
//  SafeKeyboard
//
//  Created by bamq on 2022/12/13.
//  Copyright © 2022 Aresoft (Shanghai) Tech Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyTipView : UIView
@property(nonatomic,strong)UILabel *tLabel;
-(void)updateFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
