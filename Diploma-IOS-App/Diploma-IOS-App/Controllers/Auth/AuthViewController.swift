import UIKit
import Alamofire

class AuthViewController: UIViewController {

    let alert = UIAlertController(title: "Ошибка", message: "Неверный email или пароль", preferredStyle: UIAlertController.Style.alert)

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwd: UITextField!

    @IBAction func login(_ sender: Any) {

        let username = String(email.text ?? "")
        let password = String(passwd.text ?? "")
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        loginToAuthModule(userString: base64LoginString)

    }

    @IBAction func registration(_ sender: UIButton) {

        performSegue(withIdentifier: "mySegue", sender: self)
    }

    // MARK: - ServerModule
    func loginToAuthModule(userString:String){

        authModule.loginWithAPI(userString: userString) {
            (user) in

            if user!.count < 3 {

                self.present(self.alert, animated: true, completion: nil)

            } else {

                authModule.saveToken(token: user!["token"] as! String)
                self.performSegue(withIdentifier: "basicMenuSegue", sender: self)
            }
        }
    }

    override func viewDidLoad() {

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        loginButton.layer.cornerRadius = 11
        registerButton.layer.cornerRadius = 11
        email.layer.cornerRadius = 11
        passwd.layer.cornerRadius = 11

        email.setLeftPaddingPoints(10)
        passwd.setLeftPaddingPoints(10)

        super.viewDidLoad()
    }
}


