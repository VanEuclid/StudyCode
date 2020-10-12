//
//  ReviewCell.swift
//  LetsEat
//
//  Created by Van Euclid Dy on 10/5/20.
//  Copyright © 2020 Euclidean Software LLC. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var ratingView: RatingsView!
}
