//
//  StoreTableCell.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol StoreTableCellDelegate: AnyObject {
    func addButtonTapped(position: IndexPath?)
    func removeButtonTapped(position: IndexPath?)
}

class StoreTableCell: BaseTableViewCell {
    
    static let height: CGFloat = 50
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var totalPrice : UILabel!
    @IBOutlet weak var TotalCount : UILabel!
    @IBOutlet weak var price : UILabel!
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var addButtonView : OTDynamicButton!
    @IBOutlet weak var removeButtonView : OTDynamicButton!
    weak var delegate: StoreTableCellDelegate?
    
    var cellViewModel : Item?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTheme()
    }
    
    func updateCell(count: Int?,total: Int?){
        self.TotalCount.text = "Total item : \(count ?? 0)"
        let totalPrice = AppUtilities.shared.getFormattedPrice(price:  total)
        self.totalPrice.text = "Total price : \(totalPrice)"
    }
    
    func configureCell(cellViewModel : Item?) {
        self.cellViewModel = cellViewModel
        setupUI()
    }
}

//MARK: Cell Configuration
extension StoreTableCell {
    
    func setupTheme(){
        baseView.addShadowWithCornerRedious(color: UIColor.gray, opacity: 0.2, sizeX: 1.0, sizeY: 1.0, shadowRadius: 5, cornerRadius: 5)
        self.name.font = theme?.fontTheme.regularMontserrat.font(15)
        self.name.textColor = theme?.colorTheme.colorPrimaryBlack
        self.TotalCount.font = theme?.fontTheme.regularMontserrat.font(14)
        self.TotalCount.textColor = theme?.colorTheme.colorPrimaryBlack
        self.totalPrice.font = theme?.fontTheme.regularMontserrat.font(16)
        self.totalPrice.textColor = theme?.colorTheme.colorPrimaryBlack
        self.price.font = theme?.fontTheme.regularMontserrat.font(14)
        self.price.textColor = theme?.colorTheme.colorPrimaryBlack
        
    }
    func setupUI(){
        self.name.text = cellViewModel?.name
        if let price = cellViewModel?.price, let itemCount = cellViewModel?.itemcount {
            let formatedPrice = AppUtilities.shared.getFormattedPrice(price: price)
            self.price.text = "Price : \(formatedPrice)"
            let totalPrice = AppUtilities.shared.getFormattedPrice(price:  price * itemCount)
            self.totalPrice.text = "Total price : \(totalPrice)"
            
        }
        self.itemImage.loadImage(fromURL: cellViewModel?.image ?? "")
        self.TotalCount.text = "Total item : \(cellViewModel?.itemcount ?? 0)"
        loadDefaultView()
    }
    
    
    func loadDefaultView(){
        let addButtonCellViewModel = OTDynamicButtonViewModel(img: nil, title: "Add", titleFont: theme?.fontTheme.regularMontserrat.font(13), titleColor: theme?.colorTheme.colorPrimaryBlack, backgroundColor: theme?.colorTheme.clearColor, borderColor: theme?.colorTheme.colorPrimaryBlack, cornerRadius: 3, isHidden: false)
        
        self.addButtonView.configureView(viewModel: addButtonCellViewModel) { [weak self] sender in
            if StoreManager.shared.getSelectedItemCount(item: self?.cellViewModel) < 5 {
                self?.delegate?.addButtonTapped(position: self?.indexPath)
            }else{
                showToast(message: "You can not add more than 5 item")
            }
        }
        
        let removeButtonCellViewModel = OTDynamicButtonViewModel(img: nil, title: "Remove", titleFont: theme?.fontTheme.regularMontserrat.font(13), titleColor: theme?.colorTheme.colorPrimaryBlack, backgroundColor: theme?.colorTheme.clearColor, borderColor: theme?.colorTheme.colorPrimaryBlack, cornerRadius: 3, isHidden: false)
        
        self.removeButtonView.configureView(viewModel: removeButtonCellViewModel) { [weak self] sender in
            if StoreManager.shared.getSelectedItemCount(item: self?.cellViewModel) > 0 {
                self?.delegate?.removeButtonTapped(position: self?.indexPath)
            }else{
                showToast(message: "No Item found")
            }
        }
    }
    
}
