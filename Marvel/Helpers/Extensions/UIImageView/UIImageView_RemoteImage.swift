//
//  UIImageView_RemoteImage.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import UIKit

extension UIImageView {
    
    func load(url: URL, completion: ((_ image: UIImage) -> Void)? = nil) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                    completion?(image)
                }
            }
        }
    }
    
}
