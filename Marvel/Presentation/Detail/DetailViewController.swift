//
//  DetailViewController.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import UIKit
import AlamofireImage

class DetailViewController: BaseViewController {

    // MARK: Properties
    private var offsetY: CGFloat?
    
    private var heroViewData: HeroDetailViewData?
    
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
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = ""
        }
    }
    
    @IBOutlet weak var comicsCollectionView: UICollectionView! {
        didSet {
            comicsCollectionView.delegate = self
            comicsCollectionView.dataSource = self
            comicsCollectionView.register(CoverCell.nibInstance, forCellWithReuseIdentifier: CoverCell.cellIdentifier)
        }
    }
    
    @IBOutlet weak var seriesCollectionView: UICollectionView! {
        didSet {
            seriesCollectionView.delegate = self
            seriesCollectionView.dataSource = self
            seriesCollectionView.register(CoverCell.nibInstance, forCellWithReuseIdentifier: CoverCell.cellIdentifier)
        }
    }
    
    @IBOutlet weak var storiesCollectionView: UICollectionView! {
        didSet {
            storiesCollectionView.delegate = self
            storiesCollectionView.dataSource = self
            storiesCollectionView.register(StoryCell.nibInstance, forCellWithReuseIdentifier: StoryCell.cellIdentifier)
        }
    }
    
    // MARK: Presenter
    var detailPresenter: DetailPresenter!
    override var presenter: DetailPresenter! {
        return detailPresenter
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.title = "Character"
        self.view.backgroundColor = UIColor.ui.white
    }
    
    override func startLoading() {
        super.startLoading()
        self.view.endEditing(true)
        self.view.isUserInteractionEnabled = false
    }
    
    override func stopLoading() {
        super.stopLoading()
        self.view.endEditing(true)
        self.view.isUserInteractionEnabled = true
    }
}

// MARK: - Presenter Methods
extension DetailViewController: DetailPresenterView {
    
    //
    func performHero(heroViewData: HeroDetailViewData) {
        
        self.heroViewData           = heroViewData

        self.nameLabel.text         = heroViewData.name
        self.descriptionLabel.text  = !heroViewData.description.isEmpty ? heroViewData.description : "No description"

        if let url = heroViewData.avatarURL {
            if heroViewData.avatarURL?.absoluteString.contains("image_not_available") ?? false {
                self.avatarImageView.image = AvatarViewData.default
            } else {
                self.avatarImageView.load(url: url)
            }
        } else {
            self.avatarImageView.image = UIImage()
        }
        
        self.comicsCollectionView.reloadData()
        self.seriesCollectionView.reloadData()
        self.storiesCollectionView.reloadData()
    }
    
}

// MARK: - CollectionView Methods
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.comicsCollectionView {
            return self.heroViewData?.comics.count ?? 0
        } else if collectionView == self.seriesCollectionView {
            return self.heroViewData?.series.count ?? 0
        } else if collectionView == self.storiesCollectionView {
            return self.heroViewData?.stories.count ?? 0
        }
        return 0
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let hero = self.heroViewData else { return UICollectionViewCell() }
        
        // Comics
        if collectionView == self.comicsCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoverCell.cellIdentifier, for: indexPath)
                as? CoverCell else { return UICollectionViewCell() }
            
            let comic = hero.comics[indexPath.row]
            
            cell.titleLabel.text = comic.title
            
            if let url = comic.coverURL {
                cell.coverImageView.image = UIImage()
                cell.coverImageView.load(url: url)
            } else {
                cell.coverImageView.image = UIImage()
            }
            
            return cell
        }
        
        // Series
        else if collectionView == self.seriesCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoverCell.cellIdentifier, for: indexPath)
                as? CoverCell else { return UICollectionViewCell() }
            
            let serie = hero.series[indexPath.row]
            
            cell.titleLabel.text = serie.title
            
            if let url = serie.coverURL {
                cell.coverImageView.image = UIImage()
                cell.coverImageView.load(url: url)
            } else {
                cell.coverImageView.image = UIImage()
            }
            
            return cell
        }
        
        // Stories
        else if collectionView == self.storiesCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCell.cellIdentifier, for: indexPath)
                as? StoryCell else { return UICollectionViewCell() }
            
            let story = hero.stories[indexPath.row]
            
            cell.titleLabel.text = story.title
            
            if let url = story.coverURL {
                
                cell.avatarImageView.load(url: url)
                
            } else if let url = hero.avatarURL {
                    
                if hero.avatarURL?.absoluteString.contains("image_not_available") ?? false {
                    cell.avatarImageView.image = AvatarViewData.default
                } else {
                    cell.avatarImageView.load(url: url)
                }
                
            } else {
                cell.avatarImageView.image = UIImage()
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.comicsCollectionView {
            print("comic selected: \(indexPath.row)")
            
        } else if collectionView == self.seriesCollectionView {
            print("serie selected: \(indexPath.row)")
            
        } else if collectionView == self.storiesCollectionView {
            print("story selected: \(indexPath.row)")
        }
    }
    
}

// MARK: - Methods
extension DetailViewController: UICollectionViewDelegateFlowLayout {

    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.comicsCollectionView || collectionView == self.seriesCollectionView {
            return CGSize(width: CoverCell.width, height: CoverCell.height)
        } else if collectionView == self.storiesCollectionView {
            return CGSize(width: StoryCell.width, height: StoryCell.height)
        } else {
            return CGSize.zero
        }
    }

}

// MARK: - Methods
extension DetailViewController {
    
    //
    @IBAction func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
