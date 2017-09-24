//
//  ViewController.swift
//  Wikipedia API
//
//  Created by Balgard on 9/18/17.
//  Copyright © 2017 Balgard. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController {

	var sources = [[String : String]]()
	var search = "wikipedia"


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Results"
        let searchTerm = "en.wikipedia.org/w/api.php?action=query&list=search&srsearch=\(search)&utf8=&format=json"
        DispatchQueue.global(qos: .userInitiated).async
        {
        	[unowned self] in 
        	if let url = URL(string : searchTerm)
        	{
        		if let data = try? Data(contentsOf: url)
        		{
        			let json = try! JSON(data:data)
        			if json["totalhits"] >= 1
        			{
        				self.parse(json: json)
        				return
        			}
        		}
        	}
        	self.loadError()
        }
    }

    //fix all of this shit
    
    
    
    func parse(json: JSON)
    {
        for result in json["search"].arrayValue
        {
            let id = result["id"].stringValue
            let name = result["title"].stringValue
            let description = result["snippet"].stringValue
            let source = ["id" : id, "name" : name, "description" : description]
            sources.append(source)
        }
        DispatchQueue.main.async
            {
                [unowned self] in
                self.tableView.reloadData()
        }
    }
    
    func loadError()
    {
        DispatchQueue.main.async
            {
                [unowned self] in
                let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the search results", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let source = sources[indexPath.row]
        cell.textLabel?.text = source["name"]
        cell.detailTextLabel?.text = source["description"]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        //need the url of the wikipedia page here, need to debug in order to find out where to get the url from
        
        //maybe set up an array of urls/strings and then use the index of the source to get the url for the source
        let url = URL(string: articles[indexPath.row]["url"]!)
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }

}

