//
//  QiitaItemModel.swift
//  raktenRecipeAPI-Sample
//
//  Created by 木元健太郎 on 2022/01/04.
//

import Foundation




//struct rakutenCategoryType: Codable {
//  let categoryType: [QiitaItemModel]?
//}
//
//struct QiitaItemModel: Codable {
//    var urlStr: String
//    var title: String
//    var categoryUrl: String
//
//    enum CodingKeys: String, CodingKey {
//        case urlStr = "categoryId"
//        case title = "categoryName"
//        case categoryUrl = "categoryUrl"
//    }
//    var url: URL? { URL.init(string: urlStr) }
//}


struct Rakuten: Codable {
var result: Result?
}

struct Result: Codable {
var large:[RakutenFoodModel]?
var medium: [RakutenFoodModel]?
}

struct RakutenFoodModel: Codable {

var categoryId: Int
var categoryName: String
var categoryUrl: String
var parentCategoryId:String
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "categoryId"
        case categoryName = "categoryName"
        case categoryUrl = "categoryUrl"
        case parentCategoryId = "parentCategoryId"
    }
    var url: URL? { URL.init(string: categoryUrl) }
}


