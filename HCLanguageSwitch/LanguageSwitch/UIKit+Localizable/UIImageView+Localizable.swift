/*******************************************************************************
# File        : UIImageView+Localizable.swift
# Project     : HCLanguageSwitch
# Author      : ZuoLuFei
# Created     : 2020/9/8
# Corporation : ****
# Description :
<#Description Logs#>
 *******************************************************************************/

import UIKit

private var imgKey = "imgKey"

extension UIImageView {

    /// 设置Image
    ///
    /// - Parameters:
    ///   - theme: 图片
    ///   - state: 状态
    func hc_InitWithImagePicker(_ theme: String) -> UIImageView {
        let imageView = UIImageView(image: HCLocalizableManager.share.imageOf(key: theme))
        imageView.hc_Image = theme
        return imageView
    }

    /// image
    var hc_Image: String? {
        set {
            guard let value = newValue else { return }

            registerLocalize(value, methodKey: "setImage:", dataKey: &imgKey)

            self.image = HCLocalizableManager.share.imageOf(key: value)
        }

        get {
            guard let rawValue = language_valueFor(&imgKey) else { return nil }
            return rawValue
        }
    }
    
}

extension UIImageView {

    /// 重写国际化更新方法
    @objc override func localizableUpdate() {
        localizableDicts.forEach({ (key, value) in

            let sel: Selector = Selector(key)
            let key = (value as? String) ?? ""
            let result = HCLocalizableManager.share.imageOf(key: key)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.perform(sel, with: result)
                
            })
        })
        languageChangeBlock?()
    }

}
