//
//  hoursViewController.swift
//  CateFresh
//
//  Created by Connor Pan on 10/29/16.
//  Copyright © 2016 Connor Pan. All rights reserved.
//

import UIKit

class hoursViewController: UIViewController {
    
    var hoursTxtLoaded = true
    
    struct hoursStruct {
        var openSeconds: Double = 0.0
        var closeSeconds: Double = 0.0
    }
    
    var healthArray = [hoursStruct](repeatElement(.init(openSeconds: 0.0, closeSeconds: 0.0), count: 7))
    var keckArray = [hoursStruct](repeatElement(.init(openSeconds: 0.0, closeSeconds: 0.0), count: 7))
    var theaterArray = [hoursStruct](repeatElement(.init(openSeconds: 0.0, closeSeconds: 0.0), count: 7))
    var classroomArray = [hoursStruct](repeatElement(.init(openSeconds: 0.0, closeSeconds: 0.0), count: 7))
    var breakfastArray = [hoursStruct](repeatElement(.init(openSeconds: 0.0, closeSeconds: 0.0), count: 7))
    var lunchArray = [hoursStruct](repeatElement(.init(openSeconds: 0.0, closeSeconds: 0.0), count: 7))
    var dinnerArray = [hoursStruct](repeatElement(.init(openSeconds: 0.0, closeSeconds: 0.0), count: 7))
    var poolArray = [hoursStruct](repeatElement(.init(openSeconds: 0.0, closeSeconds: 0.0), count: 7))

    struct status {
        var seconds :Double
        var open :Bool
    }
    
    var file = File()


    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var keckLabel: UILabel!
    @IBOutlet weak var diningLabel: UILabel!
    @IBOutlet weak var poolLabel: UILabel!
    @IBOutlet weak var theaterLabel: UILabel!
    @IBOutlet weak var classroomLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    let userCalendar = Calendar.current
    

