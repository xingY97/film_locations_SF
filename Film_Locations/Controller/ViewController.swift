//
//  ViewController.swift
//  Film_Locations
//
//  Created by X Y on 4/20/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = 150
        return table
    }()
    
    var films: [FilmEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataFromFile("locations")
        setTable()
    }
    
    
    func getDataFromFile(_ fileName: String){
        
        let path = Bundle.main.path(forResource: "locations", ofType: ".json")
        if let path = path {
            let url = URL(fileURLWithPath: path)
            print(url)
            
            let contents = try? Data(contentsOf: url)
            do {
                if let data = contents,
                   let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] {
                    print(jsonResult)
                    
                    for film in jsonResult{
                        let firstActor = film["actor_1"] as? String ?? ""
                        let locations = film["locations"] as? String ?? ""
                        let releaseYear = film["release_year"] as? String ?? ""
                        let title = film["title"] as? String ?? ""
                        let movie = FilmEntry(firstActor: firstActor, locations: locations, releaseYear: releaseYear, title: title)
                        
                        films.append(movie)
                        
                    }
                }
                
            } catch {
                print("Error deserializing JSON: \(error)")
            }
            
        }
        
    }
    func setTable() {
        
        table.delegate = self
        table.dataSource = self
        
        self.view.addSubview(table)
        table.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive  = true
        table.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        table.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row) \(films[indexPath.row])"
        return cell
    }
    
    
}

