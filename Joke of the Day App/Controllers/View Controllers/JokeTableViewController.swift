//
//  JokeTableViewController.swift
//  Joke of the Day App
//
//  Created by Drew Miller on 8/5/20.
//  Copyright © 2020 DevMtn. All rights reserved.
//

import UIKit

class JokeTableViewController: UITableViewController {
    
    var categories: [String] = []
    
    func generateRandomColor() -> UIColor {
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        return randomColor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JokeController.fetchCategories { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self.categories = categories
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        let category = self.categories[indexPath.row]
        
        cell.textLabel?.text = category.uppercased()
        cell.backgroundColor = generateRandomColor()
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
            let destinationVC = segue.destination as? JokeDetailViewController else { return }
            
            let categoryToSend = categories[indexPath.row]
            let color = tableView.cellForRow(at: indexPath)?.backgroundColor
            
            destinationVC.categoryToReceive = categoryToSend
        }
    }
    
    
}
