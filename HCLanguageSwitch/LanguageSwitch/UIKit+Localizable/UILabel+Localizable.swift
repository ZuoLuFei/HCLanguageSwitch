/*******************************************************************************
 # File        : UILabel+Localizable.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/7/31
 # Corporation : ####
 # Description :
 ******************************************************************************/

import UIKit

private var textKey = "textKey"

extension UILabel {

    /// text
    var hc_Text: String {
        set {
            self.text = DEF_LOCALIZED_STRING(key: newValue)
            registerLocalize(newValue, methodKey: "setText:", dataKey: &textKey)
        }

        get {
            return language_valueFor(&textKey) ?? ""
        }
    }
}
