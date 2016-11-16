//
//  hoursViewController.swift
//  CateFresh
//
//  Created by Jeff Pan on 10/29/16.
//  Copyright © 2016 Connor Pan. All rights reserved.
//

import UIKit

class hoursViewController: UIViewController {
    struct status {
        var seconds :Double
        var open :Bool
    }
    
    var file = File()


    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var diningLabel: UILabel!
    @IBOutlet weak var poolLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    let userCalendar = Calendar.current
    

    override func viewDidLoad() {
        
        //Change hours in these constants as seconds from midnight
        let healthOpen = 7.0 * 3600.0
        let healthClose = 18.5 * 3600.0
        let poolOpen = 7.0 * 3600.0
        let poolClose = 19.0 * 3600.0
        let breakfastOpen = 6.5 * 3600.0
        let breakfastClose = 8.75 * 3600.0
        let lunchOpen = (11.0 + (25.0/60.0)) * 3600.0
        let lunchClose = (12.0 * (35.0/60.0)) * 3600.0
        let dinnerOpen = 17.5 * 3600.0
        let dinnerClose = 19.0 * 3600.0
        let restOpen = 7.0 * 3600.0
        let restClose = 23.0 * 3600.0
        
        var healthStatus = status(seconds: 0.0, open: false)
        var restStatus = status(seconds: 0.0, open: false)
        var poolStatus = status(seconds: 0.0, open: false)
        
        var breakfastStatus = status(seconds: 0.0, open: false)
        var lunchStatus = status(seconds: 0.0, open: false)
        var dinnerStatus = status(seconds: 0.0, open: false)
        
        healthStatus = determineStatus(openSeconds: healthOpen, closeSeconds: healthClose)
        restStatus = determineStatus(openSeconds: restOpen, closeSeconds: restClose)
        poolStatus = determineStatus(openSeconds: poolOpen, closeSeconds: poolClose)
        breakfastStatus = determineStatus(openSeconds: breakfastOpen, closeSeconds: breakfastClose)
        lunchStatus = determineStatus(openSeconds: lunchOpen, closeSeconds: lunchClose)
        dinnerStatus = determineStatus(openSeconds: dinnerOpen, closeSeconds: dinnerClose)
        
        // Get the document's file path.
        let path = Bundle.main.path(forResource: file.name, ofType: nil)
        
        // Create an NSURL object based on the file path.
        let url = NSURL.fileURL(withPath: path!)
        
        // Create an NSURLRequest object.
        let request = NSURLRequest(url: url)
        
        // Load the web viewer using the request object.
        webView.loadRequest(request as URLRequest)
        
        super.viewDidLoad()

        if healthStatus.open {
            healthLabel.text = "Heath Center closes " + convertToString(secs: healthStatus.seconds)
            healthLabel.textColor = UIColor.blue
        } else {
            healthLabel.text = "Heath Center opens " + convertToString(secs: healthStatus.seconds)
            healthLabel.textColor = UIColor.red
        }
        
        if poolStatus.open {
            poolLabel.text = "Pool closes " + convertToString(secs: poolStatus.seconds)
            poolLabel.textColor = UIColor.blue
        } else {
            poolLabel.text = "Pool opens " + convertToString(secs: poolStatus.seconds)
            poolLabel.textColor = UIColor.red
        }
        
        if restStatus.open {
            restLabel.text = "Theater, Keck Lab, and Classrooms close " + convertToString(secs: restStatus.seconds)
            restLabel.textColor = UIColor.blue
        } else {
            restLabel.text = "Theater, Keck Lab, and Classrooms open " + convertToString(secs: restStatus.seconds)
            restLabel.textColor = UIColor.red
        }
        
        //check if it's meal time
        if breakfastStatus.open || lunchStatus.open || dinnerStatus.open {
            if breakfastStatus.open {
                diningLabel.text = "Breakfast closes " + convertToString(secs: breakfastStatus.seconds)
            }
            if lunchStatus.open {
                diningLabel.text = "Lunch closes " + convertToString(secs: lunchStatus.seconds)
            }
            if dinnerStatus.open {
                diningLabel.text = "Dinner closes " + convertToString(secs: dinnerStatus.seconds)
            }
            diningLabel.textColor = UIColor.blue
        } else {
            //check next meal
            
            if breakfastStatus.seconds < lunchStatus.seconds {
                if breakfastStatus.seconds < dinnerStatus.seconds {
                    //breakfast is next
                    diningLabel.text = "Breakfast opens " + convertToString(secs: breakfastStatus.seconds)
                } else {
                    //dinner is next
                    diningLabel.text = "Dinner opens " + convertToString(secs: dinnerStatus.seconds)
                    
                }
            } else {
                if lunchStatus.seconds < dinnerStatus.seconds {
                    //lunch is next
                    diningLabel.text = "Lunch opens " + convertToString(secs: lunchStatus.seconds)
                } else {
                    //dinner is next
                    diningLabel.text = "Dinner opens " + convertToString(secs: dinnerStatus.seconds)
                    
                }
                
            }
            diningLabel.textColor = UIColor.red
            
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func secondsUntilOpen(openSeconds: Double) -> Double {
        let date = Date()
        let startOfToday = Calendar.current.startOfDay(for: date)
        
        return openSeconds - date.timeIntervalSince(startOfToday)
    }
    
    func secondsUntilClose(closeSeconds: Double) -> Double {
        let date = Date()
        let startOfToday = Calendar.current.startOfDay(for: date)
        
        return closeSeconds - date.timeIntervalSince(startOfToday)
    }
    
    func determineStatus(openSeconds: Double, closeSeconds: Double) -> status {
        let open = secondsUntilOpen(openSeconds: openSeconds)
        let close = secondsUntilClose(closeSeconds: closeSeconds)
        var returnStatus = status(seconds: 0.0, open: false)
        
        if open > 0 {
            // Currently before same day opening
            returnStatus.open = false
            returnStatus.seconds = open
        } else {
            // Currently after same day opening
            if close > 0 {
                //Still open
                returnStatus.open = true
                returnStatus.seconds = close
            } else {
                //closed
                returnStatus.open = false
                returnStatus.seconds = 86400.0 + open
            }
            
        }
        return returnStatus
    }
    
    func convertToString(secs :Double) -> String {
        var hours = 0
        var minutes = 0
        var seconds = secs
        var statusString = ""
        
        if seconds/3600.0 > 0 {
            hours = Int(seconds/3600.0)
            seconds = seconds - Double(hours * 3600)
        } else {
            hours = 0
        }
        
        if seconds/60.0 > 0 {
            minutes = Int(seconds/60.0)
        } else {
            minutes = 0
        }
        
        if hours > 0 && minutes > 0 {
            statusString = "in \(hours) hrs and \(minutes) mins"
        } else if hours == 0 {
            if minutes > 0 {
                statusString =  "in \(minutes) mins"
            } else {
                statusString =  "now"
            }
        }
        return statusString
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
