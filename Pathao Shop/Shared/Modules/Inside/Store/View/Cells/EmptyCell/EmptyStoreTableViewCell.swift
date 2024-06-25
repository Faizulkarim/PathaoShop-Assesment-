//
//  EmptyStoreTableViewCell.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 29/7/23.
//

import UIKit

protocol EmptyStoreTableDelegate: AnyObject {
    func addItem()
}
class EmptyStoreTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var baseHeight: NSLayoutConstraint!
    @IBOutlet weak var addNow: OTDynamicButton!
    var delegate: EmptyStoreTableDelegate?
    func configureCell(){
        setupUI()
    }
    
}

extension EmptyStoreTableViewCell {
    func setupUI(){
        self.baseHeight.constant = Constants.containerHeight
        loadDefaultView()
    }
    
    func loadDefaultView(){
        let addButtonViewModel = OTDynamicButtonViewModel(img: nil,title: "Add Item", titleFont: theme?.fontTheme.regularMontserrat.font(18), titleColor: theme?.colorTheme.colorPrimaryWhite, backgroundColor: theme?.colorTheme.colorPrimaryBlack, borderColor: theme?.colorTheme.clearColor, cornerRadius: 10, isHidden: false)
        
        self.addNow.configureView(viewModel: addButtonViewModel) { [weak self] sender in
            
            self?.delegate?.addItem()
            
        }
        
    }
}
