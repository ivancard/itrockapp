//
//  GoogleAuthButton.swift
//  Izipark
//
//  Created by ivan cardenas on 21/03/2023.
//

import UIKit
import GoogleSignIn
import Combine

protocol GoogleSignInDelegate {
    func didSetGoogleCredentials(googleId: String, googleToken: String)
}

final class GoogleAuthButton: UIButton {
    
    private var screen: UIViewController?
    
    var delegate: GoogleSignInDelegate!

     override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "Disabled")?.cgColor
        addTarget(self, action: #selector(handleGoogleButton), for: .touchUpInside)
    }

    @objc func handleGoogleButton(){
        guard let screen = delegate as? UIViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: screen) { [weak self] result, error in
            guard error == nil, let result = result else { return }
            self?.loginWithGoogleUser(result.user)
          }
    }
    
    private func loginWithGoogleUser(_ user: GIDGoogleUser) {
        let googleID = user.refreshToken.tokenString
        let googleToken = user.accessToken.tokenString
        
        delegate.didSetGoogleCredentials(googleId: googleID,
                                         googleToken: googleToken)
    }
}
