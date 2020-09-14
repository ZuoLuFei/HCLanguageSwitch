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
private var imageKey = "imageKey"
private var selectedImageKey = "selectedImageKey"

extension UITabBarItem {

    /// text
    var hc_Title: String {
        set {
            self.title = NSObject.obtionSpliceLocalizeContent(original: newValue)
            registerLocalize(newValue, methodKey: "setTitle:", dataKey: &titleKey)
        }

        get {
            return self.title ?? ""
//            return language_valueFor(&titleKey) ?? ""
        }
    }
    
    /// image
       var hc_Image: String? {
           set {
               guard let value = newValue else { return }
               registerLocalize(value, methodKey: "setImage:", dataKey: &imageKey)

               self.image = HCLocalizableManager.share.imageOf(key: value)
           }

           get {
               guard let rawValue = language_valueFor(&imageKey) else { return nil }
               return rawValue
           }
       }

       /// selectedImage
       var hc_SelectedImage: String? {
           set {
               guard let value = newValue else { return }
               registerLocalize(value, methodKey: "setSelectedImage:", dataKey: &selectedImageKey)

               self.selectedImage = HCLocalizableManager.share.imageOf(key: value)
           }

           get {
               guard let rawValue = language_valueFor(&selectedImageKey) else { return nil }
               return rawValue
           }
       }

}
