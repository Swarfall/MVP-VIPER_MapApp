//
//  RequestManager.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 24.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import Foundation

class RequestManager {
    //MARK: - Private property
    private var requestParametrs = RequestParameters()
    
    func getUsersList(page: Int, countObjects: Int, success: @escaping (UserResults) -> Void, fail: @escaping (String) -> Void) {
        let url = URL(string: (requestParametrs.urlParametrs(page: page, results: countObjects)))
        let session = URLSession(configuration: .default)
        
        guard let urlReq = url else {
            fail("No info")
            return
        }
        let task = session.dataTask(with: urlReq) { (data, response, error) in
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(UserResults.self, from: data)
                success(users)
            } catch {
                fail("Error")
            }
        }
        task.resume()
    }
}
