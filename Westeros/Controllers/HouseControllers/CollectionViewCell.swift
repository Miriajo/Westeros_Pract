//
//  CollectionViewCell.swift
//  Westeros
//
//  Created by Alexandre Freire on 12/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    static let nibName: String = String(describing: CollectionViewCell.self)
    static let defaultReuseableId: String = String(describing: CollectionViewCell.self)
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
    }
}
