//
//  CommunityServiceImp.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/03.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
import Alamofire

struct CommunityServiceImp: CommunityServiceProtocol {
    func requestCommunityList(type: CommunityListType, completion: @escaping ([CommunityListModel]?) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        
        let userId = "1"
        let sortString: String
        switch type {
        case .recent:
            sortString = "recent"
        case .popular:
            sortString = "popular"
        case .myBoard:
            sortString = "mypage/\(userId)"
        }
        
        urlComponent?.path = RequestURL.community(sortString: sortString).getString
        
        guard let url = urlComponent?.url else {
            return
        }
        
        let request = AF.request(url)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: ArrayResponse<CommunityListModel>.self) { response in
                switch response.result {
                case .success(let object):
                    completion(object.data)
                case .failure(let err):
                    print(err)
                }
        }
    }
    
    func requestMyCommunityList(completion: @escaping ()->()) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        let userId = "test"
        urlComponent?.path = RequestURL.myCommunity(userId: userId).getString
        
    }
}
