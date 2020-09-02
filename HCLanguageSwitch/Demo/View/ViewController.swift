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
    
    @IBAction func changeLanguageBtnClick(_ sender: UIButton) {
        HCPickerView().show(datas: HCLocalizableResourcesFilter.share.names,
                            confirm: {(index) in
                                let language = HCLocalizableResourcesFilter.share.names[index]
                                guard let model = HCLocalizableResourcesFilter.share.modelFromName(language) else { return }
                                // 切换语言，参数为bundleName
                                HCLocalizableManager.share.updateLanguage(model.bundle)
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 使用方式一，正常推荐使用
        titleWordLabel.hc_Text = "first_inputName"
        changeLanuageBtn.hc_SetTitle("first_changeLanguage", for: .normal)
        contentTextField.hc_PlaceholderSwitch = "first_name"
        
        /// 使用方法二，在特殊情况需要传输字符时，需要手动监听语言更新，注意：参数使用&&&进行分割
        currentLanguageLabel.hc_Text = "first_currentLanguage%@%@" + "&&&" + HCLocalizableResourcesFilter.share.currentLanguageName + "&&&" + "first_inputName"
        contentTextField.localizableDidChange { [weak self] in
            self?.currentLanguageLabel.text = String.init(format: DEF_LOCALIZED_STRING(key:"first_currentLanguage%@%@"), HCLocalizableResourcesFilter.share.currentLanguageName, DEF_LOCALIZED_STRING(key: "first_inputName"))
        }
    }
}
