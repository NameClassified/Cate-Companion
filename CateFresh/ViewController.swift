//
//  ViewController.swift
//  CateFresh
//
//  Created by Connor Pan on 8/17/16.
//  Copyright © 2016 Connor Pan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var fileMgr:FileManager = FileManager.default
    var docsDir:String = ""
    var dataFile:String = ""
    
    var file = File()

    @IBAction func trashTapped(_ sender: Any) {
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        dataFile = dirPaths[0].appendingPathComponent("Inbox").path

        let alertController = UIAlertController(title: "Delete All Data Files", message: "You are about to delete all data files", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            do{
                try self.fileMgr.removeItem(atPath: self.dataFile)
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            (result : UIAlertAction) -> Void in
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func directoryTapped(_ sender: Any) {
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        dataFile = dirPaths[0].appendingPathComponent("Inbox").path
        print(dataFile)
        
        file.name = dataFile
        performSegue(withIdentifier: "directorySegue", sender: file)
    }
    
    @IBAction func mapTapped(_ sender: AnyObject) {
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        dataFile = dirPaths[0].appendingPathComponent("Inbox/map.pdf").path
        print(dataFile)
        
        file.name = dataFile
        performSegue(withIdentifier: "pdfSegue", sender: file)
    }
    @IBAction func handBookTapped(_ sender: AnyObject) {
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        dataFile = dirPaths[0].appendingPathComponent("Inbox/handbook.pdf").path
        print(dataFile)
        
        file.name = dataFile
        performSegue(withIdentifier: "pdfSegue", sender: file)
    }
    @IBAction func carpTapped(_ sender: AnyObject) {
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        dataFile = dirPaths[0].appendingPathComponent("Inbox/tabdelimtextcarp.txt").path
        print(dataFile)
        
        file.name = dataFile
        performSegue(withIdentifier: "mapSegue", sender: file)
    }
    @IBAction func hoursTapped(_ sender: AnyObject) {
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        dataFile = dirPaths[0].appendingPathComponent("Inbox").path
        print(dataFile)

        file.name = dataFile
        performSegue(withIdentifier: "hoursSegue", sender: file)
    }
    @IBAction func busTapped(_ sender: AnyObject) {
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        dataFile = dirPaths[0].appendingPathComponent("Inbox/bus.pdf").path
        print(dataFile)
        
        file.name = dataFile
        performSegue(withIdentifier: "pdfSegue", sender: file)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "pdfSegue" {
            let defVC = segue.destination as! pdfViewController
            defVC.file = (sender as? File)!
        } else if segue.identifier == "mapSegue" {
            let defVC = segue.destination as! MapViewController
            defVC.file = (sender as? File)!
        } else if segue.identifier == "hoursSegue"{
            let defVC = segue.destination as! hoursViewController
            defVC.file = (sender as? File)!
        } else {
            let defVC = segue.destination as! directoryViewController
            defVC.file = (sender as? File)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

