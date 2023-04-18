//
//  ManageUserViewController.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-10.
//

import UIKit

class ManageUserViewController: UIViewController {

    // we get and initialize the variable created for core data in the file AppDelegate because the variable is lazy one, will only be initialized when whe needed
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public var loggedUser : User?
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnEyeShowHidePassword: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnDelete.layer.cornerRadius = 15
        
        if self.loggedUser != nil { // insert mode
            
            txtUsername.isEnabled = false
            
            txtName.text = self.loggedUser!.name
            txtUsername.text = self.loggedUser!.username
            txtPassword.text = self.loggedUser!.password
            
        }
    }
    
    /**
     * Show or hide the Password for the user consuting
     */
    @IBAction func btnEyeShowHidePasswordTouchUpInside(_ sender: Any) {
        
        if txtPassword.isSecureTextEntry {
            btnEyeShowHidePassword.setImage(UIImage.init(systemName: "eye.slash"), for: .normal)
        } else {
            btnEyeShowHidePassword.setImage(UIImage.init(systemName: "eye"), for: .normal)
        }
        txtPassword.isSecureTextEntry.toggle()
    }
    
    /**
     * Update the user information if the fullname, username and password follow the criterias
     */
    @IBAction func btnSaveTapped(_ sender: Any) {
        
        guard let name = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines), (name.count >= User.NAME_MIN_LENGTH && name.count <= User.NAME_MAX_LENGTH) else {
            
            Toast.ok(view: self, title: "Something is wrong!", message: "Enter valid full name with length \(User.NAME_MIN_LENGTH)-\(User.NAME_MAX_LENGTH) characters!", handler: nil)
            
            return
            
        }
        
        guard let username = txtUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(), (username.count >= User.USERNAME_MIN_LENGTH && username.count <= User.USERNAME_MAX_LENGTH) else {

            Toast.ok(view: self, title: "Something is wrong!", message: "Enter valid username with length \(User.USERNAME_MIN_LENGTH)-\(User.USERNAME_MAX_LENGTH) characters!", handler: nil)
            
            return

        }
        
        guard let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), (password.count >= User.PASSWORD_MIN_LENGTH && password.count <= User.PASSWORD_MAX_LENGTH) else {

            Toast.ok(view: self, title: "Something is wrong!", message: "Enter valid password with length \(User.PASSWORD_MIN_LENGTH)-\(User.PASSWORD_MAX_LENGTH) characters!", handler: nil)
            
            return

        }
        
        if self.loggedUser != nil { // update mode
            
            self.loggedUser!.name = name
            self.loggedUser!.password = password
            
            if let _ = self.loggedUser!.save(context: context) {
                navigationController?.popViewController(animated: true)
            } else {
                Toast.ok(view: self, title: "Something is wrong!", message: "Problem to update the new user \(username)! Try again later!", handler: nil)
                
                return
            }
            
        }
        
    }
    
    /**
     * Try to delete the user loggedin when the user click on the button delete and perform the unwind segue "toViewControllerUnwind" to the ViewController if the user was deleted. If the user is not deleted the  unwind segue will not be performed
     */
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == Segue.toViewControllerUnwind){
            if self.loggedUser!.delete(context: context) {
                return true
            } else {
                Toast.ok(view: self, title: "Something is wrong!", message: "Problem to delete the user \(self.loggedUser!.username!)! Try again later!", handler: nil)
                return false
            }
        }
        return true
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
