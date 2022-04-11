//
//  MainFooterView.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import UIKit

class MainFooterView: UIView {
    
    // MARK: Properties
    private let diagonalDesviation: CGFloat = 16.0
    
    private let color: UIColor = UIColor.ui.cadmium
    
    // MARK: Outlets
    @IBOutlet weak var spinerIndicator: UIActivityIndicatorView! {
        didSet {
            spinerIndicator.stopAnimating()
        }
    }
    
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
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.minY + self.diagonalDesviation))
        context.closePath()
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        self.color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        context.setFillColor(red: red, green: green, blue: blue, alpha: 1)
        context.fillPath()
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY-1))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY-1))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.minY + self.diagonalDesviation-1))
        context.closePath()

        context.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
        context.fillPath()
          
    }
    
}
