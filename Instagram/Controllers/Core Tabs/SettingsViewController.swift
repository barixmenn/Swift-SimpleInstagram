//
//  SettingsViewController.swift
//  Instagram
//
//  Created by macbook on 3.06.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    
    
    @IBOutlet weak var tableview: UITableView!
    
    var settingArray = ["Aollow and invite your friends","Notifications","Security","Security","Ads","Account","Help","About"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func logOutButton(_ sender: Any) {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .destructive) { (UIAlertAction) in
          self.performSegue(withIdentifier: "goToLogin", sender: self)
        }
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
   
    
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }
    
   
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = settingArray[indexPath.row]
        
        return cell
    }
}
