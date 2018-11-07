/*******************************************************************************
 # File        : HCLocalizableDeinitBlockExecutor.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/8/2
 # Corporation : ####
 # Description :
 <#Description Logs#>
 ******************************************************************************/

import UIKit

class HCLocalizableDeinitBlockExecutor: NSObject {

    var deinitBlock:(() -> Void)?

    /// 构造方法
    ///
    /// - Parameter deinitBlock: 接收更换主题模式的通知block
    /// - Returns: <#return value description#>
    class func executorWithDeinitBlock(_ deinitBlock:(() -> Void)?) -> HCLocalizableDeinitBlockExecutor {

        let deinitBlockExecutor: HCLocalizableDeinitBlockExecutor = HCLocalizableDeinitBlockExecutor()
        deinitBlockExecutor.deinitBlock = deinitBlock
        return deinitBlockExecutor

    }

    /// 执行析构方法，释放注册的通知
    deinit {
        if deinitBlock != nil {
            deinitBlock!()
            deinitBlock = nil
        }
    }

}
