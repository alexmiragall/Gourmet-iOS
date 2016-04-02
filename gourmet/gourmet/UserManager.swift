//
//  UserManager.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 2/4/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import Firebase

public class UserManager: NSObject, GIDSignInDelegate, GIDSignInUIDelegate {
    
    public static let instance = UserManager()
    
    var firebase: Firebase!
    let userRepository = UserRepository()
    var callbackSignIn: ((error: Bool, errorType: String?) -> Void)?
    var callbackSignOut: ((error: Bool, errorType: String?) -> Void)?
    
    override init() {
        super.init()
        firebase = Firebase(url: "https://tuenti-restaurants.firebaseio.com/")
        // Setup delegates
        GIDSignIn.sharedInstance().delegate = self
    }
    
    public func isSignedIn() -> Bool {
        return firebase.authData != nil
    }
    
    public func signIn(delegate: GIDSignInUIDelegate, callback: (error: Bool, errorType: String?) -> Void) {
        GIDSignIn.sharedInstance().uiDelegate = delegate
        self.callbackSignIn = callback
        GIDSignIn.sharedInstance().signIn()
    }
    
    public func signOut(delegate: GIDSignInUIDelegate, callback: (error: Bool, errorType: String?) -> Void) {
        GIDSignIn.sharedInstance().uiDelegate = delegate
        self.callbackSignOut = callback
        GIDSignIn.sharedInstance().signOut()
        firebase.unauth()
    }
    
    public func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                firebase.authWithOAuthProvider("google", token: user.authentication.accessToken, withCompletionBlock: { (error, authData) in
                    if (error == nil) {
                        self.createAndUpdateUser(authData)
                    } else {
                        self.callbackSignIn!(error: true, errorType: error.localizedDescription)
                    }
                })
            } else {
                print("\(error.localizedDescription)")
                self.callbackSignIn!(error: true, errorType: error.localizedDescription)
            }
    }

    public func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            firebase.unauth();
    }
    
    func createAndUpdateUser(authData: FAuthData) {
        let user = User(id: authData.uid, name: authData.providerData["displayName"] as! String, photoUrl: authData.providerData["profileImageURL"] as? String)
        
        userRepository.setCurrentUser(user, callback: {
            error in
                self.callbackSignIn!(error: error, errorType: nil)
        })
    }
    
    func getUser() -> User? {
        return userRepository.currentUser
    }
}