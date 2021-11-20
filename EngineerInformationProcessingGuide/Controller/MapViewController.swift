import UIKit
import CoreLocation
import MapKit
import SwiftUI


class MapViewController: UIViewController {
    
    @IBOutlet var myLocationButton: UIButton!
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()   // 위치정보에 관한 모든 것
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        config()
    }
    
    @IBAction func areaSelectionButtonClicked(_ sender: UIBarButtonItem) {
        print(#function)
    }
    
    @IBAction func myLocationButtonClicked(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization() // 위치추적 권한 요청
        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // 배터리에 따른 최적의 정확도
        locationManager.startUpdatingLocation() // 위치 업데이트
        
        self.mapView.showsUserLocation = true   // 위치 보여주기
        self.mapView.setUserTrackingMode(.follow, animated: true) // 확대 모드
    }
    
}

// MARK: - config
extension MapViewController {
    
    func config() {
        myLocationButton.setTitle("", for: .normal)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
}
