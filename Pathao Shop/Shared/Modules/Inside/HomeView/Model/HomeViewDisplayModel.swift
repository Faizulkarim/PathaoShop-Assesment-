//
//  HomeViewDisplayModel.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation

// MARK: HomeViewDisplayModel

protocol HomePassableModel {}
struct HomeViewDisplayModel {
    var dataSource = [HomePassableModel]()
    
    var shopResponse : [ShopResponseModel]? {
        didSet {
            loadCellViewModel()
        }
    }
    
    mutating func  loadCellViewModel() {
        dataSource.removeAll()
        if let validShopResponse = shopResponse {
            for item in 0..<(validShopResponse.count){
                if validShopResponse[item].items?.count ?? 0 > 0{
                    dataSource.append(ShopTableCellViewModel(data: validShopResponse[item]))
                }
            }
        }
    }
}

struct ShopTableCellViewModel : HomePassableModel {
    var data: ShopResponseModel?
}
