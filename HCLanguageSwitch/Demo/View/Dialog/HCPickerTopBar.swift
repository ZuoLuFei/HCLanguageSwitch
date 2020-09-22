/*******************************************************************************
 # File        : HCPickerTopBar.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/10/22
 # Corporation : ####
 # Description :
 ******************************************************************************/

import UIKit

class HCPickerTopBar: UIView {

    weak var cancelBtn: UIButton!
    weak var confirmBtn: UIButton!

    init() {
        super.init(frame: CGRect.zero)
        _initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("释放了\(HCPickerTopBar.self)")
    }

    private func _initUI() {
        let cancelBtn = UIButton()
        self.cancelBtn = cancelBtn
        self.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(24)
            make.top.bottom.equalTo(0)
            make.width.equalTo(80)
        }
        cancelBtn.contentHorizontalAlignment = .left
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.setTitleColor(UIColor.black, for: .normal)
        cancelBtn.hc_SetTitle("KG_取消", for: .normal)
        
        let confirmBtn = UIButton()
        self.confirmBtn = confirmBtn
        self.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.trailing.equalTo(-24)
            make.top.bottom.equalTo(0)
            make.width.equalTo(80)
        }
        confirmBtn.contentHorizontalAlignment = .right
        confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        confirmBtn.setTitleColor(UIColor.black, for: .normal)
        confirmBtn.hc_SetTitle("KG_确认", for: .normal)
    }
}
