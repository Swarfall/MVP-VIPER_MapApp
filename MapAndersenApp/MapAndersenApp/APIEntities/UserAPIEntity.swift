//
//  UserEntity.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 24.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import Foundation

class UserResults: Decodable {
    var results: [UserData]
}

class UserData: Decodable {
    var picture: UserPictures
    var name: UserName
    var location: UserLocation
    var email: String
    var phone: String
}

class UserPictures: Decodable {
    var large: String
    var thumbnail: String
}

class UserName: Decodable {
    var first: String
    var last: String
}

class UserLocation: Decodable {
    var country: String
    var coordinates: UserCoordinates
}

class UserCoordinates: Decodable {
    var latitude: String
    var longitude: String
}
