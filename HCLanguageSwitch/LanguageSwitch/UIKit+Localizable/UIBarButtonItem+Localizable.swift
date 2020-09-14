/*******************************************************************************
 # File        : UIBarButtonItem+Localizable.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/8/2
 # Corporation : ####
 # Description :
 ******************************************************************************/

import UIKit

private var titleKey = "titleKey"

extension UIBarButtonItem {

    /// text
    var hc_Title: String {
        set {
//            self.title = DEF_LOCALIZED_STRING(key: newValue)
            self.title = NSObject.obtionSpliceLocalizeContent(original: newValue)
            registerLocalize(newValue, methodKey: "setTitle:", dataKey: &titleKey)
        }

        get {
            return self.title ?? ""
//            return language_valueFor(&titleKey) ?? ""
        }
    }
}
