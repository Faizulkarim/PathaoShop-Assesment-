//
//  StoreDisplayModel.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation

protocol StorePassableModel {}
// MARK: StoreDisplayModel
struct StoreDisplayModel {
    var dataSource = [StorePassableModel]()
    var totalAmmount : Int = 0
    var isDataChange: Bool?
    var storItemData : [Item?]? {
        didSet {
            loadCellViewModel()
        }
    }
    mutating func loadCellViewModel() {
        dataSource.removeAll()
        if let validStoreItems = storItemData {
            if validStoreItems.count > 0 {
                for item in 0..<validStoreItems.count {
                    if let price = validStoreItems[item]?.price, let itemCount = validStoreItems[item]?.itemcount {
                        let itemTotal = price * itemCount
                        totalAmmount += itemTotal
                        dataSource.append(StoreTableViewCellViewModel(data: validStoreItems[item]))
                    }
                }
            } else {
                dataSource.append(EmptyStoreTableViewCellViewModel())
            }
        }
    }
    
}

struct StoreTableViewCellViewModel: StorePassableModel {
    var data : Item?
}
struct EmptyStoreTableViewCellViewModel: StorePassableModel {
    
}
