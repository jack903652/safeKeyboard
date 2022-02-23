//
//  CustomKeyboardVIew.m
//  SwPractice
//
//  Created by bamq on 2017/5/31.
//  Copyright © bamq. All rights reserved
//

#import "CustomKeyboardView.h"
#import "KeyboardCollectionViewCell.h"
#import "UITextField+Security.h"

#define NUMBERS @"1234567890"
#define LETTERS @"qwertyuiopasdfghjklzxcvbnm"
#define SPECIAL_CHARACTERS @"!@#$%^&*()'\"=_:;?~|`+-\\/[]{},.<>"
#define POT @"."
#define ALT @"Cap"
#define PLACE_PLACER @""
#define SPACE NSLocalizedStringFromTable(@"空格", @"CustomKeyboard", nil)
#define DELETE NSLocalizedStringFromTable(@"删除", @"CustomKeyboard", nil)
#define IDENTIFIER @"identifier"
#define SEPERATE_SPACE 3.0
#define ITEM_WIDTH ((CGRectGetWidth([UIScreen mainScreen].bounds)-SEPERATE_SPACE*11)/10.0)
#define NUMBER_ITEM_WIDTH ((CGRectGetWidth([UIScreen mainScreen].bounds)-SEPERATE_SPACE*4)/3)
#define ITEM_HEIGHT (ITEM_WIDTH*4/3)
#define BACKGROUND_COLOR [UIColor colorWithWhite:61./255 alpha:1]
#define ITEM_COLOR [UIColor colorWithWhite:118./255 alpha:1]
#define ITEM_DARK_COLOR [UIColor colorWithWhite:83./255 alpha:1]

#define iPhoneX_series ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
    if ([UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0) {\
    isPhoneX = YES;\
    }\
}\
isPhoneX;\
})
@interface CustomKeyboardView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;

/**
 大小写
 */
@property(nonatomic,assign)BOOL uppercase;
/**
 随机乱序
 */
@property(nonatomic,assign)BOOL random;

/**
 数字
 */
@property(nonatomic,strong)NSArray *numbers;

/**
 字母
 */
@property(nonatomic,strong)NSArray *letters;

/**
 特殊字符
 */
@property(nonatomic,strong)NSArray *specialLetters;

/**
 数据源
 */
@property(nonatomic,strong)NSMutableArray *dataSource;;

/**
 输入源
 */
@property(nonatomic,weak)UITextField<UIKeyInput>* textField;

/**
 限制长度
 */
@property(nonatomic,assign)NSInteger length;

@property(nonatomic,assign)CustomKeyboardType currentKeyboardType;
@end

@implementation CustomKeyboardView
-(instancetype)initWithView:(UIView<UIKeyInput> *)view keyboardType:(CustomKeyboardType)keyboardType random:(BOOL)random title:(NSString *)title length:(NSInteger)length{
    self = [super init];
    if (self) {
        self.length = length;
        [view setValue:self forKey:@"inputView"];
        CustomInputAccessoryView *accessoryView =  [[CustomInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40) keyboardType:keyboardType];
        accessoryView.backgroundColor = BACKGROUND_COLOR;
        accessoryView.textLabel.text = title?title:@"安全键盘";
        __weak __typeof(self) wself = self;
        [accessoryView finishBlock:^{
            [wself.textField resignFirstResponder];
        }];
        accessoryView.changeTypeBlock = ^(CustomKeyboardType type) {
            [wself reloadKeyBoardViewWithType:type];
        };
        [view setValue:accessoryView forKey:@"inputAccessoryView"];
        _random = random;
        _textField = (UITextField *)view;
//        _textField.isPlaintext = NO;

        CGFloat delta_x = 0.0;
        if (iPhoneX_series) {
            delta_x = 34.0;
        }
        self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), SEPERATE_SPACE*5+ITEM_HEIGHT*4+delta_x);
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
        _collectionView =[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.backgroundColor = BACKGROUND_COLOR;
        _collectionView.delegate =self;
        _collectionView.dataSource =self;
        [_collectionView registerClass:[KeyboardCollectionViewCell class] forCellWithReuseIdentifier:IDENTIFIER];
        _dataSource =[NSMutableArray array];
        self.uppercase = NO;
        
        if (self.random) {
            _numbers = [self random:[self stringToArr:NUMBERS]];
            _letters = [self random:[self stringToArr:_uppercase?[LETTERS uppercaseString]:LETTERS]];
        }else{
            _numbers = [self stringToArr:NUMBERS];
            _letters = [self stringToArr:_uppercase?[LETTERS uppercaseString]:LETTERS];
        }
        _specialLetters = [self stringToArr:SPECIAL_CHARACTERS];
        ///
        [self reloadKeyBoardViewWithType:keyboardType];
    }
    return self;
}
-(instancetype)initWithView:(UIView<UIKeyInput> *)view keyboardType:(CustomKeyboardType)keyboardType random:(BOOL)random title:(NSString *)title{
    return [self initWithView:view keyboardType:keyboardType random:random title:title length:-1];
}
+(instancetype)createWithView:(UIView<UIKeyInput> *)view keyboardType:(CustomKeyboardType)keyboardType random:(BOOL)random title:(NSString *)title{
   return [self createWithView:view keyboardType:keyboardType random:random title:title length:-1];
}
+(instancetype)createWithView:(UIView<UIKeyInput> *)view keyboardType:(CustomKeyboardType)keyboardType random:(BOOL)random title:(NSString *)title length:(NSInteger)length{
    CustomKeyboardView *c =[[CustomKeyboardView alloc] initWithView:view keyboardType:keyboardType random:random title:title length:length];
    return c;
}

