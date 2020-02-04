//
//  UserEntity.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 28.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import Foundation

class UserViewModel: TableCellBaseViewModel {
    var name: String
    var surname: String
    var country: String
    var phone: String
    var email: String
    var large: String
    var thumbnail: String
    var lat: Double
    var long: Double
    
    init(model: UserData, cellType: BaseCell.Type = UserCell.self) {
        self.name = model.name.first
        self.surname = model.name.last
        self.country = model.location.country
        self.phone = model.phone
        self.email = model.email
        self.large = model.picture.large
        self.thumbnail = model.picture.thumbnail
        self.lat = model.location.coordinates.latitude.toDouble() ?? 0
        self.long = model.location.coordinates.longitude.toDouble() ?? 0
        super.init(cellType: cellType)
    }
}
