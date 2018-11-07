/*******************************************************************************
 # File        : UIButton+Localizable.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/8/2
 # Corporation : ####
 # Description :
 ******************************************************************************/

import UIKit

extension UIButton {

    /// setTitle:forState:
    func hc_SetTitle(_ title: String, for state: UIControlState) {

        self.setTitle(DEF_LOCALIZED_STRING(key: title), for: state)

        var localizableDicts = self.localizableDicts

        var dict: [String: Any] = (localizableDicts[String("\(state.rawValue)")] as? [String: Any]) ?? [String: Any]()
        dict.updateValue(title, forKey: "setTitle:forState:")

        localizableDicts.updateValue(dict, forKey: String("\(state.rawValue)"))

        objc_setAssociatedObject(self, &localizableDictsKey, localizableDicts, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    }

    /// setAttributedTitle:forState:
    func kcSetAttributedTitle(_ title: String, for state: UIControlState) {
        self.setAttributedTitle(NSAttributedString(string: DEF_LOCALIZED_STRING(key: title)), for: state)

        var localizableDicts = self.localizableDicts

        var dict: [String: Any] = (localizableDicts[String("\(state.rawValue)")] as? [String: Any]) ?? [String: Any]()
        dict.updateValue(title, forKey: "setAttributedTitle:forState:")

        localizableDicts.updateValue(dict, forKey: String("\(state.rawValue)"))

        objc_setAssociatedObject(self, &localizableDictsKey, localizableDicts, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

extension UIButton {

    /// 重写国际化更新方法
    @objc override func localizableUpdate() {

        localizableDicts.forEach({ (key, value) in

            if let dict = value as? [String: Any] {
                dict.forEach({(methodKey, selectorValue) in
                    guard let rawValue = UIControlState.RawValue(key) else { return }

                    let state: UIControlState = UIControlState(rawValue: rawValue)
                    let selectorStr = (selectorValue as? String) ?? ""

                    if methodKey == "setTitle:forState:" {

                        self.setTitle(DEF_LOCALIZED_STRING(key: selectorStr), for: state)

                    } else if methodKey == "setAttributedTitle:forState:" {

                        self.setAttributedTitle(NSAttributedString(string: DEF_LOCALIZED_STRING(key: selectorStr)), for: state)

                    }
                })
            } else {
                let sel: Selector = Selector(key)
                let valueStr = (value as? String) ?? ""
                let result = DEF_LOCALIZED_STRING(key: valueStr)

                self.perform(sel, with: result)
            }
        })

    }

}
