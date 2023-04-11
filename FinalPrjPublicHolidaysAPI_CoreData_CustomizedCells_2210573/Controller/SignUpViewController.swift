//
//  SignUpViewController.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-07.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    /// we get and initialize the variable created for core data in the file AppDelegate because the variable is lazy one, will only be initialized when whe needed
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnEyeShowHidePassword: UIButton!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnRegister.layer.cornerRadius = 15
        
    }
    
    @IBAction func btnEyeShowHidePasswordTouchUpInside(_ sender: Any) {
        
        if txtPassword.isSecureTextEntry {
            btnEyeShowHidePassword.setImage(UIImage.init(systemName: "eye.slash"), for: .normal)
        } else {
            btnEyeShowHidePassword.setImage(UIImage.init(systemName: "eye"), for: .normal)
        }
        txtPassword.isSecureTextEntry.toggle()
        
    }
    
    
    @IBAction func btnRegisterTouchUpInside(_ sender: Any) {
        
        
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

        if User.find(context: context, username: username) == nil {

            let newUser = User(context: context)
            newUser.name = name
            newUser.username = username
            newUser.password = password
            
            if let _ = newUser.save(context: context) {
//                Toast.ok(view: self, title: "User Registered Confirmation", message: "User \(username) registered sucessfull!", handler: nil)
                navigationController?.popViewController(animated: true)
            } else {
                Toast.ok(view: self, title: "Something is wrong!", message: "Problem to register the new user \(username)! Try again later!", handler: nil)
                return
            }

        } else {
            Toast.ok(view: self, title: "Something is wrong!", message: "Username already exist!", handler: nil)
            return
        }
               
        
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
