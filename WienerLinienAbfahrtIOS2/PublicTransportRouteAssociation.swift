//
//  PublicTransportRouteAssociation.swift
//  WienerLinienAbfahrtIOS2
//
//  Created by user on 20.10.23.
//

import Foundation


class PublicTransportRouteAssociation {
    let stopId: Int
    let lineId: Int
    
    init(stopId: Int, lineId: Int) {
        self.stopId = stopId
        self.lineId = lineId
    }
    
}
