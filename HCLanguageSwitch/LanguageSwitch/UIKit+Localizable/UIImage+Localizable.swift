/*******************************************************************************
# File        : UIImage+Localizable.swift
# Project     : HCLanguageSwitch
# Author      : ZuoLuFei
# Created     : 2020/9/8
# Corporation : ****
# Description :
<#Description Logs#>
 *******************************************************************************/

import UIKit

public extension UIImage {
    
    /// Create UIImage from color and size.
    ///
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        
        self.init(cgImage: aCgImage)
    }
    
}

