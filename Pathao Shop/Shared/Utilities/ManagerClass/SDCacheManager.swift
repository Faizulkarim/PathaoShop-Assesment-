//
//  SDCacheManager.swift
//  Evaly-iOS
//
//  Created by Md Faizul karim on 19/3/23.
//

import Foundation
import UIKit

public class SDCacheManager: NSObject {
    
    static let shop_item_added_by_user = "shop_item_added_by_user"
    private class func getUserDefault(suiteName : String? = nil) -> UserDefaults{
        return (suiteName == nil) ? UserDefaults.standard : UserDefaults(suiteName: suiteName)!
    }
    
    class func setShopItems(items: [Item?], Key: String ) {
        let suiteName : String = Key
        guard let archivedUserModel = items.encode() else { return }
        getUserDefault(suiteName: suiteName).set(archivedUserModel, forKey: Key)
        getUserDefault(suiteName: suiteName).synchronize()
    }
    class func getShopItems(Key: String) -> [Item?]{
        let suiteName: String = Key
        let archivedUserModel = getUserDefault(suiteName: suiteName).value(forKey: Key) as? Data
        return [Item?].decode(data: archivedUserModel) ?? []
    }
    
    class func removeItem(suiteName : String? = nil){
        getUserDefault(suiteName: suiteName).removeObject(forKey: shop_item_added_by_user)
        getUserDefault(suiteName: suiteName).synchronize()
    }
    
    
    
}
