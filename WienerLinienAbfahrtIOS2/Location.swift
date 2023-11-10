import Foundation
import CoreLocation

class Location: Identifiable, ObservableObject {
    let id = UUID()
    
    let stopId: Int
    let name: String
    let coordinate: CLLocationCoordinate2D

    
    init(stopId: Int, name: String, coordinate: CLLocationCoordinate2D) {
        self.stopId = stopId
        self.name = name
        self.coordinate = coordinate
    }
}
