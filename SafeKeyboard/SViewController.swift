//
//  SViewController.swift
//  SafeKeyboard
//
//  Created by bamq on 2022/12/25.
//  Copyright © 2022 Aresoft (Shanghai) Tech Co.,Ltd. All rights reserved.
//

import UIKit
import SafeKeyboardKit
class SViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let safeTextField = CGSafeTextField(frame: CGRect(x: 0, y: 200, width: 200, height: 40))
        self.view.addSubview(safeTextField)
        safeTextField.backgroundColor = UIColor.blue
        let keyboardView = CustomKeyboardView.create(with: safeTextField, keyboardTypes: [NSNumber(value: CustomKeyboardType.cpicFunds.rawValue)], random: false, title: "安全键盘", finishBtnTitle: nil, length: 8)
        keyboardView!.allowTapFeedBack = true
        safeTextField.isPlaintext = true;
//        UIColor *bColor = [UIColor colorWithWhite:0.850 alpha:1];
//        keyboardView.cuBackgroundColor = bColor;
//        keyboardView.cuItemColor = [UIColor whiteColor];
//        keyboardView.cuItemDarkColor = [UIColor colorWithWhite:0.75 alpha:1];
//        keyboardView.cuKeyColor = [UIColor blackColor];
//        keyboardView.cuKeyFont = [UIFont systemFontOfSize:22 weight:(UIFontWeightRegular)];
//        keyboardView.accessoryColor = [UIColor blackColor];
//        keyboardView.accessoryFont = [UIFont systemFontOfSize:16 weight:(UIFontWeightRegular)];
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
