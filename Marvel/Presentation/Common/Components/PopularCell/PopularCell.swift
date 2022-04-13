//
//  PopularCell.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import UIKit

class PopularCell: UICollectionViewCell {

    // MARK: Statics
    static let cellIdentifier   = "reusePopularCellIdentifier"
    
    static let className        = "PopularCell"
    
    static let nibInstance      = UINib(nibName: PopularCell.className, bundle: nil)
    
    static let height: CGFloat  = 240
    
    static let width: CGFloat   = 160
    
    // MARK: Outlets
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.image = nil
        }
    }
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
