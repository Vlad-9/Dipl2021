
import UIKit

class LaunchViewController: UIViewController {

    func showLoginScreen() {
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! AuthViewController
        DispatchQueue.main.async {
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    func showMainScreen() {
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
        DispatchQueue.main.async {
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let token = defaults.string(forKey: "Token") ?? "0"
        
        if token == "0" {
            showLoginScreen()
        } else {
            showMainScreen()
        }
        
    }
    
    
    
}
