//
//  UINavigationItem+Localizable.swift
//  BBSport
//
//  Created by ZuoLuFei on 2020/9/3.
//  Copyright © 2020 SEEKTOP. All rights reserved.
//

import UIKit

private var titleKey = "titleKey"

extension UINavigationItem {
    /// text
    var hc_Title: String? {
        set {
            self.title = NSObject.obtionSpliceLocalizeContent(original: newValue ?? "")
            registerLocalize(newValue ?? "", methodKey: "setTitle:", dataKey: &titleKey)
        }

        get {
            return self.title
//            return language_valueFor(&titleKey) ?? ""
        }
    }
}
