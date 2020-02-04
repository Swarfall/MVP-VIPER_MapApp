//
//  StringExtension.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 30.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
