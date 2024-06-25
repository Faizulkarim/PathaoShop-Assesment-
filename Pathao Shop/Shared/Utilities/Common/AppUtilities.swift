//
//  AppUtilities.swift
//  Evaly-iOS
//
//  Created by Md Faizul karim on 27/7/23.
//

import Foundation


class AppUtilities: NSObject {
    
    static let shared = AppUtilities()
    func getFormattedPrice(price: Int?) -> String {
        let amount = price ?? 0
        let bdtAmount = "৳ " + "\(amount)"
        return bdtAmount
    }


    
}
