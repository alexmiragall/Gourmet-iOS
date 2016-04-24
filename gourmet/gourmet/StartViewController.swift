
//
//  StartViewController.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 23/4/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

class StartViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var loginButton: UIButton!
    
    var userManager = UserManager.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.hidden = true
        if (userManager.isSignedIn()) {
            performSelector(Selector("openApp"), withObject: nil, afterDelay: 1.0)
        } else {
            userManager.signInSilently(self, callback: { (error, errorType) in
                if (error) {
                    self.showLoginButton()
                } else {
                    self.openApp()
                }
            })
        }
    }
    
    @IBAction func clickLogin(sender: UIButton) {
        userManager.signIn(self, callback: { (error, errorType) in
            if (error) {
                self.showLoginButton()
            } else {
                self.openApp()
            }
        })
    }
    
    func showLoginButton() {
        loginButton.hidden = false
    }
    
    func openApp() {
        dispatch_async(dispatch_get_main_queue(), {
            self.performSegueWithIdentifier("segueToMain", sender: nil)
        });
    }
}
