//
//  BusDetailViewController.swift
//  MapBeta1
//
//  Created by Brian Ross on 11/14/16.
//  Copyright © 2016 Brian Ross. All rights reserved.
//

import UIKit

class BusRouteDetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var busRouteImageView: UIImageView!
    
    var detailBusRoute: BusRoute? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailBusRoute = detailBusRoute {
            if let detailDescriptionLabel = detailDescriptionLabel, let busRouteImageView = busRouteImageView {
                detailDescriptionLabel.text = detailBusRoute.name
                busRouteImageView.image = UIImage(named: detailBusRoute.name)
                title = detailBusRoute.name
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
