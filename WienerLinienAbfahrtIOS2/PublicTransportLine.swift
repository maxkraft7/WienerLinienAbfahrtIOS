//
//  PublicTransportLine.swift
//  WienerLinienAbfahrtIOS2
//
//  Created by user on 20.10.23.
//

import Foundation

class PublicTransportLine: Identifiable, ObservableObject, Hashable {
    
    let id = UUID()
    let lineId: Int
    let name: String
    let type: String
    
    init(lineId: Int, name: String, type: String) {
        self.lineId = lineId
        self.name = name
        self.type = type
    }
    
    static func == (lhs: PublicTransportLine, rhs: PublicTransportLine) -> Bool {
        return lhs.lineId == rhs.lineId
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.lineId);
    }
}
