//
//  RequestParametr.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 24.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import Foundation

class RequestParameters {
    var page = 1
    var results = 10
    var seed = "abc"
    
    func urlParametrs(page: Int, results: Int, seed: String = "abc") -> String {
        let url = "https://randomuser.me/api/?page=\(page)&results=\(results)&seed=\(seed)"
        return url
    }
}
