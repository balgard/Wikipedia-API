//
//  SearchViewController.swift
//  Wikipedia API
//
//  Created by Balgard on 9/19/17.
//  Copyright © 2017 Balgard. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var term = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //make below good
    
    //move the term into the next viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let dvc = segue.destination as! ResultsViewController
        dvc.search = term
        dvc.title = "Results"
    }
    
    
    @IBAction func Exit(_ sender: UIBarButtonItem) {
        exit(0)
    }
    

    

}
