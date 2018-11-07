/*******************************************************************************
 # File        : NSObject+LocalizableDeinit.swift
 # Project     : HCLanguageSwitch
 # Author      : ZuoLuFei
 # Created     : 2018/8/2
 # Corporation : ####
 # Description :
 <#Description Logs#>
 ******************************************************************************/

import UIKit

extension NSObject {

    /// 记录需要释放的通知主体
    func addLocalizableDeinitBlock(_ deinitBlock:(() -> Void)?) -> Any? {

        guard let deinitBlock = deinitBlock else { return nil }

        let deinitBlockExecutor: HCLocalizableDeinitBlockExecutor = HCLocalizableDeinitBlockExecutor.executorWithDeinitBlock(deinitBlock)

        return deinitBlockExecutor
    }
}
