//
//  BusRouteMasterViewController.swift
//  MapBeta1
//
//  Created by Brian Ross on 11/14/16.
//  Copyright © 2016 Brian Ross. All rights reserved.
//

import UIKit

class BusRouteMasterViewController: UITableViewController {
    
    // MARK: - Properties
    var detailViewController: BusRouteDetailViewController? = nil
    var busRoutes = [BusRoute]()
    var filteredBusRoutes = [BusRoute]()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        navigationItem.titleView = searchController.searchBar
 
        busRoutes = [BusRoute(name:"Default Route")]

        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? BusRouteDetailViewController
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredBusRoutes.count
        }
        return busRoutes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let busRoute : BusRoute
        if searchController.isActive && searchController.searchBar.text != "" {
            busRoute = filteredBusRoutes[indexPath.row]
        } else {
            busRoute = busRoutes[indexPath.row]
        }
        cell.textLabel!.text = busRoute.name
        //cell.detailTextLabel!.text = candy.category
        return cell
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredBusRoutes = busRoutes.filter { busRoute in
            return busRoute.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let busRoute : BusRoute
                if searchController.isActive && searchController.searchBar.text != "" {
                    busRoute = filteredBusRoutes[indexPath.row]
                } else {
                    busRoute = busRoutes[indexPath.row]
                }
                let controller = (segue.destination as! UINavigationController).topViewController as! BusRouteDetailViewController
                controller.detailBusRoute = busRoute
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}


extension BusRouteMasterViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension BusRouteMasterViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        self.tableView.reloadData()
    }
}

