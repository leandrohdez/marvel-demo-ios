//
//  StoryCell.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import UIKit

class StoryCell: UICollectionViewCell {

    // MARK: Statics
    static let cellIdentifier   = "reuseStoryCellIdentifier"
    
    static let className        = "StoryCell"
    
    static let nibInstance      = UINib(nibName: StoryCell.className, bundle: nil)
    
    static let height: CGFloat  = 170
    
    static let width: CGFloat   = 144
    
    // MARK: Outlets
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.image = nil
            avatarImageView.layer.cornerRadius = 64
            avatarImageView.clipsToBounds = true
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
