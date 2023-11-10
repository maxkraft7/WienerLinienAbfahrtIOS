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
    
    @State
    private var jsonResponse: String = "";
    
    @State
    private var stopTimes: [String] = [];
    
    init(stop: Location){
        self.stop = stop;
        

        
    }
    
    func fetchData(stationId: Int) {
            guard let url = URL(string: "https://www.wienerlinien.at/ogd_realtime/monitor?activateTrafficInfo=stoerunglang&rbl=" + String(stationId)) else { return }

            URLSession.shared.dataTask(with: url) { dat, response, error in
                
                let str = String(data: dat!, encoding: .utf8);
                self.jsonResponse = str!;
                    
            }.resume()
        }
    
    func fetchNextStopTimes(stopId: Int) -> [String] {
        
        let response: ODPResponse? = ODPRealtimeClient.fetchStationDetails(stationId: stopId);
        
        if(response != nil){
            let monitors = response!.data.monitors;
            
            if(monitors.count > 0){
                let lines = monitors[0].lines;
                
                if(lines.count > 0){
                    let departures = lines[0].departures.departure;
                    
                    return departures.map { Departure in
                        (Departure.departureTime.timePlanned)
                    }
                }
            }
        }
        

        return [];
    }
    
    var body: some View {
        NavigationView {
            
            VStack{
                
                Text(stop.name)
                
                Button {
                    // todo dispatch to background task
                    //self.stopTimes = self.fetchNextStopTimes(stopId: self.stop.stopId);
                    self.fetchData(stationId: stop.stopId)

                } label: {
                    Text("Abfahrten laden")
                }
                
                List(stopTimes, id: \.self) { departure in
                    Text(departure)
                    
                    
                }
                
                Text(self.jsonResponse)
            }
            
        }
        
        
        


    }
}

struct IntervalTimesView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalTimesView(stop: Location(stopId: 4845, name: "Laengenfeldgasse", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)))
    }
}
