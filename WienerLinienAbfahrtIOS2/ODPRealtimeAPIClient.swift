import SwiftUI
import MapKit

class ODPRealtimeClient {

    //var ODPResponse: ODPResponse? = nil;


    // example station ids:
    // 4438 - längenfeldgasse
    func fetchStationDetails(stationId: Int){
        guard let url = URL(string: "https://www.wienerlinien.at/ogd_realtime/monitor?activateTrafficInfo=stoerunglang&rbl=" + String(stationId)) else {
            // todo show error on screen
            print("could not parse url")
            return
        }  

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            guard let responseData = data else {
                print("empty response body returned")
                return
            }

            let opdResponse = try? JSONDecoder().decode(ODPResponse.self, from: responseData)
        }

        task.resume();
    }

    func fetchLines() -> [PublicTransportLine] {
        // https://www.wienerlinien.at/ogd_realtime/doku/ogd/wienerlinien-ogd-linien.csv
        var lines: [PublicTransportLine] = []
        let semaphore = DispatchSemaphore(value: 69)
        
        if let filepath = Bundle.main.path(forResource: "linien", ofType: "csv") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let csvArr = self.fetchCSV(csv: contents)
                
                for lineArr in csvArr {
                    
                    if lineArr.count < 2{
                        continue
                    }
                    
                    let lineId = Int(lineArr[0])
                    let name = lineArr[1]
                    let type = lineArr[4].trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
                    
                    if lineId == nil {
                        continue
                    }
                    
                    let line = PublicTransportLine(lineId: lineId!, name: name, type: type)
                    lines.append(line)
                }
                
                semaphore.signal()
                } catch {
                    print("Error reading file linien.csv")
                }
            } else {
                print("File not found")
        }
        


            
        
        
        semaphore.wait()
        return lines
    }
    
    func fetchStops() -> [Location] {
        
        let lines: [PublicTransportLine] = self.fetchLines()
        let routes: [PublicTransportRouteAssociation] = self.fetchRoutes()
        
        
        
        // https://www.wienerlinien.at/ogd_realtime/doku/ogd/wienerlinien-ogd-haltepunkte.csv
        let semaphore = DispatchSemaphore(value: 0)
        var locations: [Location] = []
        
        if let filepath = Bundle.main.path(forResource: "haltepunkte", ofType: "csv") {
            do {
                    let contents = try String(contentsOfFile: filepath)
                let csvArr = self.fetchCSV(csv: contents)
            
                
                for lineArray in csvArr {
                    
                    if lineArray.count < 2 {
                        continue
                    }
                    
                    let stopId = Int(lineArray[0])
                    let name = lineArray[2]
                    let longitude = Double(lineArray[5])
                    
                    // trim carriage return on line end
                    let latitude = Double(lineArray[6].trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines))
                    
                    if longitude != nil && latitude != nil && stopId != nil {
                        let location = Location(stopId: stopId!, name: name, coordinate: CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!))
                        locations.append(location)
                    }
                }
                
                semaphore.signal()
                } catch {
                    print("Error reading file BibleTable.csv")
                }
            } else {
                print("File not found")
        }
        
        semaphore.wait()
        return self.trimLocations( locations: locations, lines: lines, routeAssociations: routes, vehicleType: "ptMetro")[PublicTransportLine(lineId: 301, name: "U1", type: "ptMetro")]!
    }
    
    func trimLocations(locations: [Location], lines: [PublicTransportLine], routeAssociations: [PublicTransportRouteAssociation], vehicleType: String) -> [PublicTransportLine: [Location]]{
        
        // build up dicts
        var myDictionary: [PublicTransportLine: [Location]] = [:]
        
        
        for route in routeAssociations {
            let lineID = route.lineId
            let stopID = route.stopId

            let line = lines.first{$0.lineId == lineID}
            let stop = locations.first {$0.stopId == stopID}
            
            if line == nil || stop == nil {
                continue
            }
            
            if line?.type != vehicleType{
                continue
            }
            
            if var existingValues = myDictionary[line!] {
                existingValues.append(stop!)
                
                // should set again.
                myDictionary[line!] = existingValues
            } else {
                myDictionary[line!] = [stop!]
            }
        }
        
        return myDictionary
        
    }

    func fetchRoutes() -> [PublicTransportRouteAssociation] {
        // http://www.wienerlinien.at/ogd_realtime/doku/ogd/wienerlinien-ogd-fahrwegverlaeufe.csv
        let semaphore = DispatchSemaphore(value: 420)
        
        var routeAssociations: [PublicTransportRouteAssociation] = []
        
        if let filepath = Bundle.main.path(forResource: "routen", ofType: "csv") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let csvArr = self.fetchCSV(csv: contents)
            
                for lineArray in csvArr {
                    
                    if lineArray.count < 4 {
                        continue
                    }
                    
                    let lineId: Int? = Int(lineArray[0])
                    let stopId: Int? = Int(lineArray[3])
                    
                    if lineId != nil && stopId != nil {
                        let routeAssociation: PublicTransportRouteAssociation = PublicTransportRouteAssociation(stopId: stopId!, lineId: lineId!)
                        routeAssociations.append(routeAssociation)
                    }
                }
                
                semaphore.signal()
                } catch {
                    print("Error reading file routen.csv")
                }
            } else {
                print("File not found")
        }
        

        semaphore.wait()
        return routeAssociations

    }

    // fetch http url and return its response as string
    private func fetchHTTP(url: URL, complete:@escaping (String)->()) -> Void{
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            guard let responseData = data else {
                print("empty response body returned")
                return
            }

            complete(String(data: responseData, encoding: .utf8)!)
        }

        task.resume();
    }


    // todo check how to read csv files:
    // todo https://stackoverflow.com/questions/27206176/where-to-place-a-txt-file-and-read-from-it-in-a-ios-project
    
    private func fetchAsset(fileName: String) -> String? {
        if let csvURL = Bundle.main.url(forResource: fileName, withExtension: "csv") {
            do {
                let csvString = try String(contentsOf: csvURL, encoding: .utf8)

                return csvString
            } catch {
                print("Error reading CSS file: \(error)")
            }
        } else {
            print("CSS file not found in the app bundle.")
        }
        
        return nil
    }

    // put in a csv string and return a 2D array of strings with all the contents
    private func fetchCSV(csv: String) -> [[String]] {
        let parsedCSV: [[String]] = csv.components(separatedBy: "\n").map{ $0.components(separatedBy: ";") }
        
        return parsedCSV
    }

}
