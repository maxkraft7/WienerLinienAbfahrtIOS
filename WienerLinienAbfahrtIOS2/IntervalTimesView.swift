//
//  IntervalTimesView.swift
//  WienerLinienAbfahrtIOS2
//
//  Created by user on 02.11.23.
//

import SwiftUI
import MapKit

struct IntervalTimesView: View {
    
    private let stop: Location;
    
    init(stop: Location){
        self.stop = stop;
    }
    
    var body: some View {
        
        Button(action: {
                        // Closure will be called once user taps your button
                        
                    }) {
                        Text(stop.name)
                    }
        


    }
}

struct IntervalTimesView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalTimesView(stop: Location(stopId: 4845, name: "Laengenfeldgasse", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)))
    }
}
