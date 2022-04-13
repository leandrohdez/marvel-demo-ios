//
//  MainHeaderView.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import UIKit

class MainHeaderView: UIView {
    
    // MARK: Statics
    static let pullToReloadHeight: CGFloat = 100.0
    
    // MARK: Properties
    var isLoading: Bool = false {
        didSet {
            performLoading()
        }
    }
    
    var originOffset: CGFloat?
    
    private let diagonalDesviation: CGFloat = 16.0
    
    private let color: UIColor = UIColor.ui.white
    
    // MARK: Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var popularTitleLabel: UILabel!
    
    @IBOutlet weak var popularsCollectionView: UICollectionView!
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    
    @IBOutlet weak var spinerIndicator: UIActivityIndicatorView! {
        didSet {
            spinerIndicator.stopAnimating()
        }
    }
    
    // MARK: Handlers
    var pullToReload: (() -> Void)?
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - self.diagonalDesviation))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.closePath()
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        self.color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        context.setFillColor(red: red, green: green, blue: blue, alpha: 1)
        context.fillPath()
    }
    
}

// MARK: - Methods
extension MainHeaderView {
    
    //
    public func scrollView(offset: CGFloat) {
        
        if self.originOffset == nil {
            self.originOffset = abs(offset)
            
        } else {
            if offset < 0, !self.isLoading {
                
                let realOffset = abs(offset) - self.originOffset!
                let alpha = (realOffset >= 100) ? 1 : realOffset/100
                
                self.popularTitleLabel.alpha        = 1-alpha
                self.popularsCollectionView.alpha   = 1-alpha
                self.mainTitleLabel.alpha           = 1-alpha
                
                self.spinerIndicator.alpha          = alpha
                
                // user wants pullToReload
                if realOffset > Self.pullToReloadHeight, !self.isLoading {
                    self.isLoading = true
                    self.pullToReload?()
                }
            
            } else {
                self.performLoading()
            }
        }
    }
    
    //
    private func performLoading() {
        if self.isLoading {
            self.popularTitleLabel.alpha        = 0
            self.popularsCollectionView.alpha   = 0
            self.mainTitleLabel.alpha           = 0
            
            self.spinerIndicator.alpha          = 1
            self.spinerIndicator.startAnimating()
        } else {
            self.popularTitleLabel.alpha        = 1
            self.popularsCollectionView.alpha   = 1
            self.mainTitleLabel.alpha           = 1
            
            self.spinerIndicator.alpha          = 0
            self.spinerIndicator.stopAnimating()
        }
    }
}
