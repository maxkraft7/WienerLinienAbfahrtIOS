import SwiftUI
import MapKit

struct LineStopsView: View {

    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.8 , longitude: 13.05), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    // todo get locations as arg via init
    let locations = [
        Location(name: "Hohensalzburg", coordinate: CLLocationCoordinate2D(latitude: 47.802, longitude: 13.0575))
    ]

    
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, annotationItems: locations) {
            location in
            MapMarker(coordinate: location.coordinate)
        }
    }

}