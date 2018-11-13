/*******************************************************************************
 # File        : NSObject+Localizable.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/8/2
 # Corporation : ####
 # Description :
 ******************************************************************************/

import UIKit

var localizableDictsKey = "localizableDictsKey"
private var kLocalizableDeinitBlocks = "kLocalizableDeinitBlocks"

/// 语言更新Block回调
private var languageChangeBlock: (() -> Void)?

extension NSObject {
    var localizableDicts: [String: Any] {
        if let localizableDicts = objc_getAssociatedObject(self, &localizableDictsKey) as? [String: Any] {
            return localizableDicts
        } else {
            let localizableDicts = [String: Any]()

            // 释放通知
            if objc_getAssociatedObject(self, &kLocalizableDeinitBlocks) == nil {

                let deinitHelper = self.addLocalizableDeinitBlock { [weak self] in
                    NotificationCenter.default.removeObserver(self as Any)
                }

                objc_setAssociatedObject(self, &kLocalizableDeinitBlocks, deinitHelper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }

            NotificationCenter.default.removeObserver(self,
                                                      name: HCLocalizableManager.localizableDidChangeNotification,
                                                      object: nil)

            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(localizableUpdate),
                                                   name: HCLocalizableManager.localizableDidChangeNotification,
                                                   object: nil)

            objc_setAssociatedObject(self, &localizableDictsKey, localizableDicts, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            return localizableDicts
        }
    }

    // 语言更新通知方法
    @objc func localizableUpdate() {

        localizableDicts.forEach({ (selectorKey, localizedKey) in
            let sel: Selector = Selector(selectorKey)
            let keyStr = (localizedKey as? String) ?? ""
            let result = DEF_LOCALIZED_STRING(key: keyStr)

            self.perform(sel, with: result)

        })
        
        languageChangeBlock?()
    }
    
    /// 语言刷新回调
    func localizableDidChange(_ didChange: (() -> Void)?)  {
        languageChangeBlock = didChange
    }

    /**
     * 注册属性变化
     */
    func registerLocalize(_ value: String, methodKey: String, dataKey: UnsafeRawPointer) {
        objc_setAssociatedObject(self, dataKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)

        var pik = localizableDicts
        pik.updateValue(value, forKey: methodKey)

        objc_setAssociatedObject(self, &localizableDictsKey, pik, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /**
     *
     */
    func language_valueFor(_ dataKey: UnsafeRawPointer) -> String? {
        return objc_getAssociatedObject(self, dataKey) as? String
    }
}
