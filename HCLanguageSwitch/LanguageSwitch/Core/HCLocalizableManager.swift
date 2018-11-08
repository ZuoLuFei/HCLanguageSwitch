/*******************************************************************************
 # File        : HCLocalizableManager.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/6/30
 # Corporation : ####
 # Description : 语言切换控制中心
 ******************************************************************************/

import UIKit
import Foundation

/***********************************国际化匹配*************************************/
// MARK: 国际化匹配
/// 国际化匹配
func DEF_LOCALIZED_STRING(key: String) -> String {
    return HCLocalizableManager.share.localized(key)
}

/***********************************国际化匹配*************************************/

// 用户语言存储Key
class HCLocalizableManager: NSObject {
    private static let kBundleNameKey = "User_Language_Bundle_Name_Key"
    private static let kInitializeLanguage = "Initialize_Language_Key"

    // 语言环境切换通知
    static let localizableDidChangeNotification = NSNotification.Name(rawValue: "com.zuolufei.HCLanguageSwitch.localizableDidChangeNotification")
    
    /// 单例
    static let share: HCLocalizableManager = {
        let instance = HCLocalizableManager()
        instance._initLanguage()
        return instance
    }()

    /// 语言bundle
    private var bundle: Bundle?

    /**
     * 加载指定bundle中的Key
     */
    func localized(_ key: String) -> String {
        return bundle?.localizedString(forKey: key, value: nil, table: nil) ?? ""
    }

    /**
     * 切换语言环境
     */
    func updateLanguage(_ bundleName: String) {
        guard let path = Bundle.main.path(forResource: bundleName, ofType: "lproj") else { return }

        self.bundle = Bundle(path: path)
        self.currentBundleName = bundleName
        
        UserDefaults.standard.set(bundleName, forKey: HCLocalizableManager.kBundleNameKey)
        UserDefaults.standard.synchronize()
        
        // 发送通知更新语言
        NotificationCenter.default.post(name: HCLocalizableManager.localizableDidChangeNotification, object: nil)
    }
    
    /// 初始化语言环境，在程序第一次启动是才生效
    func initializeLanguage(_ bundleName: String) {
        guard let initialize = UserDefaults.standard.object(forKey: HCLocalizableManager.kInitializeLanguage),
            initialize as? Bool == true else {
                
                updateLanguage(bundleName)
                
                UserDefaults.standard.set(true, forKey: HCLocalizableManager.kInitializeLanguage)
                UserDefaults.standard.synchronize()
                return
        }
    }
    
    /// 当前的语言文件
    private(set) var currentBundleName = "en"
}

// MARK: - 私有方法
extension HCLocalizableManager {
    /// 初始化语言文件
    private func _initLanguage() {
        if let language = UserDefaults.standard.object(forKey: HCLocalizableManager.kBundleNameKey) as? String {
            updateLanguage(language)
        } else {
            updateLanguage(currentBundleName)
        }
    }
}
