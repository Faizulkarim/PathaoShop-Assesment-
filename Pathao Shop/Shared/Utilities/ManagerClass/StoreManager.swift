//
//  StoreManager.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//

import Foundation


class StoreManager {
    // Store items and categories data
    static let shared = StoreManager()
    private var storeItems: [Item?] = []
    
    var itemCount: Int {
        return storeItems.count
    }
    
    private init() {
        storeItems = SDCacheManager.getShopItems(Key: SDCacheManager.shop_item_added_by_user)
    }
    func getStoreItems() -> [Item?] {
        return storeItems
    }
    
    func getSelectedItemCount(item: Item?) -> Int{
        var selectedItemCount = 0
        if let index = storeItems.firstIndex(where: { $0?.name == item?.name }) {
            let selectedItem = storeItems[index]
            selectedItemCount = selectedItem?.itemcount ?? 0
        }
        return selectedItemCount
    }
    
    func saveItem(item: Item?) {
        if let index = storeItems.firstIndex(where: { $0?.name == item?.name }) {
            let selectedItem = storeItems[index]
            selectedItem?.itemcount = (selectedItem?.itemcount ?? 0) + 1
            if selectedItem?.itemcount ?? 0 <= 5{
                storeItems[index] = selectedItem
                SDCacheManager.setShopItems(items: storeItems, Key: SDCacheManager.shop_item_added_by_user)
            }else {
                print("You cannot add more than 5")
            }
        } else {
            item?.itemcount = 1
            storeItems.append(item)
            SDCacheManager.setShopItems(items: storeItems, Key: SDCacheManager.shop_item_added_by_user)
        }
        
    }
    
    func removeItem(item: Item?) {
        if let index = storeItems.firstIndex(where: { $0?.name == item?.name }) {
            let selectedItem = storeItems[index]
            if selectedItem?.itemcount ?? 0 > 1 {
                selectedItem?.itemcount = (selectedItem?.itemcount ?? 0) - 1
                storeItems[index] = selectedItem
            }else if selectedItem?.itemcount ?? 0 == 1{
                storeItems.remove(at: index)
            }else{
                print("No item found")
            }
            SDCacheManager.setShopItems(items: storeItems, Key: SDCacheManager.shop_item_added_by_user)
        }
    }
    
    
    func totalAmmount() -> Int {
        var total = 0
        for item in 0..<storeItems.count {
            if let price = storeItems[item]?.price, let itemCount = storeItems[item]?.itemcount {
                let itemPrice = price * itemCount
                total += itemPrice
            }
        }
        return total
    }
    
    
}
