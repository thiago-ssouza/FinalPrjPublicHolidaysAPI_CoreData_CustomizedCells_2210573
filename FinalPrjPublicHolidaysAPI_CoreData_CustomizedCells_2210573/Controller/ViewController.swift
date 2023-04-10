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
        
        //UserModelProvider.mockData()
    }
    
    @IBAction func btnEyeShowHidePasswordTouchUpInside(_ sender: Any) {
        
        if txtPassword.isSecureTextEntry {
            btnEyeShowHidePassword.setImage(UIImage.init(systemName: "eye.slash"), for: .normal)
        } else {
            btnEyeShowHidePassword.setImage(UIImage.init(systemName: "eye"), for: .normal)
        }
        txtPassword.isSecureTextEntry.toggle()
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        
        if identifier == Segue.toSearchHolidaysViewController {
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.toSearchHolidaysViewController {
            
            let searchHolidaysViewController = segue.destination as! SearchHolidaysViewController
            
            searchHolidaysViewController.loggedUser = self.loggedUser
            
        }
        
    }

}

