//
//  PhotoCell.swift
//  LetsEat
//
//  Created by Van Euclid Dy on 10/5/20.
//  Copyright © 2020 Euclidean Software LLC. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imgReview: UIImageView!
}

extension PhotoCell {
    func set(image:UIImage) {
        imgReview.image = image
        roundedCorners()
    }
    
    func roundedCorners() {
        imgReview.layer.cornerRadius = 9
        imgReview.layer.masksToBounds = true
    }
}