    override func viewDidLoad() {
        
        makeHoursArray()
        
        var healthStatus = status(seconds: 0.0, open: false)
        var keckStatus = status(seconds: 0.0, open: false)
        var theaterStatus = status(seconds: 0.0, open: false)
        var classroomStatus = status(seconds: 0.0, open: false)
        var poolStatus = status(seconds: 0.0, open: false)
        
        var breakfastStatus = status(seconds: 0.0, open: false)
        var lunchStatus = status(seconds: 0.0, open: false)
        var dinnerStatus = status(seconds: 0.0, open: false)
        
        var anchorComponents = Calendar.current.dateComponents([.day, .month, .year, .weekday], from: Date())
        let dayOfWeek = anchorComponents.weekday!
        let nextDay = (dayOfWeek % 7) + 1
        
        healthStatus = determineStatus(openSeconds: healthArray[dayOfWeek - 1].openSeconds, closeSeconds: healthArray[dayOfWeek - 1].closeSeconds, nextDayOpenSeconds: healthArray[nextDay - 1].openSeconds)
        keckStatus = determineStatus(openSeconds: keckArray[dayOfWeek - 1].openSeconds, closeSeconds: keckArray[dayOfWeek - 1].closeSeconds, nextDayOpenSeconds: keckArray[nextDay - 1].openSeconds)
        theaterStatus = determineStatus(openSeconds: theaterArray[dayOfWeek - 1].openSeconds, closeSeconds: theaterArray[dayOfWeek - 1].closeSeconds, nextDayOpenSeconds: theaterArray[nextDay - 1].openSeconds)
        classroomStatus = determineStatus(openSeconds: classroomArray[dayOfWeek - 1].openSeconds, closeSeconds: classroomArray[dayOfWeek - 1].closeSeconds, nextDayOpenSeconds: classroomArray[nextDay - 1].openSeconds)
        poolStatus = determineStatus(openSeconds: poolArray[dayOfWeek - 1].openSeconds, closeSeconds: poolArray[dayOfWeek - 1].closeSeconds, nextDayOpenSeconds: poolArray[nextDay - 1].openSeconds)
        breakfastStatus = determineStatus(openSeconds: breakfastArray[dayOfWeek - 1].openSeconds, closeSeconds: breakfastArray[dayOfWeek - 1].closeSeconds, nextDayOpenSeconds: breakfastArray[nextDay - 1].openSeconds)
        lunchStatus = determineStatus(openSeconds: lunchArray[dayOfWeek - 1].openSeconds, closeSeconds: lunchArray[dayOfWeek - 1].closeSeconds, nextDayOpenSeconds: lunchArray[nextDay - 1].openSeconds)
        dinnerStatus = determineStatus(openSeconds: dinnerArray[dayOfWeek - 1].openSeconds, closeSeconds: dinnerArray[dayOfWeek - 1].closeSeconds, nextDayOpenSeconds: dinnerArray[nextDay - 1].openSeconds)
        
        let fileMgr = FileManager.default
        
        if !fileMgr.fileExists(atPath: file.name + "/pdfhours.pdf") {
            
            let alertController = UIAlertController(title: "Missing Data File", message: "\"pdfhours.pdf\" is missing", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
                (result : UIAlertAction) -> Void in
            }
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            // Create an NSURL object based on the file path.
            let url = NSURL.fileURL(withPath: file.name + "/pdfhours.pdf")
            
            // Create an NSURLRequest object.
            let request = NSURLRequest(url: url)
            
            // Load the web viewer using the request object.
            webView.loadRequest(request as URLRequest)
        }
        
        super.viewDidLoad()

        if hoursTxtLoaded == true {
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
            
            if keckStatus.open {
                keckLabel.text = "Keck Lab closes " + convertToString(secs: keckStatus.seconds)
                keckLabel.textColor = UIColor.blue
            } else {
                keckLabel.text = "Keck Lab opens " + convertToString(secs: keckStatus.seconds)
                keckLabel.textColor = UIColor.red
            }
            
            if theaterStatus.open {
                theaterLabel.text = "Theater closes " + convertToString(secs: theaterStatus.seconds)
                theaterLabel.textColor = UIColor.blue
            } else {
                theaterLabel.text = "Theater opens " + convertToString(secs: theaterStatus.seconds)
                theaterLabel.textColor = UIColor.red
            }
            
            if classroomStatus.open {
                classroomLabel.text = "Classrooms close " + convertToString(secs: classroomStatus.seconds)
                classroomLabel.textColor = UIColor.blue
            } else {
                classroomLabel.text = "Classrooms open " + convertToString(secs: classroomStatus.seconds)
                classroomLabel.textColor = UIColor.red
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
    
    func determineStatus(openSeconds: Double, closeSeconds: Double, nextDayOpenSeconds: Double) -> status {
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
                returnStatus.seconds = 86400.0 + secondsUntilOpen(openSeconds: nextDayOpenSeconds)
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
    
    func makeHoursArray() {
        let fileMgr = FileManager.default
        
        if fileMgr.fileExists(atPath: file.name + "/tabdelimtexthours.txt") {
            let hoursFile: FileHandle? = FileHandle(forReadingAtPath: file.name + "/tabdelimtexthours.txt")
            let databuffer = hoursFile?.readDataToEndOfFile()
            hoursFile?.closeFile()
            
            let datastring = NSString(data: databuffer!, encoding: String.Encoding.ascii.rawValue)
            let lines = datastring?.components(separatedBy: "\r")
            
            for line in lines! {
                let words = line.components(separatedBy: "\t")
                let index = findIndex(weekDayName: words[1])
                let openSecs = (Double(words[2])! + Double(words[3])!/60.0) * 3600.0
                let closeSecs = (Double(words[4])! + Double(words[5])!/60.0) * 3600.0
                if index != nil {
                    switch words[0]
                    {
                        case "Health Center":
                            healthArray[index!].openSeconds = openSecs
                            healthArray[index!].closeSeconds = closeSecs
                        case "Pool":
                            poolArray[index!].openSeconds = openSecs
                            poolArray[index!].closeSeconds = closeSecs
                        case "Breakfast":
                            breakfastArray[index!].openSeconds = openSecs
                            breakfastArray[index!].closeSeconds = closeSecs
                        case "Lunch":
                            lunchArray[index!].openSeconds = openSecs
                            lunchArray[index!].closeSeconds = closeSecs
                        case "Dinner":
                            dinnerArray[index!].openSeconds = openSecs
                            dinnerArray[index!].closeSeconds = closeSecs
                        case "Keck Lab":
                            keckArray[index!].openSeconds = openSecs
                            keckArray[index!].closeSeconds = closeSecs
                        case "Theater":
                            theaterArray[index!].openSeconds = openSecs
                            theaterArray[index!].closeSeconds = closeSecs
                        case "Classrooms":
                            classroomArray[index!].openSeconds = openSecs
                            classroomArray[index!].closeSeconds = closeSecs
                    default:
                        presentDataFileIncorrect(alertMessage: "Could not interpret resource name \"" + words[0] + "\" in tabdelimtexthours.txt file")
                    }
                }
            }
        } else {
             presentDataFileMissing(fileName: "tabdelimtexthours.txt")
        }
    }


    func presentDataFileMissing(fileName: String) {
        let alertController = UIAlertController(title: "Missing Data File", message: "\"" + fileName + "\" is missing", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        hoursTxtLoaded = false
    }

    func presentDataFileIncorrect(alertMessage: String) {
        let alertController = UIAlertController(title: "Incorrectly Formatted Data File", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        hoursTxtLoaded = false
    }
    
    func findIndex(weekDayName: String) -> Int? {
        switch weekDayName
        {
            case "Mon":
                return 1
            case "Tue":
                return 2
            case "Wed":
                return 3
            case "Thu":
                return 4
            case "Fri":
                return 5
            case "Sat":
                return 6
            case "Sun":
                return 0
        default:
            presentDataFileIncorrect(alertMessage: "Could not interpret weekday label \"" + weekDayName + "\" in tabdelimtexthours.txt file")
            return nil
        }
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
