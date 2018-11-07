/*******************************************************************************
 # File        : HCLanguageModel.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/6/30
 # Corporation : ####
 # Description : 语言数据模型
 ******************************************************************************/

import UIKit

class HCLanguageModel: NSObject {

    /// 语言类型  如:zh_CN
    var type: String = ""
    /// 语言  如:中文简体
    var name: String = ""
    /// 资源bundle名称
    var bundle: String = ""
    /// 国家图片
    var countryImage: String = ""
    /// 是否可用  ture:可用 false:不可用
    var available: Bool = false
    /// 英文备注
    var englishAnno: String = ""
    /// 中文备注
    var chineseAnno: String = ""
    
    
    /// 数组转数组模型
    static func arrayToModel(_ data: [[String: Any]]?) -> [HCLanguageModel] {
        var list = [HCLanguageModel]()
        
        data?.forEach { (value) in
            let model = HCLanguageModel()
            model.type = value["type"] as? String ?? ""
            model.name = value["name"] as? String ?? ""
            model.bundle = value["bundle"] as? String ?? ""
            model.countryImage = value["countryImage"] as? String ?? ""
            model.available = value["available"] as? Bool ?? false
            model.englishAnno = value["englishAnno"] as? String ?? ""
            model.chineseAnno = value["chineseAnno"] as? String ?? ""
            
            list.append(model)
        }
        
        return list
    }
    
    
    /// 字典转模型
    static func dictToModel(_ data: [String: Any]?) -> HCLanguageModel {
        
        let model = HCLanguageModel()
        model.type = data?["type"] as? String ?? ""
        model.name = data?["name"] as? String ?? ""
        model.bundle = data?["bundle"] as? String ?? ""
        model.countryImage = data?["countryImage"] as? String ?? ""
        model.available = data?["available"] as? Bool ?? false
        model.englishAnno = data?["englishAnno"] as? String ?? ""
        model.chineseAnno = data?["chineseAnno"] as? String ?? ""
        
        return model
    }
}
