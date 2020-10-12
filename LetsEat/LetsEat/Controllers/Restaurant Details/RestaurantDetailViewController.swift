//
//  RestaurantDetailViewController.swift
//  LetsEat
//
//  Created by Van Euclid Dy on 9/14/20.
//  Copyright © 2020 Euclidean Software LLC. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import LetsEatDataKit
import UserNotifications
import Intents
import CoreSpotlight
import CoreServices

class RestaurantDetailViewController: UITableViewController {
    
    // Nav Bar
    @IBOutlet weak var btnHeart:UIBarButtonItem!
    
    // Cell One
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblCuisine:UILabel!
    @IBOutlet weak var lblHeaderAddress:UILabel!
    
    // Cell Two
    @IBOutlet weak var lblTableDetails:UILabel!
    
    // Cell Three
    @IBOutlet weak var lblOverallRating:UILabel!
    
    // Cell Eight
    @IBOutlet weak var lblAddress:UILabel!
    @IBOutlet weak var imgMap:UIImageView!
    
    @IBOutlet weak var ratingView: RatingsView!
    
    var selectedRestaurant:RestaurantItem?
    let manager = CoreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.showReview.rawValue:
                showReview(segue: segue)
            case Segue.showPhotoFilter.rawValue:
                showPhotoFilter(segue: segue)
            default:
                print("Segue not added")
            }
        }
    }
}

private extension RestaurantDetailViewController {
    
    func initialize() {
        setupLabels()
        createMap()
        createRating()
        setupNotificationDefaults()
    }
    
    @IBAction func unwindReviewCancel(segue:UIStoryboardSegue) { }
    @IBAction func onTimeTapped(sender: UIButton) {
        showNotification(sender: sender.titleLabel?.text)
    }
    
    func setupNotificationDefaults() {
        UNUserNotificationCenter.current().delegate = self
    }
    
    func showNotification(sender:String?) {
        
        let content = UNMutableNotificationContent()
        if let name = selectedRestaurant?.name {
            content.title = name
        }
        if let time = sender {
            content.body = "Table for 2, tonight at \(time)"
            
            setupReservation(with: sender!)
        }
        content.subtitle = "Restaurant Reservation"
        content.badge = 1
        
        content.categoryIdentifier = Identifier.reservationCategory.rawValue
        
        if let id = selectedRestaurant?.restaurantID {
            content.threadIdentifier = "\(id)"
        }
        
        guard let imgURL = Bundle.main.url(forResource: "sample-restaurant-img@3x", withExtension: "png") else { return }
        let attachment = try! UNNotificationAttachment(identifier: "letsEatReservation", url: imgURL, options: nil)
        
        content.attachments = [attachment]
        sendNotification(with: content)
    }
    
    func setupReservation(with description: String) {
        let reservationActivity = NSUserActivity(activityType: "academy.cocoa.LetsEat.reservation-activity-type")
        reservationActivity.isEligibleForSearch = true
        reservationActivity.isEligibleForPrediction = true
        
        if let name = selectedRestaurant?.name {
            reservationActivity.title = "Reservation for 2 at \(name) at \(description)"
        }
        reservationActivity.userInfo = ["Key":"Value"]
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        attributes.contentDescription = dateFormatter.string(from: date)
        attributes.thumbnailData = UIImage(named: "mexican")?.pngData()
        reservationActivity.contentAttributeSet = attributes
        self.userActivity = reservationActivity
        self.userActivity?.becomeCurrent()
    }
    
    func sendNotification(with content: UNNotificationContent) {
        let uuid = UUID().uuidString
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func showReview(segue:UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController,
            let viewController = navController.topViewController as? ReviewFormViewController else {
                return
        }
        
        viewController.selectedRestaurantID = selectedRestaurant?.restaurantID
    }
    
    func showPhotoFilter(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController,
              let viewController = navController.topViewController as?
                PhotoFilterViewController else {
            return
        }
        
        viewController.selectedRestaurantID = selectedRestaurant?.restaurantID
    }
    
    func createRating() {
        if let id = selectedRestaurant?.restaurantID {
            let value = manager.fetchRestaurantRating(by: id)
            ratingView.rating = CGFloat(value)
            if value.isNaN { lblOverallRating.text = "0" }
            else {
                lblOverallRating.text = "\(value)"
            }
        }
    }
    
    func setupLabels() {
        guard let restaurant = selectedRestaurant else { return }
        if let name = restaurant.name {
            lblName.text = name
            title = name
        }
        
        if let cuisine = restaurant.subtitle { lblCuisine.text = cuisine }
        if let address = restaurant.address {
            lblAddress.text = address
            lblHeaderAddress.text = address
        }
        
        lblTableDetails.text = "Table for 7 tonight at 10:00 PM"
    }
    
    func createMap () {
        guard let annotation = selectedRestaurant, let long = annotation.long, let lat = annotation.lat else { return }
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        takeSnapShot(with: location)
    }

    func takeSnapShot(with location: CLLocationCoordinate2D) {
        
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        var loc = location
        let polyLine = MKPolyline(coordinates: &loc, count: 1)
        let region = MKCoordinateRegion(polyLine.boundingMapRect)
        
        mapSnapshotOptions.region = region
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = CGSize(width: 340, height: 208)
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.showsPointsOfInterest = true
        
        let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
        snapShotter.start() { snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
            
            UIGraphicsBeginImageContextWithOptions(mapSnapshotOptions.size, true, 0)
            snapshot.image.draw(at: .zero)
            
            let identifier = "custompin"
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.image = UIImage(named: "custom-annotation")!
            let pinImage = pinView.image
            var point = snapshot.point(for: location)
            
            let rect = self.imgMap.bounds
            if rect.contains(point) {
                let pinCenterOffset = pinView.centerOffset
                point.x -= pinView.bounds.size.width / 2
                point.y -= pinView.bounds.size.height / 2
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                pinImage?.draw(at: point)
            }
            
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    self.imgMap.image = image
                }
            }
        }
    }
}

extension RestaurantDetailViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let identifer = Option(rawValue: response.actionIdentifier) {
            switch identifer {
            case .one:
                print("User selected yes")
            case .two:
                print("User selected no")
            }
        }
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let storyboard = UIStoryboard(name: "NotificationSettings", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NotificationSettingsNavController")
        self.present(vc, animated:true, completion: nil)
    }
}
