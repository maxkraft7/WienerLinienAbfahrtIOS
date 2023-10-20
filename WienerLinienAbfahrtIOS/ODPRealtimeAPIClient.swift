import SwiftUI

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

    func fetchLines() {
        // https://www.wienerlinien.at/ogd_realtime/doku/ogd/wienerlinien-ogd-linien.csv
    }

    func fetchStops() {
        // https://www.wienerlinien.at/ogd_realtime/doku/ogd/wienerlinien-ogd-haltepunkte.csv
    }

    func fetchRoutes() {
        // http://www.wienerlinien.at/ogd_realtime/doku/ogd/wienerlinien-ogd-fahrwegverlaeufe.csv

        

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

    // put in a csv string and return a 2D array of strings with all the contents
    private func fetchCSV(csv: String) -> [[String]] {
        let lines = csv.split(separator: "\n")
        var result = [[String]]()

        for line in lines {
            
            //result.append(line.split(separator: ";"))

        }

        return result
    }

}
