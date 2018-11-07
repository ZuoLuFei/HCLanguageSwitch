/*******************************************************************************
 # File        : HCPickerView.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/9/13
 # Corporation : ####
 # Description :
 ******************************************************************************/

import UIKit

class HCPickerView: HCBaseDialog {
    private weak var bar: HCPickerTopBar!
    private weak var pickerView: UIPickerView!

    private var datas: [String] = []
    private var confirmBlock: ((_ row: Int) -> Void)?
    private var finishBlock: (() -> Void)?

    override init() {
        super.init()
        _initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(datas: [String],
              confirm: ((_ row: Int) -> Void)?,
              finish: (() -> Void)? = nil) {
        super.show()

        self.datas = datas
        self.confirmBlock = confirm
        self.finishBlock = finish
        pickerView.reloadComponent(0)
    }

    override func hide() {
        finishBlock?()
        super.hide()
    }

    private func _initUI() {
        _initBar()
        _initPicker()

        let contentHeight: CGFloat = 244
        contentView.frame = CGRect(x: 0,
                                   y: UIScreen.main.bounds.size.height * 2 - contentHeight,
                                   width: UIScreen.main.bounds.size.width,
                                   height: contentHeight)
    }

    private func _initBar() {
        let bar = HCPickerTopBar()
        self.bar = bar
        contentView.addSubview(bar)
        bar.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(0)
            make.height.equalTo(44)
        }
        bar.backgroundColor = UIColor.white
        bar.cancelBtn.addTarget(self, action: #selector(_handleCancel), for: .touchUpInside)
        bar.confirmBtn.addTarget(self, action: #selector(_handleConfirm), for: .touchUpInside)
    }

    private func _initPicker() {
        let pickerView = UIPickerView()
        self.pickerView = pickerView
        contentView.addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(0)
            make.top.equalTo(bar.snp.bottom)
        }
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.white
    }

    @objc private func _handleCancel() {
        hide()
    }

    @objc private func _handleConfirm() {
        confirmBlock?(pickerView.selectedRow(inComponent: 0))
        hide()
    }

}

extension HCPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datas.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let itemView = Item()
        itemView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 32)
        itemView.text = datas[row]
        return itemView
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 32
    }

    class Item: UILabel {
        init() {
            super.init(frame: CGRect.zero)
            _initUI()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func _initUI() {
            textAlignment = .center
            font = UIFont.systemFont(ofSize: 20)
            
        }
    }
}
