import Foundation

// MARK: - ODPResponse
struct ODPResponse: Codable {
    
    var data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let monitors: [Monitor]
}

// MARK: - Monitor
struct Monitor: Codable {
    let locationStop: LocationStop
    let lines: [Line]
    let attributes: MonitorAttributes
}

// MARK: - MonitorAttributes
struct MonitorAttributes: Codable {
}

// MARK: - Line
struct Line: Codable {
    let name: Name
    let towards: String
    let direction: Direction
    let platform, richtungsID: String
    let barrierFree, realtimeSupported, trafficjam: Bool
    let departures: Departures
    let type: TypeEnum
    let lineID: Int

    enum CodingKeys: String, CodingKey {
        case name, towards, direction, platform
        case richtungsID = "richtungsId"
        case barrierFree, realtimeSupported, trafficjam, departures, type
        case lineID = "lineId"
    }
}

// MARK: - Departures
struct Departures: Codable {
    let departure: [Departure]
}

// MARK: - Departure
struct Departure: Codable {
    let departureTime: DepartureTime
    let vehicle: Vehicle?
}

// MARK: - DepartureTime
struct DepartureTime: Codable {
    let timePlanned: String
    let timeReal: String?
    let countdown: Int
}

// MARK: - Vehicle
struct Vehicle: Codable {
    let name: Name
    let towards: Towards
    let direction: Direction
    let platform, richtungsID: String
    let barrierFree: Bool
    let foldingRamp: Bool?
    let foldingRampType: String?
    let realtimeSupported, trafficjam: Bool
    let type: TypeEnum
    let attributes: MonitorAttributes
    let linienID: Int

    enum CodingKeys: String, CodingKey {
        case name, towards, direction, platform
        case richtungsID = "richtungsId"
        case barrierFree, foldingRamp, foldingRampType, realtimeSupported, trafficjam, type, attributes
        case linienID = "linienId"
    }
}

enum Direction: String, Codable {
    case r = "R"
}

enum Name: String, Codable {
    case u4 = "U4"
}

enum Towards: String, Codable {
    case hütteldorf = "HÜTTELDORF    "
    case hütteldorfSU = "Hütteldorf S U"
}

enum TypeEnum: String, Codable {
    case ptMetro = "ptMetro"
}

// MARK: - LocationStop
struct LocationStop: Codable {
    let type: String
    let geometry: Geometry
    let properties: Properties
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}

// MARK: - Properties
struct Properties: Codable {
    let name, title, municipality: String
    let municipalityID: Int
    let type, coordName, gate: String
    let attributes: PropertiesAttributes

    enum CodingKeys: String, CodingKey {
        case name, title, municipality
        case municipalityID = "municipalityId"
        case type, coordName, gate, attributes
    }
}

// MARK: - PropertiesAttributes
struct PropertiesAttributes: Codable {
    let rbl: Int
}

