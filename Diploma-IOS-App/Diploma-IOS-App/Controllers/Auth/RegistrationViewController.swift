import UIKit
import Alamofire

class RegistrationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var secondName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var groupId: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var contract: UITextField!
    @IBOutlet weak var registrationButton: UIButton!

    let alert = UIAlertController(title: "Ошибка", message: "Произошла ошибка при регистрации!", preferredStyle: UIAlertController.Style.alert)
    let groups = ["Специалист","Менеджер","Руководство"]
    var pickerView = UIPickerView()
    var params: [String: Any] = [
        "name": "Name",
        "email": "some@email.com",
        "password":"DesiredPassword",
        "groupId": 1,
        "lastname": "Lastname",
        "secondname":"Secondname",
        "phone":"123456789",
        "contract":"1293914",
        "balance":0.0
    ]

    @IBAction func registration(_ sender: UIButton) {
        params.updateValue(String(email.text ?? ""), forKey: "email")
        params.updateValue(String(name.text ?? ""), forKey: "name")
        params.updateValue(String(password.text ?? ""), forKey: "password")
        params.updateValue(String(secondName.text ?? ""), forKey: "secondname")
        params.updateValue(String(lastName.text ?? ""), forKey: "lastname")
        params.updateValue(String(phone.text ?? ""), forKey: "phone")
        params.updateValue(String(contract.text ?? ""), forKey: "contract")

        switch String(groupId.text!) {
        case "Специалист":
            params.updateValue(1, forKey: "groupId")
        case "Менеджер":
            params.updateValue(2, forKey: "groupId")
        case "Руководство":
            params.updateValue(3, forKey: "groupId")
        default:
            params.updateValue(1, forKey: "groupId")
        }
 loginToAuthModule(userParams: params)

    }

    func loginToAuthModule(userParams:[String:Any]){

        authModule.registrationWithAPI(userParams: userParams ) {
            (response) in

            if response!.count < 3 {


                self.present(self.alert, animated: true, completion: nil)

            } else {

                self.dismiss(animated: true, completion: nil)

            }
        }

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {

        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return groups.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return groups[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        groupId.text=groups[row]
    }

    override func viewDidLoad() {

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        super.viewDidLoad()

        pickerView.dataSource=self
        pickerView.delegate=self
        groupId.inputView = pickerView

        registrationButton.layer.cornerRadius = 11
        name.layer.cornerRadius = 11
        name.setLeftPaddingPoints(10)
        secondName.layer.cornerRadius = 11
        secondName.setLeftPaddingPoints(10)
        lastName.layer.cornerRadius = 11
        lastName.setLeftPaddingPoints(10)
        email.layer.cornerRadius = 11
        email.setLeftPaddingPoints(10)
        password.layer.cornerRadius = 11
        password.setLeftPaddingPoints(10)
        groupId.layer.cornerRadius = 11
        groupId.setLeftPaddingPoints(10)
        phone.layer.cornerRadius = 11
        phone.setLeftPaddingPoints(10)
        contract.layer.cornerRadius = 11
        contract.setLeftPaddingPoints(10)

    }
}

