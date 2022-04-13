//
//  HeroCell.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import UIKit

class HeroCell: UITableViewCell {
    
    // MARK: Statics
    static let cellIdentifier   = "reuseHeroCellIdentifier"
    
    static let className        = "HeroCell"
    
    static let nibInstance      = UINib(nibName: HeroCell.className, bundle: nil)
    
    static let height: CGFloat  = 160
    
    // MARK: Properties
    public var maskType: ComicMaskType = .leftRigth {
        didSet {
            performMask()
        }
    }
    
    // MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = ""
            nameLabel.layer.shadowColor = UIColor.black.cgColor
            nameLabel.layer.shadowRadius = 1.0
            nameLabel.layer.shadowOpacity = 1.0
            nameLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
            nameLabel.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.image = nil
        }
    }
    
    @IBOutlet weak var shadowView: GradientView!
    
    @IBOutlet weak var comicMaskView1: ComicMaskView! {
        didSet {
            comicMaskView1.isHidden = false
        }
    }
    
    @IBOutlet weak var comicMaskView2: ComicMaskView! {
        didSet {
            comicMaskView2.isHidden = true
        }
    }
    
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
 
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.selectionStyle = .none
        UIView.animate(withDuration: 0.2) {
            self.avatarImageView.alpha = (highlighted) ? 0.5 : 1.0
        }
    }
    
}

// MARK: - Methods
extension HeroCell {
    
    //
    private func performMask() {
        
        switch self.maskType {
            
        case .leftRigth:
            self.comicMaskView1.isHidden = false
            self.comicMaskView2.isHidden = true
            
        case .rigthLeft:
            self.comicMaskView1.isHidden = true
            self.comicMaskView2.isHidden = false
        }
    }
    
}
