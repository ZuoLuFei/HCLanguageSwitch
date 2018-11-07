/*******************************************************************************
 # File        : HCBaseDialog.swift
 # Project     : Dialog
 # Author      : ZuoLuFei
 # Created     : 2018/8/16
 # Corporation : ####
 # Description : 对话框基类, 封装的显示、隐藏动画，子类可自定义内容视图
 ******************************************************************************/

import UIKit

class HCBaseDialog: UIView {

    lazy var contentView = UIView()

    var useBaseAnimation: Bool = true

    init() {
        let frame = UIScreen.main.bounds
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: frame.size.width,
                                 height: frame.size.height * 2))
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.alpha = 0

        let hideBtn = UIButton()
        self.addSubview(hideBtn)
        hideBtn.snp.makeConstraints { (make) in
            make.top.equalTo(UIScreen.main.bounds.size.height)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(UIScreen.main.bounds.size.height)
        }
        hideBtn.addTarget(self, action: #selector(hide), for: .touchUpInside)

        self.addSubview(contentView)

        guard let keyWin = UIApplication.shared.keyWindow else { return }
        keyWin.addSubview(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        guard useBaseAnimation else { return }

        var frame = self.frame
        frame.origin.y = -frame.size.height / 2
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.alpha = 1
            self?.frame = frame
        }
    }

    @objc func hide() {
        var frame = self.frame
        frame.origin.y = 0
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alpha = 0
            self?.frame = frame
        }, completion: { [weak self] (_) in
            self?.removeFromSuperview()
        })
    }
}
