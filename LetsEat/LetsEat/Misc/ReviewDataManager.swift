//
//  ReviewDataManager.swift
//  LetsEat
//
//  Created by Van Euclid Dy on 10/1/20.
//  Copyright © 2020 Euclidean Software LLC. All rights reserved.
//

import UIKit
import Foundation

class ReviewDataManager: NSObject {
    
    private var reviewItems:[ReviewItem] = []
    private var photoItems:[RestaurantPhotoItem] = []
    let manager = CoreDataManager()
    
    func fetchReview(by restaurantId:Int) {
        if reviewItems.count > 0 { reviewItems.removeAll() }
        for data in manager.fetchReviews(by: restaurantId) {
            reviewItems.append(data)
        }
    }
    
    func fetchPhoto(by restaurantID:Int) {
        if photoItems.count > 0 { photoItems.removeAll() }
        for data in manager.fetchPhotos(by: restaurantID) {
            photoItems.append(data)
        }
    }
    
    func numberOfReviewItems() -> Int {
        return reviewItems.count
    }
    
    func numberOfPhotoItems() -> Int {
        return photoItems.count
    }
    
    func reviewItem(at index:IndexPath) -> ReviewItem {
        return reviewItems[index.item]
    }
    
    func photoItem(at index:IndexPath) -> RestaurantPhotoItem {
        return photoItems[index.item]
    }
}
