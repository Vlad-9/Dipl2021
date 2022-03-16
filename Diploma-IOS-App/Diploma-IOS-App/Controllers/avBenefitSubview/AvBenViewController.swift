import UIKit
import Alamofire

class AvBenViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var avBenifitDictArray: [[String:Any]] = []
    var userInfo: [[String:Any]] = []

    @IBOutlet weak var tableView1: UITableView!

    // MARK: - Tableview Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avBenifitDictArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "avCell") as? AvBenTableViewCell
        cell!.name.text=avBenifitDictArray[indexPath.row]["title"] as? String
        cell!.price.text=String(avBenifitDictArray[indexPath.row]["price"] as! Float)
        cell!.userbalance = 0.0//userInfo[0]["balance"] as? Float ?? 0.0
        cell!.rating.text = String(avBenifitDictArray[indexPath.row]["rating"] as! Float)

        if ((userInfo[0]["balance"] as! Float) < (avBenifitDictArray[indexPath.row]["price"] as! Float)) {
            cell!.price.backgroundColor = UIColor.red
        } 
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        _ = indexPath.row
    }

    // MARK: - Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "buyBenefit",  let destination = segue.destination as? BuyBenefitViewController,

           let bIndex = tableView1.indexPathForSelectedRow?.row{
            destination.benefitInfoDictArray = avBenifitDictArray[bIndex]
            destination.userInfoDictArray = userInfo[0]

        }
    }

    // MARK: - ServerModule
    func loadAvBenInfoFromModule(){
        
        serverModule.loadUserInfoFromAPI() {
            (user) in
            self.userInfo = user!
        }

        serverModule.loadAvBenInfoFromAPI() {
            (benefit) in
            self.avBenifitDictArray = benefit!
            self.tableView1.reloadData()
        }
    }
    
    override func viewDidLoad() {

        tableView1.delegate = self
        tableView1.dataSource = self
        loadAvBenInfoFromModule()
        super.viewDidLoad()

    }
}
