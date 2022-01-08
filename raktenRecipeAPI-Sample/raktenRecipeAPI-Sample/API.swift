//
//  API.swift
//  raktenRecipeAPI-Sample
//
//  Created by 木元健太郎 on 2022/01/04.
//

import Foundation
import Alamofire

enum APIError: Error {
  case postAccessToken
  case getItems
}

final class API {
  static let shared = API()
  private init() {}

  private let host = "https://app.rakuten.co.jp/services/api/Recipe"
  private let applicationId = "1010761166236342244"
  private let clientSecret = "2ae8087333581ff5c62ae96b70dff0cac05eb386"
  
//  static let jsonDecoder: JSONDecoder = {
//    let decoder = JSONDecoder()
//    decoder.keyDecodingStrategy = .convertFromSnakeCase
//    decoder.dateDecodingStrategy = .iso8601
//    return decoder
//  }()

  enum  URLParameterName: String {
    case applicationId = "applicationId"
    case clientSecret = "application_secret"
  }

  var oAuthURL: URL {
      return URL(string: host + "?" + "applicationId=" + URLParameterName.applicationId.rawValue)!
  }

//  func postAccessToken(code: String, completion: ((QiitaAccessTokenModel?, Error?) -> Void)? = nil) {
//    let endPoint = "/access_tokens"
//    guard let url = URL(string: host + endPoint + "?" +
//                          "\(URLParameterName.clientID.rawValue)=\(clientID)" + "&" +
//                          "\(URLParameterName.clientSecret.rawValue)=\(clientSecret)" + "&" +
//                          "\(URLParameterName.code)=\(code)") else {
//      completion?(nil, APIError.postAccessToken)
//      return
//    }
//  }

//    AF.request(url, method: .post).responseJSON { (response) in
//      do {
//        guard
//          let _data = response.data else {
//          completion?(nil, APIError.postAccessToken)
//          return
//        }
//        let accessToken = try API.jsonDecoder.decode(QiitaAccessTokenModel.self, from: _data)
//        completion?(accessToken, nil)
//      } catch let error {
//        completion?(nil, error)
//      }
//    }
//  }


  func getCategory(success: (([RakutenFoodModel]) -> Void)? = nil, error: ((Error)->Void)? = nil) {
    
      AF.request("https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?format=json&applicationId=1010761166236342244&categoryType=medium",method: .get).response  { (response) in
          switch response.result {
          case .success:
              print(response)
            guard
              let data = response.data,
              let rakuten = try? JSONDecoder().decode(Rakuten.self, from: data),
              let result = rakuten.result,
              let items = result.medium
              else {
                  success?([])
              return
            }
            success?(items)
          case .failure(let err):
            error?(err)
          }
        }
  }
    
    
    
}

