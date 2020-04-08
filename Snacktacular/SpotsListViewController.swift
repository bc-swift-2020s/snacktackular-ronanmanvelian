//
//  ViewController.swift
//  Snacktacular
//
//  Created by John Gallaugher on 3/23/18.
//  Modified by Ronan Manvelian for in-class use.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import UIKit
import CoreLocation

class SpotsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var spots: Spots!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        spots = Spots()
        
        // We add 3 instances of "dummy data" for initial viewing in the tableView
        spots.spotArray.append(Spot(name: "El Pelon", address: "Comm. Ave", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0, postingUserID: "", documentID: ""))
        spots.spotArray.append(Spot(name: "Shake Shack", address: "The Street - Chestnut Hill", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0, postingUserID: "", documentID: ""))
        spots.spotArray.append(Spot(name: "Pino's Pizza", address: "Cleveland Circle", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0, postingUserID: "", documentID: ""))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSpot" {
            let destination = segue.destination as! SpotDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.spot = spots.spotArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    // Note: we force-unwrap "tableView.indexPathForSelectedRow" because
    // we know that there is, for sure, an index path selected if we are
    // executing a "Show" segue (there is already info in the selected cell)
    
    // Note: in the else statement (which executes when the present modally
    // segue executes), we do not force-unwrap "tableView.indexPathForSelectedRow"
    // because we are checking (using "if let") if there has been a previously
    // selected cell before the user presses the "add" button (which executes
    // the present modally (with identifier "AddDetail", not "ShowDetail",
    // therefore resulting in the execution of the else statement) segue
}

extension SpotsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.spotArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SpotsTableViewCell
        cell.nameLabel.text = spots.spotArray[indexPath.row].name
        return cell
        
        // Note: we use "as!" in the initialization of "cell" because the cell type
        // we are using is a custom type, not a standard Apple type
        
        // NoteL we use "nameLabel" instead of the standard "textLabel" because we
        // created a custom class for the custom cell type, and one of the instance
        // variables is "nameLabel"
    }
    
    // We need this function so that we can set the height of each row for the tableView
    // We did not need to do this for non-custom cell types, as far as I can tell, but try
    // to set the row height for non-custom table views without using this function
    // Regardless, we need this function to set the row height for custom cell types,
    // or else out cell values will be smushed together when loading (or other issues may occur)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
