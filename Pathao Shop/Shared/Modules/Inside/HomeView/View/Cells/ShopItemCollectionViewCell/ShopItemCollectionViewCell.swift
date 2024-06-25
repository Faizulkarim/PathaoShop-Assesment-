//
//  ShopItemCollectionViewCell.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//

import UIKit

protocol ShopItemCollectionDelegate : AnyObject {
    func addButtonTapped(position: IndexPath?)
    func removeButtonTapped(position: IndexPath?)
}
class ShopItemCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var baseView : UIView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var details : UILabel!
    @IBOutlet weak var price : UILabel!
    @IBOutlet weak var count : UILabel!
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var addButtonView : OTDynamicButton!
    @IBOutlet weak var removeButtonView : OTDynamicButton!
    
    var cellViewModel : Item?
    var delegate : ShopItemCollectionDelegate?
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupTheme()
    }
    func configureCell(cellViewModel : Item?){
        self.cellViewModel = cellViewModel
        setupUI()
    }
    
    func updateCount(totalCount: Int) {
        self.count.isHidden = false
        self.count.text = totalCount.description
    }    
}

extension ShopItemCollectionViewCell{
    func setupUI(){
        self.name.text = cellViewModel?.name
        self.itemImage.loadImage(fromURL: cellViewModel?.image ?? "")
        self.details.text = cellViewModel?.description
        let formatedPrice = AppUtilities.shared.getFormattedPrice(price: cellViewModel?.price)
        self.price.text = formatedPrice
        let count = StoreManager.shared.getSelectedItemCount(item: cellViewModel)
        self.count.text = count.description
        loadDefaultView()
    }
    
    func loadDefaultView(){
        let addButtonCellViewModel = OTDynamicButtonViewModel(img: nil, title: "Add", titleFont: theme?.fontTheme.regularMontserrat.font(9), titleColor: theme?.colorTheme.colorPrimaryBlack, backgroundColor: theme?.colorTheme.clearColor, borderColor: theme?.colorTheme.colorPrimaryBlack, cornerRadius: 3, isHidden: false)
        
        self.addButtonView.configureView(viewModel: addButtonCellViewModel) { [weak self] sender in
            if StoreManager.shared.getSelectedItemCount(item: self?.cellViewModel) < 5 {
                self?.delegate?.addButtonTapped(position: self?.indexPath)
            }else{
                showToast(message: "You can not add more than 5 item")
            }
        }
        
        let removeButtonCellViewModel = OTDynamicButtonViewModel(img: nil, title: "Remove", titleFont: theme?.fontTheme.regularMontserrat.font(9), titleColor: theme?.colorTheme.colorPrimaryBlack, backgroundColor: theme?.colorTheme.clearColor, borderColor: theme?.colorTheme.colorPrimaryBlack, cornerRadius: 3, isHidden: false)
        
        self.removeButtonView.configureView(viewModel: removeButtonCellViewModel) { [weak self] sender in
            if StoreManager.shared.getSelectedItemCount(item: self?.cellViewModel) > 0 {
                self?.delegate?.removeButtonTapped(position: self?.indexPath)
            }else{
                showToast(message: "No Item found")
            }
        }
    }
    
    func setupTheme(){
        baseView.addShadowWithCornerRedious(color: UIColor.lightGray, opacity: 0.4, sizeX: 0.5, sizeY: 0.5, shadowRadius: 0.5, cornerRadius: 6)
        self.name.font = theme?.fontTheme.regularMontserrat.font(13)
        self.name.textColor = theme?.colorTheme.colorPrimaryBlack
        self.details.font = theme?.fontTheme.regularMontserrat.font(10)
        self.details.textColor = theme?.colorTheme.colorPrimaryBlack
        self.price.font = theme?.fontTheme.regularMontserrat.font(12)
        self.price.textColor = theme?.colorTheme.colorPrimaryBlack
        self.count.backgroundColor = theme?.colorTheme.colorPrimaryRed
        self.count.textColor = theme?.colorTheme.colorPrimaryWhite
    }
}
