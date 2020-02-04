//
//  InfoUserViewController.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 31.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import UIKit

class InfoUserViewController: UIViewController {
    //MARK: - IBOutlet private property
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    //MARK: - Public property
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImageView.download(from: imageName ?? "")
    }
}
