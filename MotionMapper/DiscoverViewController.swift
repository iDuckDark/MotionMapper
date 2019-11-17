import UIKit
import Foundation
import CoreLocation
import MapKit


final class myLocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title:String? , subtitle:String? ) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
    
    var regin : MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}


class DiscoverViewController: UIViewController, CLLocationManagerDelegate , MKMapViewDelegate {
    
    
    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager!
    var mitAnnotation: myLocationAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        map.mapType = .hybridFlyover
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        
        
        guard let trueData: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("location on Map = \(trueData.latitude) \(trueData.longitude)")
        
        map.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let mitCoordinate = CLLocationCoordinate2D(latitude: trueData.latitude, longitude: trueData.longitude)
        mitAnnotation =  myLocationAnnotation(coordinate: mitCoordinate, title: "Ipad", subtitle: "You Are Here!")
        
        map.addAnnotation(mitAnnotation)
        //map.setRegion(mitAnnotation.regin, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKAnnotationView(annotation: mitAnnotation, reuseIdentifier: "MYLocation")
        annotationView.image = UIImage(named: "ann01")
        let transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        annotationView.transform = transform
        
        return annotationView
        
    }
    
    
}


