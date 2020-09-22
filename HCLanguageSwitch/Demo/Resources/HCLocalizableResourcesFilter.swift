/*******************************************************************************
 # File        : HCLocalizableResourcesFilter.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/8/2
 # Corporation : ####
 # Description :
 ******************************************************************************/

import UIKit

enum KCLanguageType: String {
    case english = "en_US"              // 英语
//    case russia = "ru_RU"               // 俄罗斯语
//    case korean = "ko_KR"               // 韩语
//    case portuguese = "pt_PT"           // 葡萄牙语
    case chineseSimple = "zh_CN"        // 中文简体
//    case chineseTraditional = "zh_HK"   // 中文繁体
//    case dutch = "nl_NL"                // 荷兰语
//    case french = "fr_FR"               // 法语
//    case spain = "es_ES"                // 西班牙语
//    case vietnamese = "vi_VN"           // 越南语
//    case turkish = "tr_TR"              // 土耳其语
}

class HCLocalizableResourcesFilter: NSObject {

    static let share = HCLocalizableResourcesFilter()
    
    // 语言模型列表
    private(set) var datas: [HCLanguageModel] = []
    
    // 语言名字列表
    private(set) var names: [String] = []
    
    override init() {
        self.datas = HCLocalizableResourcesFilter.defaultLanguageList()
        self.names = datas.map({ (model) -> String in
            return model.name
        })
    }
    
    /**
     * 根据语言类型加载指定的语言模型
     */
    public func modelFromName(_ name: String) -> HCLanguageModel? {
        for model in datas where model.name == name {
            return model
        }
        return nil
    }
    
    /**
     * 根据语言文件加载指定的语言模型
     */
    public func modelFromBundle(_ bundle: String) -> HCLanguageModel? {
        for model in datas where model.bundle == bundle {
            return model
        }
        return nil
    }
    
    
    /// 当前的语言文字
    var currentLanguageName: String {
        get {
//            print("currentBundleName->",HCLocalizableManager.share.currentBundleName)
            return modelFromBundle(HCLocalizableManager.share.currentBundleName)?.name ?? "English"
        }
    }
    
    /// 当前的语言文字type，后端需要传入
    var currentLanguageType: String {
        get {
            return modelFromBundle(HCLocalizableManager.share.currentBundleName)?.type ?? "en_US"
        }
    }

    /// 默认语言列表
    static func defaultLanguageList() -> [HCLanguageModel] {
        let path = Bundle.main.path(forResource: "LanguageTypeAndBundle.json", ofType: nil)
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!))
            let list = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: Any]]

            return HCLanguageModel.arrayToModel(list)
        } catch {
            return []
        }
    }

}
