
import UIKit
import Alamofire
import PDFKit

class BuyBenefitViewController: UIViewController {

    @IBOutlet weak var titl: UILabel!
    @IBOutlet weak var descr: UITextView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var secondname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var contract: UITextField!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!

    @IBAction func download(_ sender: UIButton) {
        guard

          let body = lastname.text
          else {
            // 2
            let alert = UIAlertController(
              title: "Ошибка",
              message: "Произошла непредвиденная ошибка",
              preferredStyle: .alert
            )
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              present(alert, animated: true, completion: nil)
              return
          }
        // 3
        let pdfCreator = PDFCreator(
          title: "Договор на оказание социальной выплаты",
            body: "Сотрудник: \(String(secondname.text!)) \(String(name.text!)) \(String(lastname.text!)), договор:\(String(contract.text!))\nНазвание социальной выплаты:\(String(titl.text!))\nОстальные элементы договора"//+"dasl"
        )
        let pdfData = pdfCreator.createFlyer()
        let vc = UIActivityViewController(
          activityItems: [pdfData],
          applicationActivities: []
        )
        present(vc, animated: true, completion: nil)
    }
    @IBOutlet weak var sw: UISwitch!
    var benefitInfoDictArray: [String:Any] = [:]
    var userInfoDictArray: [String: Any] = [:]
    var isOn:Bool = true

    @IBOutlet weak var downloadContr: UIButton!
    @IBOutlet weak var buyB: UIButton!

    @IBAction func `switch`(_ sender: UISwitch) {
        isOn = !isOn
    }
  
    @IBAction func buyBenefit(_ sender: UIButton) {
        if isOn {

            postNewUsBenToModule()

            if let firstVC = presentingViewController as? MainViewController {
                DispatchQueue.main.async {

                    sleep(1)
                    firstVC.loadUserInfoFromModule()
                    firstVC.viewDidLoad()
                    firstVC.viewWillAppear(true)

                    let vc  = firstVC.children[0] as! BenViewController
                    vc.loadUsBenInfoFromModule()
                    vc.tableView.reloadData()
                    vc.viewDidLoad()
                    let va  = firstVC.children[1] as! AvBenViewController
                    va.loadAvBenInfoFromModule()
                    va.tableView1.reloadData()
                    va.viewDidLoad()

                }
            }
            dismiss(animated: true, completion: nil)
        }
    }


    // MARK: - Server Module

    func postNewUsBenToModule(){

        serverModule.postNewUsBenToAPI(benefitId: (String(benefitInfoDictArray["id"] as! Int)))
    }
    
    override func viewDidLoad() {
        buyB.layer.cornerRadius = 11
        downloadContr.layer.cornerRadius = 11
        super.viewDidLoad()
        
        titl.text=benefitInfoDictArray["title"] as? String
        rating.text = String(benefitInfoDictArray["rating"] as! Float)
        descr.text = benefitInfoDictArray["description"] as? String
        name.text = userInfoDictArray["name"] as? String
        secondname.text = userInfoDictArray["secondname"] as? String
        lastname.text = userInfoDictArray["lastname"] as? String
        phone.text = userInfoDictArray["phone"] as? String
        contract.text = userInfoDictArray["contract"] as? String
        price.text = String(benefitInfoDictArray["price"] as! Float)
    }
}
