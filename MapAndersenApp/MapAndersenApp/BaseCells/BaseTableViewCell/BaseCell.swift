//
//  BaseCell.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 24.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import Foundation
import UIKit

protocol BaseCellDelegate {
    func update(entity: TableCellBaseViewModel)
}

class BaseCell: UITableViewCell, BaseCellDelegate {

    func update(entity: TableCellBaseViewModel) {

    }
}
