/*******************************************************************************
 # File        : UITextView+Localizable.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/8/2
 # Corporation : ####
 # Description :
 ******************************************************************************/

import UIKit

private var textKey = "textKey"

extension UITextView {

    /// text
    var hc_Text: String {
        set {
            self.text = NSObject.obtionSpliceLocalizeContent(original: newValue)
            registerLocalize(newValue, methodKey: "setText:", dataKey: &textKey)
        }

        get {
            return language_valueFor(&textKey) ?? ""
        }
    }
}
