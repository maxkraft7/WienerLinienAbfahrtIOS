import SwiftUI
import MapKit

struct LineStopsView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.21, longitude: 16.36), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State private var stopLocations: [Location] = []
    
    private let client: ODPRealtimeClient = ODPRealtimeClient()
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: self.stopLocations) { location in
                
                // todo switch to other view on click
                MapMarker(coordinate: location.coordinate)
            }
            .onAppear {
                // Load the data when the view appears
                self.stopLocations = client.fetchStops()
            }
        }
        
    }
}
