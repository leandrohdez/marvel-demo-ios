//
//  MainViewController.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import UIKit
import AlamofireImage

class MainViewController: BaseViewController {

    // MARK: Properties
    private var heroesViewData: [HeroViewData]?
    
    private var popularHeroesViewData: [HeroViewData]?
    
    // MARK: Elements
    private let hiddenView: MainHiddenView = UIView.fromNib()
    
    private let headerView: MainHeaderView = UIView.fromNib()
    
    private let footerView: MainFooterView = UIView.fromNib()
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(HeroCell.nibInstance, forCellReuseIdentifier: HeroCell.cellIdentifier)
            tableView.tableHeaderView = headerView
            tableView.tableFooterView = footerView
        }
    }
    
    // MARK: Constraints
    @IBOutlet weak var scrollButtonLeadingConstraint: NSLayoutConstraint! {
        didSet {
            scrollButtonLeadingConstraint.constant = -48
        }
    }
    
    // MARK: Presenter
    var mainPresenter: MainPresenter!
    override var presenter: MainPresenter! {
        return mainPresenter
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.pullToReload = {
            self.pullToReload()
        }
        
        self.headerView.popularsCollectionView.register(PopularCell.nibInstance, forCellWithReuseIdentifier: PopularCell.cellIdentifier)
        self.headerView.popularsCollectionView.delegate = self
        self.headerView.popularsCollectionView.dataSource = self
        
        self.setupView()
    }
    
    private func setupView() {
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        
        self.navigationController?.navigationBar.tintColor = UIColor.ui.black
        
        self.navigationItem.scrollEdgeAppearance = navigationBarAppearance
        self.navigationItem.standardAppearance = navigationBarAppearance
        self.navigationItem.compactAppearance = navigationBarAppearance
        
        self.navigationController?.setNeedsStatusBarAppearanceUpdate()
        
        self.hiddenView.frame = CGRect(x: 0.0, y: -UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.tableView.insertSubview(hiddenView, at: 0)
        
        self.tableView.backgroundColor = UIColor.ui.white
        self.tableView.backgroundView?.backgroundColor = UIColor.ui.white
        self.view.backgroundColor = UIColor.ui.white
        
        self.headerView.popularsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    override func startLoading() {
        super.startLoading()
        self.view.endEditing(true)
        self.headerView.isLoading = true
        self.footerView.spinerIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    override func stopLoading() {
        super.stopLoading()
        self.view.endEditing(true)
        self.headerView.isLoading = false
        self.footerView.spinerIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
}

// MARK: - Presenter Methods
extension MainViewController: MainPresenterView {
    
    //
    func performHeroes(heroesViewData: [HeroViewData]) {
        if self.heroesViewData == nil {
            self.heroesViewData = heroesViewData
        } else {
            self.heroesViewData! += heroesViewData
        }
        self.tableView.reloadData()
    }
    
    //
    func performMostPopularHeroes(heroesViewData: [HeroViewData]) {
        self.popularHeroesViewData = heroesViewData
        self.headerView.popularsCollectionView.reloadData()
    }
    
}

// MARK: - TableView Methods
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.heroesViewData != nil) ? 1 : 0
    }
    
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let heroes = self.heroesViewData else { return 0 }
        return heroes.count
    }
    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.cellIdentifier, for: indexPath)
            as? HeroCell else { return UITableViewCell() }
        
        guard let heroes = self.heroesViewData else { return UITableViewCell() }
        
        let hero = heroes[indexPath.row]
        
        cell.nameLabel.text = hero.name
        cell.avatarImageView.backgroundColor = UIColor.ui.cultured
        cell.shadowView.isHidden = true
        
        if let url = hero.avatarURL {
            
            if hero.avatarURL?.absoluteString.contains("image_not_available") ?? false {
                cell.avatarImageView.image = AvatarViewData.default
            } else {
                cell.avatarImageView.image = UIImage()
                cell.avatarImageView.load(url: url) { image in
                    cell.avatarImageView.image = image
                    cell.shadowView.isHidden = false
                }
            }
            
        } else {
            cell.avatarImageView.image = UIImage()
        }
        
        cell.maskType = (indexPath.row % 2 == 0) ? .leftRigth : .rigthLeft
        
        return cell
    }

    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HeroCell.height
    }
    
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let heroes = self.heroesViewData else { return }
        self.presenter.detailAction(heroId: heroes[indexPath.row].id)
    }
    
}

// MARK: - CollectionView Methods
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let heroes = self.popularHeroesViewData {
            return heroes.count
        }
        return 0
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.cellIdentifier, for: indexPath)
            as? PopularCell else { return UICollectionViewCell() }
        
        guard let heroes = self.popularHeroesViewData else { return UICollectionViewCell() }
        
        let hero = heroes[indexPath.row]
        
        if let url = hero.avatarURL {
            
            cell.avatarImageView.image = UIImage()
            cell.avatarImageView.load(url: url) { image in
                cell.avatarImageView.image = image
            }
            
        } else {
            cell.avatarImageView.image = UIImage()
        }
        
        return cell
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let heroes = self.popularHeroesViewData else { return }
        self.presenter.detailAction(heroId: heroes[indexPath.row].id)
    }
}

// MARK: - Actions
extension MainViewController {
    
    //
    @IBAction func scrollButtonTapped() {
        self.tableView.setContentOffset( CGPoint(x: 0, y: -(self.headerView.originOffset ?? 0)), animated: true)
    }
    
    //
    private func pullToReload() {
        self.heroesViewData = nil
        self.startLoading()
        self.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.presenter.reloadAction()
        }
    }
    
}

// MARK: - UIScrollViewDelegate
extension MainViewController: UIScrollViewDelegate {
    
    //
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.tableView {
            
            let minValues = 10
            let offset = scrollView.contentOffset.y
            let targetHeight = (scrollView.contentSize.height - (scrollView.frame.size.height))
            
            // Views offset behaivors
            self.hiddenView.scrollView(offset: offset)
            self.headerView.scrollView(offset: offset)
            
            // Scroll to top button
            self.scrollButtonLeadingConstraint.constant = (offset > 900) ? 0 : -48
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
            
            // load more items
            guard let items = self.heroesViewData else { return }
            
            if offset >= 0, items.count > minValues, offset >= targetHeight {
                self.presenter.loadMoreAction()
            }
        }
    }
    
}
