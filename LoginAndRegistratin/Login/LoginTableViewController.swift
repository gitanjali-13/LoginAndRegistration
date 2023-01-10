//
//  LoginTableViewController.swift
//  LoginAndRegistratin
//
//  Created by Admin on 04/01/23.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginTableViewController: UITableViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var buttonFacebook: FBLoginButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let token = AccessToken.current,
                !token.isExpired {
                // User is logged in, do work such as go to next view controller.
        } else {
            buttonFacebook.permissions = ["public_profile", "email"]
            buttonFacebook.delegate = self
        }
        
       
    }
    
    fileprivate func validationForEmailPassword() {
        
        if let email = txtEmail.text, let password = txtPassword.text {
            if !email.validateEmailId() {
                openAlert(title: "Alert", message: "Email address not found", alertStyle: .alert, actionTitle: ["Ok"], actionStyle: [.default], actions:  [{  _ in
                    print("Ok clicked")
                }])
            } else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Enter valid password", alertStyle: .alert, actionTitle: ["Ok"], actionStyle: [.default], actions:  [{  _ in
                    print("Ok clicked")
                }])
            } else {
                //navigation code
                print("navigation page")
            }
            
        }else {
            openAlert(title: "Alert", message: "Please enter details.", alertStyle: .alert, actionTitle: ["Ok"], actionStyle: [.default], actions:  [{  _ in
                print("Ok clicked") }])
        }
    }
    
    @IBAction func btnLoginClick(_ sender: UIButton) {
        validationForEmailPassword()
    }
    @IBAction func btnSignupClick(_ sender: UIButton) {
        if let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController {
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    
}

extension LoginTableViewController{
//        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return UIScreen.main.bounds.height
//        }
//    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewsHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        let centeringInset = (tableViewsHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
}

extension LoginTableViewController : LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: nil, version: nil, httpMethod: .get)
        request.start{(connection, result , error) in
            print("\(result)")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
}
