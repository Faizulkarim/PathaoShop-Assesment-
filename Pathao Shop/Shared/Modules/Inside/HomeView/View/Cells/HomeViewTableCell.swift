//
//  HomeViewTableCell.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeViewTableCellDelegate: AnyObject {
    func seemoreButtonTappe(position: Int?)
    func updateStore()
    
}

class HomeViewTableCell: BaseTableViewCell {
    
    static let height: CGFloat = 50
    @IBOutlet weak var baseView: UIView!
    weak var delegate: HomeViewTableCellDelegate?
    @IBOutlet weak var sectionTitle : UILabel!
    @IBOutlet weak var seeMoreButton : OTDynamicButton!
    @IBOutlet weak var shopItemCollectionView : UICollectionView!
    var cellViewModel : ShopResponseModel?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configureCell(cellViewModel : ShopResponseModel?) {
        self.cellViewModel = cellViewModel
        setupUI()
    }
}

extension HomeViewTableCell : ShopItemCollectionDelegate{
    func addButtonTapped(position: IndexPath?) {
        if let cell = shopItemCollectionView.cellForItem(at: position!) as? ShopItemCollectionViewCell {
            let selectedItem = cellViewModel?.items?[position?.row ?? 0]
            StoreManager.shared.saveItem(item: selectedItem)
            let count = StoreManager.shared.getSelectedItemCount(item: selectedItem)
            cell.updateCount(totalCount: count)
            self.delegate?.updateStore()
        }
    }
    
    func removeButtonTapped(position: IndexPath?) {
        if let cell = shopItemCollectionView.cellForItem(at: position!) as? ShopItemCollectionViewCell {
            let selectedItem = cellViewModel?.items?[position?.row ?? 0]
            StoreManager.shared.removeItem(item: selectedItem)
            let count = StoreManager.shared.getSelectedItemCount(item: selectedItem)
            cell.updateCount(totalCount: count)
            self.delegate?.updateStore()
        }
        
    }
}
//MARK: Cell Configuration
extension HomeViewTableCell {
    func setupUI(){
        self.sectionTitle.text = cellViewModel?.shopName
        loadDefaultView()
        setUpShopCollectionCell()
    }
    func setUpShopCollectionCell(){
        shopItemCollectionView.register(UINib(nibName: "ShopItemCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ShopItemCollectionViewCell")
        shopItemCollectionView.delegate = self
        shopItemCollectionView.dataSource = self
        shopItemCollectionView.reloadData()
    }
    func loadDefaultView(){
        let seeMoreButtonCellViewModel = OTDynamicButtonViewModel(img: nil, title: "See More", titleFont: theme?.fontTheme.regularMontserrat.font(10), titleColor: theme?.colorTheme.colorPrimaryBlack, backgroundColor: theme?.colorTheme.clearColor, borderColor: theme?.colorTheme.colorPrimaryBlack, cornerRadius: 12.5, isHidden: false)
        
        self.seeMoreButton.configureView(viewModel: seeMoreButtonCellViewModel) { [weak self] sender in
            self?.delegate?.seemoreButtonTappe(position: self?.indexPath?.row)
            
        }
    }
    
}

extension HomeViewTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = cellViewModel?.items?.count ?? 0
            return min(itemCount, 5)
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            String(describing: ShopItemCollectionViewCell.self),
                                                         for: indexPath) as? ShopItemCollectionViewCell {
            cell.theme = theme
            cell.indexPath = indexPath
            let shopItem = cellViewModel?.items?[indexPath.row]
            cell.delegate = self
            cell.configureCell(cellViewModel: shopItem)
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HomeViewTableCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.baseView.frame.width - 5) / 3.2, height: self.shopItemCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
        
    }

}
