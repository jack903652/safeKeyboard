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
#import "KeyTipView.h"

#define NUMBERS @"1234567890"
#define LETTERS @"qwertyuiopasdfghjklzxcvbnm"
#define SPECIAL_CHARACTERS @"!@#$%^&*()'\"=_:;?~|`+-\\/[]{},.<>"
#define POT @"."
#define ALT @"Cap"
#define PLACE_PLACER @""
#define HALF_PLACE_PLACER @"HPP"
#define SPACE NSLocalizedStringFromTable(@"空格", @"CustomKeyboard", nil)
#define DELETE NSLocalizedStringFromTable(@"删除", @"CustomKeyboard", nil)
#define FINISH NSLocalizedStringFromTable(@"完成", @"CustomKeyboard", nil)
#define IDENTIFIER @"identifier"
#define SEPERATE_SPACE 6.0
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
@interface CustomKeyboardView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
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
///完成标题
@property(nonatomic,copy)NSString *finishBtnTitle;

@property(nonatomic,strong)KeyTipView *tipView;
@end

@implementation CustomKeyboardView
-(instancetype)initWithView:(UIView<UIKeyInput> *)view keyboardTypes:(NSArray *)keyboardTypes random:(BOOL)random title:(NSString *)title finishBtnTitle:(NSString *)finishBtnTitle length:(NSInteger)length{
    self = [super init];
    if (self) {
        _allowTapFeedBack = YES;
        _finishBtnTitle = finishBtnTitle;
        self.length = length;
        [view setValue:self forKey:@"inputView"];

        CustomInputAccessoryView *accessoryView = [[CustomInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40) keyboardTypes:keyboardTypes finishBtnTitle:_finishBtnTitle];
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
        _textField.delegate = self;
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
        _collectionView.delaysContentTouches = NO;
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
        NSNumber *number = keyboardTypes.firstObject;
        [self reloadKeyBoardViewWithType:number.intValue];
        _tipView = [[KeyTipView alloc] initWithFrame:CGRectZero];
        _tipView.hidden = YES;
        [self addSubview:_tipView];
    }
    return self;
}
-(instancetype)initWithView:(UIView<UIKeyInput> *)view keyboardTypes:(NSArray *)keyboardTypes random:(BOOL)random title:(NSString *)title{
    return [self initWithView:view keyboardTypes:keyboardTypes random:random title:title finishBtnTitle:NSLocalizedStringFromTable(@"完成", @"CustomKeyboard", nil) length:-1];
}

