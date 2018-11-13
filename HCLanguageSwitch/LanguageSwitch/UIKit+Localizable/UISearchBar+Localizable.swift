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
    var hc_Text: String {
        set {
            self.text = DEF_LOCALIZED_STRING(key: newValue)
            registerLocalize(newValue, methodKey: "setText:", dataKey: &textKey)
        }

        get {
            return language_valueFor(&textKey) ?? ""
        }
    }

    /// placeholder
    var hc_PlaceholderSwitch: String {
        set {
            registerLocalize(newValue, methodKey: "setPlaceholder:", dataKey: &placeholderKey)
            self.placeholder = DEF_LOCALIZED_STRING(key: newValue)
        }

        get {
            return language_valueFor(&placeholderKey) ?? ""
        }
    }
}
