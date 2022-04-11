//
//  UIView_xibFiles.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import UIKit

extension UIView {
    
    //
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
}
