//
//  MainHiddenView.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import UIKit

class MainHiddenView: UIView {
    
    // MARK: Properties
    private var originOffset: CGFloat?
    
    // MARK: Outlets
    @IBOutlet weak var monsterImageView: UIImageView! {
        didSet {
            monsterImageView.alpha = 0
        }
    }
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: - Methods
extension MainHiddenView {
    
    //
    public func scrollView(offset: CGFloat) {
        
        if self.originOffset == nil {
            self.originOffset = abs(offset)
        } else {
            if offset < 0 {
                let realOffset = abs(offset) - self.originOffset!
                let alpha = (realOffset >= 100) ? 1 : realOffset/100
                self.monsterImageView.alpha = alpha
            } else {
                self.monsterImageView.alpha = 0
            }
        }
    }
    
}
