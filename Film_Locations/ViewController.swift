//
//  ViewController.swift
//  Film_Locations
//
//  Created by X Y on 4/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataFromFile("locations")
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
                }
            } catch {
                print("Error deserializing JSON: \(error)")
            }
        }
        
        
        
        
    }
    
    
}

