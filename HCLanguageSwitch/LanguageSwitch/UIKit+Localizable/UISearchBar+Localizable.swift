/*******************************************************************************
 # File        : UISearchBar+Localizable.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/8/2
 # Corporation : ####
 # Description :
 ******************************************************************************/

import UIKit

private var textKey = "localizableTextSwitch"
private var placeholderKey = "placeholderKey"

extension UISearchBar {
    /// text
    var hc_Text: String? {
        set {
//            self.text = DEF_LOCALIZED_STRING(key: newValue)
            self.text = NSObject.obtionSpliceLocalizeContent(original: newValue ?? "")
            registerLocalize(newValue ?? "", methodKey: "setText:", dataKey: &textKey)
        }

        get {
            return self.text
//            return language_valueFor(&textKey) ?? ""
        }
    }

    /// placeholder
    var hc_PlaceholderSwitch: String? {
        set {
            registerLocalize(newValue ?? "", methodKey: "setPlaceholder:", dataKey: &placeholderKey)
//            self.placeholder = DEF_LOCALIZED_STRING(key: newValue)
            self.placeholder = NSObject.obtionSpliceLocalizeContent(original: newValue ?? "")
        }

        get {
            return self.placeholder
//            return language_valueFor(&placeholderKey) ?? ""
        }
    }
}
