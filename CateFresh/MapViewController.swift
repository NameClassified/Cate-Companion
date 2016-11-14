//
//  MapViewController.swift
//  CateFresh
//
//  Created by Jeff Pan on 10/29/16.
//  Copyright © 2016 Connor Pan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    struct carpLocationStruct {
        var name: String
        var longitude: Double
        var latitude: Double
        var info: String
    }
    
    var carpLocations : [carpLocationStruct] = []
    
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
        
        carpLocations = makeLocationArray()
        
        super.viewDidLoad()
        centerMapOnLocation(location: initialLocation)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carpLocations.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if previousAnnotation != nil {
            mapView.removeAnnotation(previousAnnotation!)
        }
        let selectedLoc = carpLocations[indexPath.row]
        let annotation = CLLocationCoordinate2D(latitude: selectedLoc.latitude, longitude: selectedLoc.longitude)
        
        let selected = CarpLocation(title: selectedLoc.name, coordinate: annotation, info: selectedLoc.info)
        
        mapView.addAnnotation(selected)
        previousAnnotation = selected
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = carpLocations[indexPath.row].info + ": " + carpLocations[indexPath.row].name
        return cell
    }
    
    //
    //
    //
    // add Carp Locations here
    //
    //
    //
    
    func makeLocationArray() -> [carpLocationStruct] {
        var loc1 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc1.name = "Jack's Bistro & Famous Bagels"
        loc1.latitude = 34.39848
        loc1.longitude = -119.51768
        loc1.info = "Bagels & Coffee"
        
        var loc2 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc2.name = "Peebee & Jay’s"
        loc2.latitude = 34.396142
        loc2.longitude = -119.514296
        loc2.info = "Sandwiches"
        
        var loc3 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc3.name = "Crushcakes & Café"
        loc3.latitude = 34.399196
        loc3.longitude = -119.519136
        loc3.info = "Breakfast & Brunch"

        var loc4 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc4.name = "Esau’s Café"
        loc4.latitude = 34.396460
        loc4.longitude = -119.521742
        loc4.info = "Breakfast & Brunch"
        
        var loc5 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc5.name = "The Spot"
        loc5.latitude = 34.395648
        loc5.longitude = -119.522395
        loc5.info = "Burgers & Mexican"
        
        var loc6 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc6.name = "Carl's Jr"
        loc6.latitude = 34.401470
        loc6.longitude = -119.524826
        loc6.info = "Burgers"

        var loc7 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc7.name = "McDonald's"
        loc7.latitude = 34.396815
        loc7.longitude = -119.512362
        loc7.info = "Burgers"
        
        var loc8 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc8.name = "Corktree Cellars"
        loc8.latitude = 34.398173
        loc8.longitude = -119.518799
        loc8.info = "Burgers"

        var loc9 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc9.name = "Nugget Bar & Grill"
        loc9.latitude = 34.398213
        loc9.longitude = -119.517146
        loc9.info = "Seafood & Burgers"

        var loc10 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc10.name = "The Palms"
        loc10.latitude = 34.397290
        loc10.longitude = -119.520735
        loc10.info = "Seafood & American"
        
        var loc11 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc11.name = "Domino's Pizza"
        loc11.latitude = 34.396094
        loc11.longitude = -119.513168
        loc11.info = "Pizza"
        
        var loc12 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc12.name = "Nutbelly Pizzeria & Deli"
        loc12.latitude = 34.398640
        loc12.longitude = -119.519188
        loc12.info = "Pizza/Italian"
        
        var loc13 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc13.name = "PizzaMan Dan's"
        loc13.latitude = 34.396986
        loc13.longitude = -119.521036
        loc13.info = "Pizza/Italian"
        
        var loc14 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc14.name = "Rusty's Pizza Parlor"
        loc14.latitude = 34.397250
        loc14.longitude = -119.515976
        loc14.info = "Pizza/Italian"
        
        var loc15 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc15.name = "GiannFranco's Trattoria"
        loc15.latitude = 34.396651
        loc15.longitude = -119.520793
        loc15.info = "Italian"
        
        var loc16 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc16.name = "Delgado's Mexican Foods"
        loc16.latitude = 34.402114
        loc16.longitude = -119.529771
        loc16.info = "Mexican"
        
        var loc17 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc17.name = "Taco Bell"
        loc17.latitude = 34.396627
        loc17.longitude = -119.513365
        loc17.info = "Mexican"
        
        var loc18 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc18.name = "El Taco Grande"
        loc18.latitude = 34.396443
        loc18.longitude = -119.512333
        loc18.info = "Mexican"
        
        var loc19 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc19.name = "Senor Frog's"
        loc19.latitude = 34.398041
        loc19.longitude = -119.519135
        loc19.info = "Mexican"
        
        var loc20 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc20.name = "Oaxaca Fresh Mexican Grill"
        loc20.latitude = 34.397316
        loc20.longitude = -119.520587
        loc20.info = "Mexican"
        
        var loc21 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc21.name = "Beach Liquor"
        loc21.latitude = 34.397393
        loc21.longitude = -119.520005
        loc21.info = "Burritos"
        
        var loc22 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc22.name = "Reynaldo's Bakery"
        loc22.latitude = 34.398170
        loc22.longitude = -119.519337
        loc22.info = "Bakeries, Mexican"
        
        var loc23 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc23.name = "Siam Elephant"
        loc23.latitude = 34.396510
        loc23.longitude = -119.521681
        loc23.info = "Thai"
        
        var loc24 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc24.name = "Uncle Chen Restaurant"
        loc24.latitude = 34.396407
        loc24.longitude = -119.513784
        loc24.info = "Chinese"
        
        var loc25 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc25.name = "Pacific Health Foods"
        loc25.latitude = 34.398437
        loc25.longitude = -119.518661
        loc25.info = "Juice Bar & Smoothies"
        
        var loc26 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc26.name = "A Healthy Life"
        loc26.latitude = 34.396350
        loc26.longitude = -119.512540
        loc26.info = "Juice Bar & Smoothies"
        
        var loc27 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc27.name = "Lucky Llama Coffee"
        loc27.latitude = 34.398076
        loc27.longitude = -119.516906
        loc27.info = "Coffee"
        
        var loc28 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc28.name = "Coffee Bean & Tea Leaf"
        loc28.latitude = 34.399103
        loc28.longitude = -119.518785
        loc28.info = "Coffee"
        
        var loc29 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc29.name = "Tyler's Donuts"
        loc29.latitude = 34.395560
        loc29.longitude = -119.514229
        loc29.info = "Donuts"
        
        var loc30 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc30.name = "Chocolats du Calibressan"
        loc30.latitude = 34.403847
        loc30.longitude = -119.533469
        loc30.info = "Desserts"
        
        var loc31 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc31.name = "Foster's Freeze"
        loc31.latitude = 34.397039
        loc31.longitude = -119.516442
        loc31.info = "Ice Cream & Frozen Yogurt"
        
        var loc32 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc32.name = "Hugos Restaurant"
        loc32.latitude = 34.396295
        loc32.longitude = -119.512740
        loc32.info = "Breakfast & Brunch"
        
        var loc33 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc33.name = "YoYumYum Frozen Yogurt"
        loc33.latitude = 34.396161
        loc33.longitude = -119.514314
        loc33.info = "Ice Cream & Frozen Yogurt"
        
        var loc34 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc34.name = "Robitaille's Fine Candies"
        loc34.latitude = 34.398142
        loc34.longitude = -119.518842
        loc34.info = "Candy"
        
        var loc35 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc35.name = "Laughing Buddha Thrift"
        loc35.latitude = 34.397594
        loc35.longitude = -119.520516
        loc35.info = "Thrift Store"
        
        var loc36 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc36.name = "Carpinteria State Beach"
        loc36.latitude = 34.392630
        loc36.longitude = -119.517583
        loc36.info = "Beach"
        
        var loc37 = carpLocationStruct(name: "", longitude: 0.0, latitude: 0.0, info: "")
        loc37.name = "Starbucks"
        loc37.latitude = 34.394970
        loc37.longitude = -119.513189
        loc37.info = "Coffee"
        
        return [loc1,loc2,loc3,loc4,loc32,loc5,loc6,loc7,loc8,loc9,loc10,loc11,loc12,loc13,loc14,loc15,loc16,loc17,loc18,loc19,loc20,loc21,loc22,loc23,loc24,loc25,loc26,loc27,loc28,loc37,loc29,loc30,loc31,loc33,loc34,loc35,loc36]
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
