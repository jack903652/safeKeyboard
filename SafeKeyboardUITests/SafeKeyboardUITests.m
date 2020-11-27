//
//  SafeKeyboardUITests.m
//  SafeKeyboardUITests
//
//  Created by bamq on 2019/5/30.
//  Copyright © 2019 Aresoft (Shanghai) Tech Co.,Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SafeKeyboardUITests : XCTestCase

@end

@implementation SafeKeyboardUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0].otherElements childrenMatchingType:XCUIElementTypeTextField].element tap];
    
    XCUIElementQuery *collectionViewsQuery = app.collectionViews;
    XCUIElement *staticText = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"2"]/*[[".cells.staticTexts[@\"2\"]",".staticTexts[@\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [staticText tap];
    
    XCUIElement *staticText2 = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"6"]/*[[".cells.staticTexts[@\"6\"]",".staticTexts[@\"6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [staticText2 tap];
    
    XCUIElement *staticText3 = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"4"]/*[[".cells.staticTexts[@\"4\"]",".staticTexts[@\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [staticText3 tap];
    
    XCUIElement *staticText4 = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"7"]/*[[".cells.staticTexts[@\"7\"]",".staticTexts[@\"7\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [staticText4 tap];
    
    XCUIElement *staticText5 = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"9"]/*[[".cells.staticTexts[@\"9\"]",".staticTexts[@\"9\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [staticText5 tap];
    
    XCUIElement *staticText6 = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"1"]/*[[".cells.staticTexts[@\"1\"]",".staticTexts[@\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [staticText6 tap];
    
    XCUIElement *staticText7 = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"5"]/*[[".cells.staticTexts[@\"5\"]",".staticTexts[@\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [staticText7 tap];
    
    XCUIElement *staticText8 = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"0"]/*[[".cells.staticTexts[@\"0\"]",".staticTexts[@\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [staticText8 tap];
    
    XCUIElement *staticText9 = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"3"]/*[[".cells.staticTexts[@\"3\"]",".staticTexts[@\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [staticText9 tap];
    
    XCUIElement *staticText10 = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"."]/*[[".cells.staticTexts[@\".\"]",".staticTexts[@\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [staticText10 tap];
    
    XCUIElement *staticText11 = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"8"]/*[[".cells.staticTexts[@\"8\"]",".staticTexts[@\"8\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [staticText11 tap];
    
    XCUIElement *delStaticText = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"del"]/*[[".cells.staticTexts[@\"del\"]",".staticTexts[@\"del\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [delStaticText tap];
    [staticText11 tap];
    [app.buttons[@"Abc"] tap];
    [staticText tap];
    [staticText2 tap];
    [staticText3 tap];
    [staticText4 tap];
    [staticText5 tap];
    [staticText6 tap];
    [staticText7 tap];
    [staticText8 tap];
    [staticText9 tap];
    [staticText11 tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"n"]/*[[".cells.staticTexts[@\"n\"]",".staticTexts[@\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"f"]/*[[".cells.staticTexts[@\"f\"]",".staticTexts[@\"f\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"v"]/*[[".cells.staticTexts[@\"v\"]",".staticTexts[@\"v\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"c"]/*[[".cells.staticTexts[@\"c\"]",".staticTexts[@\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"w"]/*[[".cells.staticTexts[@\"w\"]",".staticTexts[@\"w\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"h"]/*[[".cells.staticTexts[@\"h\"]",".staticTexts[@\"h\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"y"]/*[[".cells.staticTexts[@\"y\"]",".staticTexts[@\"y\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"i"]/*[[".cells.staticTexts[@\"i\"]",".staticTexts[@\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"d"]/*[[".cells.staticTexts[@\"d\"]",".staticTexts[@\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"z"]/*[[".cells.staticTexts[@\"z\"]",".staticTexts[@\"z\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    XCUIElement *altStaticText = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"alt"]/*[[".cells.staticTexts[@\"alt\"]",".staticTexts[@\"alt\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [altStaticText tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"X"]/*[[".cells.staticTexts[@\"X\"]",".staticTexts[@\"X\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"G"]/*[[".cells.staticTexts[@\"G\"]",".staticTexts[@\"G\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Q"]/*[[".cells.staticTexts[@\"Q\"]",".staticTexts[@\"Q\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"S"]/*[[".cells.staticTexts[@\"S\"]",".staticTexts[@\"S\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"B"]/*[[".cells.staticTexts[@\"B\"]",".staticTexts[@\"B\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"U"]/*[[".cells.staticTexts[@\"U\"]",".staticTexts[@\"U\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"K"]/*[[".cells.staticTexts[@\"K\"]",".staticTexts[@\"K\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"M"]/*[[".cells.staticTexts[@\"M\"]",".staticTexts[@\"M\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"L"]/*[[".cells.staticTexts[@\"L\"]",".staticTexts[@\"L\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    XCUIElement *spaceStaticText = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"space"]/*[[".cells.staticTexts[@\"space\"]",".staticTexts[@\"space\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [spaceStaticText tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"J"]/*[[".cells.staticTexts[@\"J\"]",".staticTexts[@\"J\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"T"]/*[[".cells.staticTexts[@\"T\"]",".staticTexts[@\"T\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"O"]/*[[".cells.staticTexts[@\"O\"]",".staticTexts[@\"O\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"R"]/*[[".cells.staticTexts[@\"R\"]",".staticTexts[@\"R\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"E"]/*[[".cells.staticTexts[@\"E\"]",".staticTexts[@\"E\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"A"]/*[[".cells.staticTexts[@\"A\"]",".staticTexts[@\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"P"]/*[[".cells.staticTexts[@\"P\"]",".staticTexts[@\"P\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [altStaticText tap];
    [delStaticText tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"p"]/*[[".cells.staticTexts[@\"p\"]",".staticTexts[@\"p\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [app.buttons[@"#+="] tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"!"]/*[[".cells.staticTexts[@\"!\"]",".staticTexts[@\"!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"@"]/*[[".cells.staticTexts[@\"@\"]",".staticTexts[@\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"#"]/*[[".cells.staticTexts[@\"#\"]",".staticTexts[@\"#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"$"]/*[[".cells.staticTexts[@\"$\"]",".staticTexts[@\"$\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"%"]/*[[".cells.staticTexts[@\"%\"]",".staticTexts[@\"%\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"^"]/*[[".cells.staticTexts[@\"^\"]",".staticTexts[@\"^\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"&"]/*[[".cells.staticTexts[@\"&\"]",".staticTexts[@\"&\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"*"]/*[[".cells.staticTexts[@\"*\"]",".staticTexts[@\"*\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"("]/*[[".cells.staticTexts[@\"(\"]",".staticTexts[@\"(\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@")"]/*[[".cells.staticTexts[@\")\"]",".staticTexts[@\")\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"'"]/*[[".cells.staticTexts[@\"'\"]",".staticTexts[@\"'\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"\""]/*[[".cells.staticTexts[@\"\\\"\"]",".staticTexts[@\"\\\"\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"="]/*[[".cells.staticTexts[@\"=\"]",".staticTexts[@\"=\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"_"]/*[[".cells.staticTexts[@\"_\"]",".staticTexts[@\"_\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@":"]/*[[".cells.staticTexts[@\":\"]",".staticTexts[@\":\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@";"]/*[[".cells.staticTexts[@\";\"]",".staticTexts[@\";\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"?"]/*[[".cells.staticTexts[@\"?\"]",".staticTexts[@\"?\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"~"]/*[[".cells.staticTexts[@\"~\"]",".staticTexts[@\"~\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"|"]/*[[".cells.staticTexts[@\"|\"]",".staticTexts[@\"|\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"`"]/*[[".cells.staticTexts[@\"`\"]",".staticTexts[@\"`\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"+"]/*[[".cells.staticTexts[@\"+\"]",".staticTexts[@\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"-"]/*[[".cells.staticTexts[@\"-\"]",".staticTexts[@\"-\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"\\"]/*[[".cells.staticTexts[@\"\\\\\"]",".staticTexts[@\"\\\\\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"/"]/*[[".cells.staticTexts[@\"\/\"]",".staticTexts[@\"\/\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"["]/*[[".cells.staticTexts[@\"[\"]",".staticTexts[@\"[\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"]"]/*[[".cells.staticTexts[@\"]\"]",".staticTexts[@\"]\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"{"]/*[[".cells.staticTexts[@\"{\"]",".staticTexts[@\"{\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"}"]/*[[".cells.staticTexts[@\"}\"]",".staticTexts[@\"}\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@","]/*[[".cells.staticTexts[@\",\"]",".staticTexts[@\",\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [staticText10 tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@"<"]/*[[".cells.staticTexts[@\"<\"]",".staticTexts[@\"<\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts[@">"]/*[[".cells.staticTexts[@\">\"]",".staticTexts[@\">\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [spaceStaticText tap];
    [delStaticText tap];
    [spaceStaticText tap];
    [app.buttons[@"finish"] tap];
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