-(void)reloadKeyBoardViewWithType:(CustomKeyboardType)keyboardType{
    if (keyboardType&CustomKeyboardTypeNumber){
        self.currentKeyboardType =CustomKeyboardTypeNumber;
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:_numbers];
        [_dataSource insertObject:POT atIndex:9];
        [_dataSource addObject:DELETE];
        [_collectionView reloadData];
    }else if (keyboardType&CustomKeyboardTypeLetter) {
        self.currentKeyboardType = CustomKeyboardTypeLetter;
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:_numbers];
        [_dataSource addObjectsFromArray:_letters];
        [_dataSource insertObject:ALT atIndex:20];
        [_dataSource insertObject:SPACE atIndex:30];
        [_dataSource addObject:DELETE];
        [_collectionView reloadData];
    }else if (keyboardType&CustomKeyboardTypeCharacters){
        self.currentKeyboardType =CustomKeyboardTypeCharacters;
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:_specialLetters];
        [_dataSource addObject:SPACE];
        [_dataSource addObject:DELETE];
        [_collectionView reloadData];
    }else if (keyboardType&CustomKeyboardTypeDigital){
        self.currentKeyboardType =CustomKeyboardTypeNumber;
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:_numbers];
        [_dataSource insertObject:PLACE_PLACER atIndex:9];
        [_dataSource addObject:DELETE];
        [_collectionView reloadData];
    }

}

