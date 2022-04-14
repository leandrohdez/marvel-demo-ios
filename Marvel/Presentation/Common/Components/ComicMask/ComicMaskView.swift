//
//  ComicMaskView.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import UIKit

class ComicMaskView: UIView {
    
    // MARK: Inspectables
    @IBInspectable var color: UIColor = UIColor.black
    
    @IBInspectable var offset: CGFloat = 16.0
    
    @IBInspectable var leftRigth: Bool = true
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if self.leftRigth {
            
            context.beginPath()
            context.move(to: CGPoint(x: rect.minX, y: rect.minY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            context.addLine(to: CGPoint(x: rect.minX, y: rect.minY + self.offset))
            context.closePath()
            
            self.color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            context.setFillColor(red: red, green: green, blue: blue, alpha: 1)
            context.fillPath()
            
            context.beginPath()
            context.move(to: CGPoint(x: rect.minX, y: rect.maxY - self.offset))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            context.closePath()

            self.color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            context.setFillColor(red: red, green: green, blue: blue, alpha: 1)
            context.fillPath()
            
        } else {
            
            context.beginPath()
            context.move(to: CGPoint(x: rect.minX, y: rect.minY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + self.offset))
            context.closePath()
            
            self.color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            context.setFillColor(red: red, green: green, blue: blue, alpha: 1)
            context.fillPath()
            
            context.beginPath()
            context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - self.offset))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            context.closePath()

            self.color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            context.setFillColor(red: red, green: green, blue: blue, alpha: 1)
            context.fillPath()
        }
    }
    
}
