//
//  UserCell.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 24.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import UIKit

class UserCell: BaseCell {
    //MARK: - Private outlets
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameSurnameLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    
    //MARK: - Private property
    private var entityData: UserViewModel!
    
    //MARK: - Overriden public func
    override func update(entity: TableCellBaseViewModel) {
        guard let entity = entity as? UserViewModel else { return }
        self.entityData = entity
        avatarImageView.download(from: entityData.thumbnail)
        nameSurnameLabel.text = "\(entityData.name) \(entityData.surname)"
        countryLabel.text = entityData.country
        emailLabel.text = entityData.email
        phoneLabel.text = entityData.phone
    }
}
