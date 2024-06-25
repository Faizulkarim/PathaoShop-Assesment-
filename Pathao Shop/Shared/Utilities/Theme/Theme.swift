//
//  Theme.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//


import Foundation
protocol Theme {
    /// Color theme object.
    var colorTheme: ColorTheme { get set }
    
    /// Font theme object.
    var fontTheme: FontTheme { get set }
    var imageTheme: ImageTheme {get set}

   
}
