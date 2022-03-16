import UIKit
import Alamofire

class BenViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var userBenefitdDictArray: [[String:Any]] = []
    let segueIdentifier = "showMyBenefit"

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Table View Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userBenefitdDictArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var date = userBenefitdDictArray[indexPath.row]["dateEnd"] as! String
        date  = date.components(separatedBy: "T")[0]

        let cell = tableView.dequeueReusableCell(withIdentifier: "benCell")  as? BenTableViewCell
        cell!.descr.text=date
        cell!.nameLabel.text=userBenefitdDictArray[indexPath.row]["description"] as? String

        return cell!

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if  segue.identifier == segueIdentifier,

            let destination = segue.destination as? MyBenefitViewController,

            let blogIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.blogName = "Name"
            destination.userBenifitDictArray = userBenefitdDictArray[blogIndex]
        }
    }

    // MARK: - Server Module
    
    func loadUsBenInfoFromModule(){
        serverModule.loadUsBenInfoFromAPI {
            (user) in
            self.userBenefitdDictArray = user!
            self.tableView.reloadData()

        }
    }

    override func viewDidLoad() {

        tableView.delegate = self
        tableView.dataSource = self

        super.viewDidLoad()

        loadUsBenInfoFromModule()
    }
}
