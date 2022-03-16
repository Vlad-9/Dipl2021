

import UIKit
import Alamofire

class TransactionViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var transactionArray: [[String:Any]] = []

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Table View Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "transCell", for: indexPath) as! TransactionTableViewCell
        cell.benefitName.text = transactionArray[indexPath.row]["description"] as? String

        var date = transactionArray[indexPath.row]["date"] as! String
        date  = date.components(separatedBy: "T")[0]
        cell.transactionDate.text = date
        let sum = ( transactionArray[indexPath.row]["sum"] as! Float) * -1
        cell.transactionSum.text = String(sum)

        if sum > 0 {
            cell.transactionSum.textColor = UIColor.green
        } else {
            cell.transactionSum.textColor = UIColor.red
        }

        return cell
    }
    
    // MARK: - Server Module

    func loadTransactionInfoFromModule(){
        serverModule.loadTransactionInfoFromAPI {
            (transaction) in
            self.transactionArray = transaction!
            self.tableView.reloadData()
        }
    }

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        loadTransactionInfoFromModule()

        super.viewDidLoad()

    }
}