+(instancetype)createWithView:(UIView<UIKeyInput> *)view keyboardTypes:(NSArray *)keyboardTypes random:(BOOL)random title:(NSString *)title finishBtnTitle:(NSString *)finishBtnTitle length:(NSInteger)length{
    CustomKeyboardView *c =[[CustomKeyboardView alloc] initWithView:view keyboardTypes:keyboardTypes random:random title:title finishBtnTitle:finishBtnTitle length:length];
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
        self.currentKeyboardType =CustomKeyboardTypeDigital;
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:_numbers];
        [_dataSource insertObject:PLACE_PLACER atIndex:9];
        [_dataSource addObject:DELETE];
        [_collectionView reloadData];
    }else if (keyboardType&CustomKeyboardTypeCpicFunds) {
        self.currentKeyboardType = CustomKeyboardTypeCpicFunds;
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:_numbers];
        [_dataSource addObjectsFromArray:_letters];
        [_dataSource insertObject:DELETE atIndex:29];
        [_dataSource insertObject:ALT atIndex:30];
        [_dataSource addObject:FINISH];
        [_collectionView reloadData];
    }else if (keyboardType&CustomKeyboardTypeID){
        self.currentKeyboardType =CustomKeyboardTypeID;
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:_numbers];
        [_dataSource insertObject:@"X" atIndex:9];
        [_dataSource addObject:DELETE];
        [_collectionView reloadData];
    }else if (keyboardType&CustomKeyboardTypeABC){
        self.currentKeyboardType =CustomKeyboardTypeABC;
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:_letters];
        [_dataSource insertObject:HALF_PLACE_PLACER atIndex:10];
        [_dataSource insertObject:HALF_PLACE_PLACER atIndex:20];
        [_dataSource insertObject:ALT atIndex:21];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *content = nil;
    if (self.textField.isPlaintext) {
        content = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }else{
        content = [textField.secureText stringByReplacingCharactersInRange:range withString:string];
    }
    if (content.length > self.length) {
        return NO;
    }else{
        self.textField.secureText = content;
        if (self.textField.isPlaintext) {
            return YES;
        }else{
            self.textField.isPlaintext = NO;
            return NO;
//            [self.textField insertText:ASTERISK];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    KeyboardCollectionViewCell *cell = (KeyboardCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    UIColor *feedBackColor = [UIColor whiteColor];
    if (self.allowTapFeedBack){
        feedBackColor = [UIColor grayColor];
        NSString *hint =  cell.textLabel.text;
        if(self.currentKeyboardType&CustomKeyboardTypeLetter || self.currentKeyboardType&CustomKeyboardTypeCpicFunds ||self.currentKeyboardType&CustomKeyboardTypeABC || self.currentKeyboardType&CustomKeyboardTypeCharacters)
        if ([_numbers containsObject:hint.lowercaseString]||[_letters containsObject:hint.lowercaseString]){
            if (@available(iOS 11.0, *)) {
                if(![UIScreen mainScreen].isCaptured){
                    [self showTipWithRect:cell.frame hint:hint];
                }
            }
        }
    }else{
        feedBackColor = [UIColor whiteColor];
    }
    if (@available(iOS 11.0, *)) {
        if([UIScreen mainScreen].isCaptured){
            feedBackColor = [UIColor whiteColor];
        }
    }
    [cell setBackgroundColor:feedBackColor];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    KeyboardCollectionViewCell *cell = (KeyboardCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
    [self dismissKeyTipView];
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
            NSRange range = [self selectedRange];
            if (range.length == 0) {
                if (range.location != 0) {
                    NSString *x = [temp substringToIndex:range.location -1];
                    NSString *y = [temp substringFromIndex:range.location];
                    temp = [NSMutableString stringWithFormat:@"%@%@",x,y];
                }
            }else{
                [temp replaceCharactersInRange:[self selectedRange] withString:@""];
            }
            self.textField.secureText = temp;
            [self.textField deleteBackward];
        }
    }else if ([text isEqualToString:PLACE_PLACER]||[text isEqualToString:HALF_PLACE_PLACER]){
        
    }else if ([text isEqualToString:FINISH]){
        [self.textField resignFirstResponder];
    } else{
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
    if ([text isEqualToString:ALT]||[text isEqualToString:SPACE]|| [text isEqualToString:DELETE]||[text isEqualToString:PLACE_PLACER]||[text isEqualToString:FINISH]||[text isEqualToString:HALF_PLACE_PLACER]) {
        cell.backgroundColor = self.cuItemDarkColor?self.cuItemDarkColor:ITEM_DARK_COLOR;
    }else{
        cell.backgroundColor =self.cuItemColor?self.cuItemColor:ITEM_COLOR;
    }
    if (self.uppercase&&[self.dataSource containsObject:ALT]) {
        cell.textLabel.text = [text uppercaseString];
    }else{
        cell.textLabel.text = [text lowercaseString];
    }
    if ([text isEqualToString:ALT]) {
        cell.textLabel.hidden = YES;
        cell.imageView.hidden = NO;
        cell.imageView.image = [CustomKeyboardView imageInBoundleWithName:@"update.png"];
        cell.imageView.highlightedImage = [CustomKeyboardView imageInBoundleWithName:@"update-1.png"];
        cell.imageView.highlighted = self.uppercase;
    }else if ([text isEqualToString:DELETE]){
        cell.textLabel.hidden = YES;
        cell.imageView.hidden = NO;
        cell.imageView.image = [CustomKeyboardView imageInBoundleWithName:@"del.png"];
        cell.imageView.highlightedImage = [CustomKeyboardView imageInBoundleWithName:@"del.png"];
        cell.imageView.highlighted = NO;
    }else{
        cell.textLabel.hidden = NO;
//        cell.imageView.image = nil;
//        cell.imageView.highlightedImage = nil;
        cell.imageView.hidden = YES;
    }
    
    if ([text isEqualToString:PLACE_PLACER]||[text isEqualToString:HALF_PLACE_PLACER]) {
        cell.hidden = YES;
    }else{
        cell.hidden = NO;
    }
    return cell;
}
+ (UIImage *)imageInBoundleWithName:(NSString *)name {
    NSBundle *boundle = [NSBundle bundleForClass:[self class]];
    NSBundle *currentBoundle = [NSBundle bundleWithPath:[boundle pathForResource:@"SafeKeyboard" ofType:@"bundle"]];
    UIImage *image = [UIImage imageNamed:name inBundle:currentBoundle compatibleWithTraitCollection:nil];
    return image;
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
    }else if (self.currentKeyboardType&CustomKeyboardTypeCpicFunds){
        if ([text isEqualToString:FINISH]) {
            return CGSizeMake(ITEM_WIDTH *2 +SEPERATE_SPACE, ITEM_HEIGHT);
        }else{        
            return CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
        }
    }else if (self.currentKeyboardType&CustomKeyboardTypeID){
        return CGSizeMake(NUMBER_ITEM_WIDTH, ITEM_HEIGHT);
    }else if (self.currentKeyboardType&CustomKeyboardTypeABC){
        if([text isEqualToString:HALF_PLACE_PLACER]){
            return CGSizeMake((ITEM_WIDTH-SEPERATE_SPACE)/2, ITEM_HEIGHT);
        } else if ([text isEqualToString:ALT]||[text isEqualToString:DELETE]) {
            return CGSizeMake(ITEM_WIDTH +SEPERATE_SPACE + (ITEM_WIDTH-SEPERATE_SPACE)/2, ITEM_HEIGHT);
        }else{
            return CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
        }
    }
    return CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (self.currentKeyboardType&CustomKeyboardTypeABC) {
        return UIEdgeInsetsMake(SEPERATE_SPACE*3, SEPERATE_SPACE, SEPERATE_SPACE, SEPERATE_SPACE);
//        if(section == 2){
//            return UIEdgeInsetsMake(SEPERATE_SPACE, SEPERATE_SPACE*2, SEPERATE_SPACE, SEPERATE_SPACE*2);
//        }else{
//            return UIEdgeInsetsMake(SEPERATE_SPACE, SEPERATE_SPACE, SEPERATE_SPACE, SEPERATE_SPACE);
//        }
    }else{
        return UIEdgeInsetsMake(SEPERATE_SPACE, SEPERATE_SPACE, SEPERATE_SPACE, SEPERATE_SPACE);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (self.currentKeyboardType&CustomKeyboardTypeABC) {
        return SEPERATE_SPACE*3;
    }
    else{
        return SEPERATE_SPACE;
    }
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
-(void)setAccessoryBackgroundColor:(UIColor *)accessoryBackgroundColor{
    _accessoryBackgroundColor =accessoryBackgroundColor;
    CustomInputAccessoryView *view = (CustomInputAccessoryView*)self.textField.inputAccessoryView;
    view.backgroundColor = accessoryBackgroundColor;
}
- (void)setTipFont:(UIFont *)tipFont{
    _tipFont = tipFont;
    _tipView.tLabel.font = tipFont;
}


-(void)showTipWithRect:(CGRect)rect hint:(NSString *)hint{
    CGFloat HWRatio = 157.0/50.0;
    CGFloat height = rect.size.width * HWRatio;
    CGRect frame = CGRectMake(rect.origin.x - (84.0/50.0*rect.size.width-rect.size.width)/2, rect.origin.y-height+rect.size.height, rect.size.width*84.0/50.0, height);
    [_tipView updateFrame:frame];
    _tipView.tLabel.text = hint;
    if(_tipFont){
        _tipView.tLabel.font = _tipFont;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.tipView.hidden = NO;
    }];
}
-(void)dismissKeyTipView{
    self.tipView.hidden = YES;
}
@end
