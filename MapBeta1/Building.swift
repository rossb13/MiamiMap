//
//  Building.swift
//  Miami University iOS Application
//
//  Created by Brian Ross
//

import Foundation
import MapKit
import AddressBook

class Building: MKPlacemark{
    
    let buildingName: String
    let buildingType: BuildingType
    
    init(buildingName: String, street: String, city: String, state: String, zipCode: String, buildingType: BuildingType, coordinate: CLLocationCoordinate2D) {
        self.buildingName = buildingName
        self.buildingType = buildingType
        
        let addressDictionary =
            [
                kABPersonAddressStreetKey as String: street,
                kABPersonAddressCityKey as String: city,
                kABPersonAddressStateKey as String: state,
                kABPersonAddressZIPKey as String: zipCode
        ]
        
        super.init(coordinate: coordinate, addressDictionary: addressDictionary)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum BuildingType: String {
    case Academic = "Academic"
    case Athletice = "Athletic"
    case Dinig = "Dining"
    case Library = "Library"
    case Residence = "Residence"
}


