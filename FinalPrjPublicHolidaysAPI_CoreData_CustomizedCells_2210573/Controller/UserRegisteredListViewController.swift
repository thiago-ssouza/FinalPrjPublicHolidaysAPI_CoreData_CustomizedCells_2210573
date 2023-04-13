//
//  UserRegisteredListViewController.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-10.
//

import UIKit
import CoreData

class UserRegisteredListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // we get and initialize the variable created for core data in the file AppDelegate because the variable is lazy one, will only be initialized when whe needed
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    /**
     * Return the total of username registered
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.all(context: context).count
    }
    
    /**
     * Show in the tableview all the usernames registered using reusable cells
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = User.all(context: context)[indexPath.row].username
        
        return cell
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
