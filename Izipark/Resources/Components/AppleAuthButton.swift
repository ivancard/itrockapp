import Foundation
import AuthenticationServices

protocol AppleSignInDelegate {
    func didSetCredential(id: String?, name: String?, email: String?)
}

@available(iOS 13.0, *)
final class AppleAuthButton: UIButton {

    private var viewController: BaseViewController? {
        return viewContainingController() as? BaseViewController
    }

    var delegate: AppleSignInDelegate?

    // MARK: - Life cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }

    // MARK: - Actions -
    @available(iOS 13.0, *)
    @objc private func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding -
@available(iOS 13.0, *)
extension AppleAuthButton: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return (viewController?.view.window)!
    }

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let id = credentials.user
            let firstName = credentials.fullName?.givenName ?? ""
            let lastName = credentials.fullName?.familyName ?? ""
            let name = "\(firstName) \(lastName)"
            let email = credentials.email
            delegate?.didSetCredential(id: id, name: name, email: email)
            
        default:
            break
        }
    }

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        return
    }
}
