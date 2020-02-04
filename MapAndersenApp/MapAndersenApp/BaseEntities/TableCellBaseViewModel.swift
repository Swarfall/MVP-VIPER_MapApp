//
//  BaseEntity.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 24.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import Foundation

class TableCellBaseViewModel {
    //MARK: - Public property
    var cellType: BaseCell.Type
    
    //MARK: - Init
    init(cellType: BaseCell.Type) {
        self.cellType = cellType

    }
}
