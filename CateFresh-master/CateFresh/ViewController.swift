//
//  ViewController.swift
//  CateFresh
//
//  Created by Connor Pan on 8/17/16.
//  Copyright © 2016 Connor Pan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var file = File()

    @IBAction func govTapped(_ sender: AnyObject) {
        file.name = "constitution.pdf"
        performSegue(withIdentifier: "pdfSegue", sender: file)
    }
    @IBAction func mapTapped(_ sender: AnyObject) {
        file.name = "map.pdf"
        performSegue(withIdentifier: "pdfSegue", sender: file)
    }
    @IBAction func handBookTapped(_ sender: AnyObject) {
        file.name = "handbook.pdf"
        performSegue(withIdentifier: "pdfSegue", sender: file)
    }
    @IBAction func carpTapped(_ sender: AnyObject) {
        file.name = "carp.pdf"
        performSegue(withIdentifier: "pdfSegue", sender: file)
    }
    @IBAction func hoursTapped(_ sender: AnyObject) {
        file.name = "hours.pdf"
        performSegue(withIdentifier: "pdfSegue", sender: file)
    }
    @IBAction func busTapped(_ sender: AnyObject) {
        file.name = "bus.pdf"
        performSegue(withIdentifier: "pdfSegue", sender: file)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let defVC = segue.destination as! pdfViewController
        defVC.file = (sender as? File)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