///string to arr
-(NSArray *)stringToArr:(NSString *)string{
    NSMutableArray *arr =[NSMutableArray array];
    for (int i = 0; i<string.length; i++) {
        [arr addObject:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    return arr;
}

///随机排序
-(NSArray *)random:(NSArray *)arr{
    NSArray *x = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    return x;
}

-(BOOL)enableInputClicksWhenVisible{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[UIDevice currentDevice] playInputClick];
    NSString *text = self.dataSource[indexPath.item];
    if ([text isEqualToString:ALT]) {
        self.uppercase = !self.uppercase;
        [collectionView reloadData];
    }else if ([text isEqualToString:SPACE]){
        if (self.textField.secureText.length == self.length) {
            return;
        }
        NSMutableString *temp = [NSMutableString stringWithString:self.textField.secureText];
        [temp replaceCharactersInRange:[self selectedRange] withString:WHITESPACE];
        self.textField.secureText = [NSString stringWithString:temp];
        if (self.textField.isPlaintext) {
            [self.textField insertText:WHITESPACE];
        }else{
            [self.textField insertText:ASTERISK];
        }
        
    }else if ([text isEqualToString:DELETE]){
        if ([self.textField hasText]) {
            NSMutableString *temp = [NSMutableString stringWithString:self.textField.secureText];
            [temp replaceCharactersInRange:[self selectedRange] withString:@""];
            self.textField.secureText = temp;
            [self.textField deleteBackward];
        }
    }else if ([text isEqualToString:PLACE_PLACER]){
        
    }else{
        if (self.textField.secureText.length == self.length) {
            return;
        }
        NSString *x= self.dataSource[indexPath.item];
        if (self.uppercase) {
            x = [x uppercaseString];
        }
        NSMutableString *temp = [NSMutableString stringWithString:self.textField.secureText];
        [temp replaceCharactersInRange:[self selectedRange] withString:x];
        self.textField.secureText = [NSString stringWithString:temp];
        if (self.textField.isPlaintext) {
            [self.textField insertText:x];
        }else {
            [self.textField insertText:ASTERISK];
        }
    }

}

/// 查找当前光标位置
- (NSRange)selectedRange{
    UITextPosition* beginning = self.textField.beginningOfDocument;
    UITextRange* selectedRange = self.textField.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self.textField offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self.textField offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KeyboardCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER forIndexPath:indexPath];
    if (self.cuKeyColor) {
        cell.textLabel.textColor = self.cuKeyColor;
    }
    if (self.cuKeyFont) {
        cell.textLabel.font = self.cuKeyFont;
    }
    NSString *text = cell.textLabel.text = self.dataSource[indexPath.item];
    if ([text isEqualToString:ALT]||[text isEqualToString:SPACE]|| [text isEqualToString:DELETE]||[text isEqualToString:PLACE_PLACER]) {
        cell.backgroundColor = self.cuItemDarkColor?self.cuItemDarkColor:ITEM_DARK_COLOR;
    }else{
        cell.backgroundColor =self.cuItemColor?self.cuItemColor:ITEM_COLOR;
        if (self.uppercase&&(self.currentKeyboardType&CustomKeyboardTypeLetter)) {
            cell.textLabel.text = [text uppercaseString];
        }
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *text = self.dataSource[indexPath.item];
    if (self.currentKeyboardType&CustomKeyboardTypeLetter) {
        if ([text isEqualToString:SPACE]|| [text isEqualToString:DELETE]) {
            return CGSizeMake(ITEM_WIDTH +SEPERATE_SPACE + (ITEM_WIDTH-SEPERATE_SPACE)/2, ITEM_HEIGHT);
        }else{
            return CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
        }
    }else if(self.currentKeyboardType&CustomKeyboardTypeCharacters){
        if ([text isEqualToString:DELETE]) {
            return CGSizeMake(ITEM_WIDTH +SEPERATE_SPACE + (ITEM_WIDTH-SEPERATE_SPACE)/2, ITEM_HEIGHT);
        }else if([text isEqualToString:SPACE]){
            return CGSizeMake((ITEM_WIDTH+SEPERATE_SPACE)*6 +(ITEM_WIDTH-SEPERATE_SPACE)/2, ITEM_HEIGHT);
        }else{
            return CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
        }
    }else if (self.currentKeyboardType&CustomKeyboardTypeNumber){
        return CGSizeMake(NUMBER_ITEM_WIDTH, ITEM_HEIGHT);
    }else if (self.currentKeyboardType&CustomKeyboardTypeDigital){
        return CGSizeMake(NUMBER_ITEM_WIDTH, ITEM_HEIGHT);
    }
    return CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(SEPERATE_SPACE, SEPERATE_SPACE, SEPERATE_SPACE, SEPERATE_SPACE);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return SEPERATE_SPACE;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return SEPERATE_SPACE-0.001;
}

-(void)setCuBackgroundColor:(UIColor *)cuBackgroundColor{
    _cuBackgroundColor = cuBackgroundColor;
    UIView *view = self.textField.inputAccessoryView;
    view.backgroundColor = cuBackgroundColor;
    self.collectionView.backgroundColor = cuBackgroundColor;
}
-(void)setCuItemColor:(UIColor *)cuItemColor{
    _cuItemColor = cuItemColor;
    [self.collectionView reloadData];
}
-(void)setCuItemDarkColor:(UIColor *)cuItemDarkColor{
    _cuItemDarkColor = cuItemDarkColor;
    [self.collectionView reloadData];
}

-(void)setCuKeyColor:(UIColor *)cuKeyColor{
    _cuKeyColor = cuKeyColor;
    [self.collectionView reloadData];
}
-(void)setCuKeyFont:(UIFont *)cuKeyFont{
    _cuKeyFont = cuKeyFont;
    [self.collectionView reloadData];
}
-(void)setAccessoryColor:(UIColor *)accessoryColor{
    _accessoryColor = accessoryColor;
    CustomInputAccessoryView *view = (CustomInputAccessoryView*)self.textField.inputAccessoryView;
    view.textLabel.textColor = accessoryColor;
    [view.finishBtn setTitleColor:accessoryColor forState:UIControlStateNormal];
    [view.changeTypeBtn setTitleColor:accessoryColor forState:UIControlStateNormal];
}
-(void)setAccessoryFont:(UIFont *)accessoryFont{
    _accessoryFont = accessoryFont;
    CustomInputAccessoryView *view = (CustomInputAccessoryView*)self.textField.inputAccessoryView;
    view.textLabel.font = accessoryFont;
    view.finishBtn.titleLabel.font = accessoryFont;
    view.changeTypeBtn.titleLabel.font = accessoryFont;
}
@end
