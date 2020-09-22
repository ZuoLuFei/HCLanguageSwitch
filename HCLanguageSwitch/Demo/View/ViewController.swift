/*******************************************************************************
 # File        : ViewController.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/6/30
 # Corporation : ####
 # Description : 
 ******************************************************************************/

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleWordLabel: UILabel!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var changeLanuageBtn: UIButton!
    @IBOutlet weak var currentLanguageLabel: UILabel!
    @IBOutlet weak var currentImageView: UIImageView!
    
    @IBAction func changeLanguageBtnClick(_ sender: UIButton) {
        
        /// 语言切换调用方法
        HCPickerView().show(datas: HCLocalizableResourcesFilter.share.names,
                            confirm: {[weak self] (index) in
                                let language = HCLocalizableResourcesFilter.share.names[index]
                                guard let model = HCLocalizableResourcesFilter.share.modelFromName(language) else { return }
                                // 切换语言，参数为bundleName
                                HCLocalizableManager.share.updateLanguage(model.bundle)
                                
//                                print("titleWordLabel.hc_Text->%@", self?.titleWordLabel.hc_Text)
//                                NSLog("titleWordLabel.hc_Text->%@", self?.titleWordLabel.hc_Text)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - 文字国际化
        textLocalizeble()
        
        // MARK: - 图片国际化
        textLocalizebleImage()
        
        HCLocalizableManager.share.languageDidChange(<#T##didChange: (() -> Void)?##(() -> Void)?##() -> Void#>)
        
        //语言切换监听
        HCLocalizableManager.share.languageDidChange {
            debugPrint("语言切换了")
            // 当前语言type,后端需要数据
            debugPrint("当前语言type:" + HCLocalizableResourcesFilter.share.currentLanguageType)
        }
    }
    
    /**
     文字国际化流程：
     1.导入LanguageSwitch文件夹内容到项目中
     2.创建Localizable.strings国际化文档，并将国际化文件导入其中，具体请移步Localizable.strings文件，关于Localizable.strings创建步骤请自行百度
     3.使用如下方式开始文字国际化
     */
    func textLocalizeble() {
//        // 使用方式一：对语言切换感知度低的界面，采用最近宏定义取值（如界面不是常驻界面，加载必刷新，对语言切换响应感知度极低）
        titleWordLabel.text = DEF_LOCALIZED_STRING(key: "KG_请输入姓名")
        changeLanuageBtn.setTitle(DEF_LOCALIZED_STRING(key: "first_changeLanguage") , for: .normal)
        contentTextField.placeholder = DEF_LOCALIZED_STRING(key: "first_name")
        // 字符串拼接
        currentLanguageLabel.text = String.init(format: DEF_LOCALIZED_STRING(key:"first_currentLanguage%@---%@"), HCLocalizableResourcesFilter.share.currentLanguageName, DEF_LOCALIZED_STRING(key: "KG_请输入姓名"))
        
        // 使用方法二：对语言感知度高，采用分类属性方法，此方法通过关联技术，会根据语言切换立即感知，并且切换语言（如界面是常驻界面，如UITabbarController界面，切换语言不会刷新界面，但是对语言切换感知度高，需要采用分类属性方法）
        titleWordLabel.hc_Text = "KG_请输入姓名"
        changeLanuageBtn.hc_SetTitle("first_changeLanguage", for: .normal)
        contentTextField.hc_PlaceholderSwitch = "first_name"
        // 属性方法的字符串拼接
        currentLanguageLabel.hc_Text = "KG_当前语言：%@---%@" + "&&&" + HCLocalizableResourcesFilter.share.currentLanguageName + "&&&" + "KG_请输入姓名"
//
////         "first_currentLanguage%@---%@&&&中文简体&&&请输入姓名”
//
//
//        /// 使用方法三，在特殊情况需要传输字符时，需要手动监听语言更新，注意：参数使用&&&进行分割
//        currentLanguageLabel.hc_Text = "KG_当前语言：%@---%@" + "&&&" + HCLocalizableResourcesFilter.share.currentLanguageName + "&&&" + "KG_请输入姓名"
        currentLanguageLabel.localizableDidChange { [weak self] in
            self?.currentLanguageLabel.text = String.init(format: DEF_LOCALIZED_STRING(key:"KG_当前语言：%@---%@"), HCLocalizableResourcesFilter.share.currentLanguageName, DEF_LOCALIZED_STRING(key: "KG_请输入姓名"))
        }
    }
    
    /**
    图片国际化流程：
    1.导入LanguageSwitch文件夹内容到项目中
    2.导入需要国际化图片，并将国际化图片根据语言区配置到xxxx_zh.json中，具体参考此Demo中的LocalizableImage_en.json文件，注意新增语言时，要在HCLocalizableLanguager.swift文件中的HCLocalizableLanguage枚举新增budle名
    3.将图片统一Key配置到HCLocalizableImage中，方便读取
    4.使用功能如下方法开始图片国际化
    */
    func textLocalizebleImage() {
        // 使用方式一：对语言切换感知度低的界面，采用最近宏定义取值（如此界面不是常驻界面，加载必刷新，对语言切换响应感知度极低）
//        currentImageView.image = DEF_LOCALIZED_IMAGE(key: "HC_App_Store")
//        currentImageView.image = UIImage.init(named: DEF_LOCALIZED_IMAGE_STRING(key: "HC_App_Store"))
//
//        // 使用方法二：对语言感知度高，采用分类属性方法，此方法通过关联技术，会根据语言切换立即感知，并且切换语言（如此界面是常驻界面，如UITabbarController界面，切换语言不会刷新界面，但是对语言切换感知度高，需要采用分类属性方法）
        currentImageView.hc_Image = "HC_App_Store"
    }
    
}
