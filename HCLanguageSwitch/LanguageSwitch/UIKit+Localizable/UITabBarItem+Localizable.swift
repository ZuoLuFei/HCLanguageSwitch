/*******************************************************************************
 # File        : UITabBarItem+Localizable.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/8/29
 # Corporation : ####
 # Description :
 <#Description Logs#>
 ******************************************************************************/

import UIKit

private var titleKey = "titleKey"

extension UITabBarItem {

    /// text
    var hc_Title: String {
        set {
            self.title = NSObject.obtionSpliceLocalizeContent(original: newValue)
            registerLocalize(newValue, methodKey: "setTitle:", dataKey: &titleKey)
        }

        get {
            return language_valueFor(&titleKey) ?? ""
        }
    }

}
