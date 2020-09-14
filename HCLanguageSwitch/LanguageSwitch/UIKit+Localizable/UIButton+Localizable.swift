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
    func hc_SetTitle(_ title: String, for state: UIControl.State) {

        self.setTitle(NSObject.obtionSpliceLocalizeContent(original: title), for: state)

        var localizableDicts = self.localizableDicts

        var dict: [String: Any] = (localizableDicts[String("\(state.rawValue)")] as? [String: Any]) ?? [String: Any]()
        dict.updateValue(title, forKey: "setTitle:forState:")

        localizableDicts.updateValue(dict, forKey: String("\(state.rawValue)"))

        objc_setAssociatedObject(self, &localizableDictsKey, localizableDicts, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    }

    /// setAttributedTitle:forState:
    func hc_SetAttributedTitle(_ title: String, for state: UIControl.State) {
        self.setAttributedTitle(NSAttributedString(string: NSObject.obtionSpliceLocalizeContent(original: title)), for: state)

        var localizableDicts = self.localizableDicts

        var dict: [String: Any] = (localizableDicts[String("\(state.rawValue)")] as? [String: Any]) ?? [String: Any]()
        dict.updateValue(title, forKey: "setAttributedTitle:forState:")

        localizableDicts.updateValue(dict, forKey: String("\(state.rawValue)"))

        objc_setAssociatedObject(self, &localizableDictsKey, localizableDicts, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /// 设置backgroundImage
    ///
    /// - Parameters:
    ///   - theme: 图片
    ///   - state: 状态
    func hc_setBackgroundImage(_ theme: String, forState state: UIControl.State) {
       
        self.setBackgroundImage(HCLocalizableManager.share.imageOf(key: theme), for: state)

        var localizableDicts = self.localizableDicts

        var dict: [String: Any] = (localizableDicts[String("\(state.rawValue)")] as? [String: Any]) ?? [String: Any]()
        dict.updateValue(theme, forKey: "setBackgroundImage:forState:")
        localizableDicts.updateValue(dict, forKey: String("\(state.rawValue)"))

        objc_setAssociatedObject(self, &localizableDictsKey, localizableDicts, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    }

    /// 设置Image
    ///
    /// - Parameters:
    ///   - theme: 图片
    ///   - state: 状态
    func hc_setImage(_ theme: String, forState state: UIControl.State) {

        self.setImage(HCLocalizableManager.share.imageOf(key: theme), for: state)

        var localizableDicts = self.localizableDicts

        var dict: [String: Any] = (localizableDicts[String("\(state.rawValue)")] as? [String: Any]) ?? [String: Any]()
        dict.updateValue(theme, forKey: "setImage:forState:")
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
                    guard let rawValue = UIControl.State.RawValue(key) else { return }

                    let state: UIControl.State = UIControl.State(rawValue: rawValue)
                    let selectorStr = (selectorValue as? String) ?? ""

                    if methodKey == "setTitle:forState:" {

                        self.setTitle(NSObject.obtionSpliceLocalizeContent(original: selectorStr), for: state)

                    } else if methodKey == "setAttributedTitle:forState:" {

                        self.setAttributedTitle(NSAttributedString(string: NSObject.obtionSpliceLocalizeContent(original: selectorStr)), for: state)

                    }
                })
            } else {
                let sel: Selector = Selector(key)
                let valueStr = (value as? String) ?? ""
                let result = NSObject.obtionSpliceLocalizeContent(original: valueStr)

                self.perform(sel, with: result)
            }
        })

        languageChangeBlock?()
    }

}
