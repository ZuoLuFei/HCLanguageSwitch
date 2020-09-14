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
/// 国际化文字
func DEF_LOCALIZED_STRING(key: String) -> String {
    return HCLocalizableManager.share.localized(key)
}

/// 获取国际化图片，返回图片UIImage
func DEF_LOCALIZED_IMAGE(key: String) -> UIImage {
    return HCLocalizableManager.share.imageOf(key: key)
}

/// 获取国际化图片，返回图片String
func DEF_LOCALIZED_IMAGE_STRING(key: String) -> String {
    return HCLocalizableManager.share.imageStringOf(key: key)
}

enum HCLocalizableLanguage: String {
    case en = "en" // 英语
    case zh = "zh" // 中文
    case id = "id" // 印度尼西亚文
    case vi = "vi" // 越南文
    case th = "th" // 泰文
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
     * 图片模型数据
     * key: 主题key
     * value: 图片字典
     */
    private var images: [String: String] = [:]

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
        
        // 加载国际化图片资源
        
        let bundleName = resourcesJsonName + "_" + simplifyLanguage(bundleName)
        let resourcePath = Bundle.main.path(forResource: bundleName, ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: resourcePath!))
            self.images = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : String]
        } catch {
        }
        
        // 发送通知更新语言
        NotificationCenter.default.post(name: HCLocalizableManager.localizableDidChangeNotification, object: nil)
    }
    
    /// 初始化语言环境，在程序第一次启动是才生效
    /// - Parameters:
    ///   - bundleName: 不同国家语言，若传nil，表示默认获取系统语言
    ///   - imageJsonName: 图片名称json文件
    func initializeLanguage(_ bundleName: HCLocalizableLanguage?, imageJsonName: String) {
        guard let initialize = UserDefaults.standard.object(forKey: HCLocalizableManager.kInitializeLanguage),
            initialize as? Bool == true else {
                
                if let bName = bundleName {
                    updateLanguage(bName.rawValue)
                } else {
                    updateLanguage(systemLanguage())
                }
                resourcesJsonName = imageJsonName
    
                UserDefaults.standard.set(true, forKey: HCLocalizableManager.kInitializeLanguage)
                UserDefaults.standard.synchronize()
                return
        }
    }
    
    /// 获取系统当前语言
    func systemLanguage() -> String {
        let preferredLang = Bundle.main.preferredLocalizations.first! as String
//        debugPrint("当前系统语言:\(preferredLang)")
        return simplifyLanguage(preferredLang)
    }
    
    
    /// 精简语言
    private func simplifyLanguage(_ languange: String) -> String {
        if languange.contains("en") { //英语
            return "en"
        } else if languange.contains("zh") { //中国
            return "zh"
        } else if languange.contains("vi") { //越南
            return "vi"
        } else if languange.contains("th") { //泰国
            return "th"
        } else if languange.contains("id") { //印度尼西亚
            return "id"
        }else {
            return "en"
        }
    }

    /// 当前的语言文件
    private(set) var currentBundleName = "en"
    
    /// 当前的语言文件
    private(set) var resourcesJsonName = "LocalizableImage"
}

// MARK: - 国际化图片方法
extension HCLocalizableManager {
    /// 获取图片
    func imageOf(key: String) -> UIImage {
       
        if let imageStr = images[key],
            let img = UIImage(named: imageStr) {
           return img
        }
        
        return UIImage(color: UIColor.black, size: CGSize(width: 10, height: 10))
    }
    
    /// 获取国际化图片名称
    func imageStringOf(key: String) -> String {
        if let imageStr = images[key] {
            return imageStr
        }
        
        return ""
    }
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
