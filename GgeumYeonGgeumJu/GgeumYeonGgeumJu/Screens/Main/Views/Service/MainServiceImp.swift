//
//  MainServiceImp.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/22.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
import Alamofire

struct MainServiceImp: MainServiceProtocol {
    private let testToken = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImlkIjo2NSwiZXhwIjoxNTkzNjc3NTUyfQ.FTa2KgzKUuMhiZaKE4IIaykIH8E-O4U4DQuK03Y_qyPhuihq-Okcp6DOUILlrlEpy5V5czAdi9_Pchd6RePItA"
    
    
    func requestTotalDrink(completion: @escaping (AFResult<TotalDrinkModel>) -> Void) {
    
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        let userId = 1
        urlComponent?.path = RequestURL.totalDrink(userId: userId).getString
        
        let header: HTTPHeaders = [
            "Authorization": testToken
        ]
        guard let url = urlComponent?.url else {
            return
        }
        let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: SimpleResponse<TotalDrinkModel>.self) { response in
                switch response.result {
                case .success(let object):
                    completion(.success(object.data!))
                case .failure(let err):
                    print(err)
                    completion(.failure(err))
                }
         }
    }
    
    func requestTotalSmoke(completion: @escaping (AFResult<TotalSmokeModel>) -> Void) {
    
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        let userId = 1
        
        urlComponent?.path = RequestURL.totalSmoke(userId: userId).getString
        let header: HTTPHeaders = [
            "Authorization": testToken
        ]
        guard let url = urlComponent?.url else {
            return
        }
        let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: SimpleResponse<TotalSmokeModel>.self) { response in
                switch response.result {
                case .success(let object):
                    completion(.success(object.data!))
                case .failure(let err):
                    print(err)
                    completion(.failure(err))
                }
         }
    }
}
