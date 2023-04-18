//
//  ViewController.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-07.
//

import UIKit

class ViewController: UIViewController {

    /// we get and initialize the variable created for core data in the file AppDelegate because the variable is lazy one, will only be initialized when whe needed
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var loggedUser : User?
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnEyeShowHidePassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        btnLogin.layer.cornerRadius = 15
        btnSignUp.layer.cornerRadius = 15

    }
    
    /**
     * to perform the unwind segue to the ViewController (Login Page) when the user is correctly deleted in the ManageUserViewController
     */
    @IBAction func unwindToViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        sourceViewController.navigationController?.popViewController(animated: false)
        txtPassword.text = "";
        txtUsername.text = "";
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
     * Validate the username and password to see if matches in the core data to go or not to SearchHolidaysViewController. For the others view controllers it can go directly
     */
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        
        if ( identifier == Segue.toSearchHolidaysViewController) {
            
            guard let username = txtUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(), (username.count >= User.USERNAME_MIN_LENGTH && username.count <= User.USERNAME_MAX_LENGTH) else {

                Toast.ok(view: self, title: "Something is wrong!", message: "Enter valid username with length \(User.USERNAME_MIN_LENGTH)-\(User.USERNAME_MAX_LENGTH) characters!", handler: nil)
                return false

            }
            
            guard let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), (password.count >= User.PASSWORD_MIN_LENGTH && password.count <= User.PASSWORD_MAX_LENGTH) else {

                Toast.ok(view: self, title: "Something is wrong!", message: "Enter valid password with length \(User.PASSWORD_MIN_LENGTH)-\(User.PASSWORD_MAX_LENGTH) characters!", handler: nil)
                return false

            }
            
            if User.all(context: context).count > 0 {

                if let user = User.find(context: context, username: username) {

                    if user.password == password {

                        self.loggedUser = user

                        return true

                    } else {

                        Toast.ok(view: self, title: "Something is wrong!", message: "Please enter a valid password!", handler: nil)
                        return false
                    }

                } else {
                    Toast.ok(view: self, title: "Something is wrong!", message: "User name not found!", handler: nil)
                    return false
                }
            } else {
                Toast.ok(view: self, title: "Something is wrong!", message: "User or password not found! Enter valid username and password!", handler: nil)
                return false
            }
            
        } else {
            return true
        }
        
    }
    
    /**
     * Set the values in the next SearchHolidaysViewController
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.toSearchHolidaysViewController {
            
            let searchHolidaysViewController = segue.destination as! SearchHolidaysViewController
            
            searchHolidaysViewController.loggedUser = self.loggedUser
            
        }
        
    }

}

