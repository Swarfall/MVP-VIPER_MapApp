//
//  IngoView.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 03.02.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import Foundation
import UIKit

class InfoView: NibView {
    //MARK: - IBOutlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var surnameLabel: UILabel!
    
    func update(user: PinDataEntity) {
        nameLabel.text = user.name
        surnameLabel.text = user.surname
    }
}
