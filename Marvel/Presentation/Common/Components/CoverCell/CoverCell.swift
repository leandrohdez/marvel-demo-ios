//
//  CoverCell.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import UIKit

class CoverCell: UICollectionViewCell {

    // MARK: Statics
    static let cellIdentifier   = "reuseCoverCellIdentifier"
    
    static let className        = "CoverCell"
    
    static let nibInstance      = UINib(nibName: CoverCell.className, bundle: nil)
    
    static let height: CGFloat  = 266
    
    static let width: CGFloat   = 144
    
    // MARK: Outlets
    @IBOutlet weak var coverImageView: UIImageView! {
        didSet {
            coverImageView.image = nil
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = ""
        }
    }
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
