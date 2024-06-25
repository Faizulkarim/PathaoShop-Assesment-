//
//  CategoryItemViewController.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

protocol CategoryItemViewControllerDelegate: AnyObject{
    func reloadHome()
}
// MARK: CategoryItemViewController
final class CategoryItemViewController: BaseCategoryItemViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var badgeButton : BadgeButton!
    @IBOutlet weak var backButtonView: OTDynamicButton!
    @IBOutlet weak var categoryItemCollectionView : UICollectionView!
    
    private var router: CategoryItemRouter?
    private let viewModel: CategoryItemViewModelType
    var displayModel = CategoryItemDisplayModel()
    var delegate: CategoryItemViewControllerDelegate?
    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    
    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: CategoryItemViewModelType,
         router: CategoryItemRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(analyticsManager: analyticsManager, theme: theme)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        setupRouter()
        viewDidLoadSubject.send()
        updateShopItem()
        setupUI()
    }
    
}

// MARK: Private Default Methods
private extension CategoryItemViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }
    
    /// Setup UI
    private func setupUI() {
        badgeButton.handleTapToAction {
            self.router?.routeToStore()
        }
        loadDefaultView()
        setUpItemCollectionView()
    }
    func loadDefaultView(){
        let backButtonViewModel = OTDynamicButtonViewModel(img: theme.imageTheme.navBack.withRenderingMode(.alwaysOriginal), title: "", titleFont: nil, titleColor: theme.colorTheme.clearColor, backgroundColor: theme.colorTheme.clearColor, borderColor: theme.colorTheme.clearColor, cornerRadius: 0, isHidden: false)
        self.backButtonView.configureView(viewModel: backButtonViewModel) { [weak self] sender in
            if self?.displayModel.isDataChange ?? false {
                self?.delegate?.reloadHome()
            }
            self?.router?.back()
        }
        
    }
    func setUpItemCollectionView(){
        categoryItemCollectionView.register(UINib(nibName: "ShopItemCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ShopItemCollectionViewCell")
        categoryItemCollectionView.delegate = self
        categoryItemCollectionView.dataSource = self
        categoryItemCollectionView.reloadData()
    }
    
    
    /// Bind viewmodel
    private func bind(to viewModel: CategoryItemViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = CategoryItemViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }
    
    /// Render UI
    private func render(_ state: CategoryItemViewState) {
        switch state {
        case .viewDidLoad:
            break
        case .loading(let shouldShow):
            shouldShow ? addLoadIndicator() : removeLoadIndicator()
        }
    }
    
}
extension CategoryItemViewController {
    
    func updateShopItem() {
        self.badgeButton.setBadgeValue(StoreManager.shared.itemCount)
    }
}

extension CategoryItemViewController : StoreViewControllerDelegate{
    func reloadHome() {
        self.updateShopItem()
        self.categoryItemCollectionView.reloadData()
    }
}
extension CategoryItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.displayModel.categoryItemData?.items?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            String(describing: ShopItemCollectionViewCell.self),
                                                         for: indexPath) as? ShopItemCollectionViewCell {
            cell.theme = theme
            cell.indexPath = indexPath
            let shopItem = self.displayModel.categoryItemData?.items?[indexPath.row]
            cell.delegate = self
            cell.configureCell(cellViewModel: shopItem)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    
}

extension CategoryItemViewController : ShopItemCollectionDelegate{
    func addButtonTapped(position: IndexPath?) {
        if let cell = categoryItemCollectionView.cellForItem(at: position!) as? ShopItemCollectionViewCell {
            let selectedItem = self.displayModel.categoryItemData?.items?[position?.row ?? 0]
            StoreManager.shared.saveItem(item: selectedItem)
            let count = StoreManager.shared.getSelectedItemCount(item: selectedItem)
            cell.updateCount(totalCount: count)
            self.badgeButton.setBadgeValue(StoreManager.shared.itemCount)
            self.displayModel.isDataChange = true
            
        }
    }
    
    func removeButtonTapped(position: IndexPath?) {
        if let cell = categoryItemCollectionView.cellForItem(at: position!) as? ShopItemCollectionViewCell {
            let selectedItem = self.displayModel.categoryItemData?.items?[position?.row ?? 0]
            StoreManager.shared.removeItem(item: selectedItem)
            let count = StoreManager.shared.getSelectedItemCount(item: selectedItem)
            cell.updateCount(totalCount: count)
            self.badgeButton.setBadgeValue(StoreManager.shared.itemCount)
            self.displayModel.isDataChange = true
        }
        
    }
}

extension CategoryItemViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.baseView.frame.width / 2), height: 190)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
        
    }
}
