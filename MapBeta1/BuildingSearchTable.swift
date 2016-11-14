//
//  BuildingSearchTable.swift
//  Miami University iOS Application
//
//  Created by Brian Ross
//
import UIKit
import MapKit
import AddressBook

class BuildingSearchTable: UITableViewController {
    
    weak var handleMapSearchDelegate: HandleMapSearch?
    var buildings =   [
        Building(buildingName: "Benton Hall",street: "510 E. High St.", city: "Oxford", state: "Ohio", zipCode: "45056", buildingType: BuildingType.Academic, coordinate: CLLocationCoordinate2D(latitude: 39.510672, longitude: -84.73413599999998))
    ]
    
    var filteredBuildings = [Building]()
    let searchController = UISearchController(searchResultsController: nil)
    var matchingItems: [MKMapItem] = [] //
    var mapView: MKMapView?
    
    func filterContentForSearchText(_ searchText: String) {
        filteredBuildings = buildings.filter { building in
            return building.buildingName.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
}



extension BuildingSearchTable : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        self.tableView.reloadData()
    }
}




extension BuildingSearchTable {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredBuildings.count
        }
        return buildings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let location: Building
        if searchController.isActive && searchController.searchBar.text != "" {
            location = filteredBuildings[(indexPath as NSIndexPath).row]
        } else {
            location = buildings[(indexPath as NSIndexPath).row]
        }
        
        cell.textLabel!.text = location.buildingName
        
        if let street = location.thoroughfare, let city = location.locality,
            let state = location.administrativeArea {
            cell.detailTextLabel!.text = "\(street), \(city), \(state)"
        }
        
        return cell
    }
}



extension BuildingSearchTable {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem: Building
        if searchController.isActive && searchController.searchBar.text != "" {
            selectedItem = filteredBuildings[(indexPath as NSIndexPath).row]
        }
        else {
            selectedItem = buildings[(indexPath as NSIndexPath).row]
        }
        
        handleMapSearchDelegate?.dropPinZoomIn(selectedItem)
        dismiss(animated: true, completion: nil)
    }
}
