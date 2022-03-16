
import UIKit
import Alamofire


class MainViewController: UIViewController  {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var segmentOutlet: UISegmentedControl!

    @IBOutlet weak var logoutB: UIButton!


    var userInfo: [[String:Any]] = []
    var userBenefitdDictArray: [[String:Any]] = []
    var avBenifitDictArray: [[String:Any]] = []

    @IBAction func segment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            view1.alpha = 1
            view2.alpha = 0
        } else {
            view1.alpha = 0
            view2.alpha = 1
        }
    }

    @IBAction func logout(_ sender: Any) {

        defaults.set("0", forKey: "Token")
        performSegue(withIdentifier: "goToLogin", sender: self)
    }

    @IBAction func showTransaction(_ sender: UIButton) {
        performSegue(withIdentifier: "showTransaction", sender: self)
    }

    func loadUserInfoFromModule() {

        serverModule.loadUserInfoFromAPI {
            (user) in
           // print(user)
            self.userInfo = user!
            self.balance.text = String(self.userInfo[0]["balance"] as! Float)
            self.name.text = self.userInfo[0]["name"] as? String
            self.surname.text = self.userInfo[0]["secondname"] as? String
        }

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {

        let font = UIFont.boldSystemFont(ofSize: 17)
        segmentOutlet.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        navigationController?.navigationBar.barStyle = .black

        super.viewDidLoad()
        loadUserInfoFromModule()
    }
}
