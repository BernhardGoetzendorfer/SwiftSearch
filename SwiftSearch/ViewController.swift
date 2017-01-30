//
//  ViewController.swift
//  SwiftSearch
//
//  Created by Bernhard Goetzendorfer on 23/01/2017.
//  Copyright © 2017 Bernhard Goetzendorfer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{


    @IBOutlet weak var tableView: UITableView! //Verknüpfung zur TableView
    @IBOutlet weak var searchBar: UISearchBar! //Verknüpfung zur Searchbar
    
    var searchActive : Bool = false //Bool, ob die Searchbar aktiv sein soll oder nicht
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"] //Daten, die gefiltert werden
    var filtered:[String] = [] //Wenn der User etwas sucht, kommen die Resultate hier rein
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self  //Delegates + datasource wird gesetzt
        tableView.dataSource = self
        searchBar.delegate = self
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    { //Wird ausgeführt, wenn die Searchbar angetippt wird
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    { //Wird ausgelöst, wenn die Suche beendet ist
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    { //Wird ausgelöst wenn die Suche abgebrochen wird
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    { //Wird ausgelöst, wenn der Suche Button geklickt wird
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    { //Wird aufgerufen, wenn sich der Text in der Searchbar geändert hat
        
        filtered = data.filter({ (text) -> Bool in // Im filtered sind die reinen Gefilterten Daten drinnen, als Array aus Strings
            let tmp: NSString = text as NSString //In tmp wird der gefilterte Text angezeigt zB Aus (von Austria)
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int //Tableview stuff
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int //Tableview stuff
    {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row];
        }
        
        return cell;
    }

}

