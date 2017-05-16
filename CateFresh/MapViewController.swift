//
//  MapViewController.swift
//  CateFresh
//
//  Created by Connor Pan on 10/29/16.
//  Copyright © 2016 Connor Pan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct carpLocationStruct {
        var name = ""
        var longitude = 0.0
        var latitude = 0.0
        var info = ""
    }
    
    var carpLocations = [carpLocationStruct]()
    
    var file = File()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var previousAnnotation :CarpLocation?
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let initialLocation = CLLocation(latitude: 34.395462, longitude: -119.512897)
        let regionRadius: CLLocationDistance = 1000
        
        let annotation = CLLocationCoordinate2D(latitude:34.395462, longitude: -119.512897)
        let selected = CarpLocation(title: "Cate Bus Drop Off", coordinate: annotation, info: "")
        
        mapView.addAnnotation(selected)

        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0,regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        makeLocationArray()
        
        super.viewDidLoad()
        centerMapOnLocation(location: initialLocation)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if carpLocations.isEmpty {
            return 1
        } else {
            return carpLocations.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !carpLocations.isEmpty {
            if previousAnnotation != nil {
                mapView.removeAnnotation(previousAnnotation!)
            }
            let selectedLoc = carpLocations[indexPath.row]
            let annotation = CLLocationCoordinate2D(latitude: selectedLoc.latitude, longitude: selectedLoc.longitude)
            
            let selected = CarpLocation(title: selectedLoc.name, coordinate: annotation, info: selectedLoc.info)
            
            mapView.addAnnotation(selected)
            previousAnnotation = selected
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if carpLocations.isEmpty {
            cell.textLabel?.text = "Missing \"tabdelimtextcarp.txt\" file"
        } else {
            cell.textLabel?.text = carpLocations[indexPath.row].info + ": " + carpLocations[indexPath.row].name
            cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size:18)
        }
        return cell
    }
    
    func makeLocationArray() {
        let fileMgr = FileManager.default
        var tempLocation = carpLocationStruct()
        
        if fileMgr.fileExists(atPath: file.name) {
            let carpFile: FileHandle? = FileHandle(forReadingAtPath: file.name)
            let databuffer = carpFile?.readDataToEndOfFile()
            carpFile?.closeFile()
            
            let datastring = NSString(data: databuffer!, encoding: String.Encoding.ascii.rawValue)
            let lines = datastring?.components(separatedBy: "\r")
            
            for line in lines! {
                let words = line.components(separatedBy: "\t")
                tempLocation.info = words[0]
                tempLocation.name = words[1]
                tempLocation.latitude = Double(words[2])!
                tempLocation.longitude = Double(words[3])!
                carpLocations.append(tempLocation)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
