//
//  ForecastTableViewController.swift
//  RainyShinyCloudy
//
//  Created by James Stafford on 2017-06-26.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import UIKit

class ForecastTableViewController: UIViewController, UITableViewController {

    
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 6
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)

    
        return cell
    }
}
