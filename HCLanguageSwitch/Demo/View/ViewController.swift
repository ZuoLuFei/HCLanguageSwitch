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
                            confirm: {[weak self] (index) in
                                
                                let language = HCLocalizableResourcesFilter.share.names[index]
                                guard let model = HCLocalizableResourcesFilter.share.modelFromName(language) else { return }
                                HCLocalizableManager.share.updateLanguage(model.bundle)
                                
                                self?.currentLanguageLabel.text = DEF_LOCALIZED_STRING(key: "first_currentLanguage") + HCLocalizableResourcesFilter.share.currentLanguageName
                        
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 使用方式一
        titleWordLabel.hc_Text = "first_inputName"
        changeLanuageBtn.hc_SetTitle("first_changeLanguage", for: .normal)
        
        /// 使用方式二
        currentLanguageLabel.text = DEF_LOCALIZED_STRING(key: "first_currentLanguage") + HCLocalizableResourcesFilter.share.currentLanguageName
        
        /// 使用方法三
        contentTextField.placeholder = DEF_LOCALIZED_STRING(key: "first_name")
        HCLocalizableManager.share.localizableDidChange {[weak self] in
            self?.contentTextField.placeholder = DEF_LOCALIZED_STRING(key: "first_name")
        }
    
    }
}



