

import UIKit

class MyBenefitViewController: UIViewController {

    var params = ["rating": 0.0]
    let starRatingView = StarRatingView(frame: CGRect(origin: .zero, size: CGSize(width: 250, height: 50)), rating: 4.5, color: UIColor.systemOrange, starRounding: .roundToHalfStar)

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var dateEnd: UILabel!
    @IBOutlet weak var dateStart: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var download: UIButton!
    @IBOutlet weak var rate: UIButton!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var starRate: StarRatingView! = StarRatingView(frame: CGRect(origin: .zero, size: CGSize(width: 250, height: 50)), rating: 4.5, color: UIColor.systemOrange, starRounding: .roundToHalfStar)


    @IBAction func downloadDoc(_ sender: UIButton) {
        guard

          let body = name.text
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
          title: "Заявление на оказание социальной выплаты",
            body: "\(String(dateStart.text!))\n\(String(name.text!))\nОстальные элементы заявления"
        )
        let pdfData = pdfCreator.createFlyer()
        let vc = UIActivityViewController(
          activityItems: [pdfData],
          applicationActivities: []
        )
        present(vc, animated: true, completion: nil)
    }
    @IBOutlet weak var rateB: UIButton!
    @IBAction func rate(_ sender: UIButton) {
        params.updateValue(Double(starRate.rating), forKey: "rating")
        print (starRate.rating)
        postNewBenefitRatingToServerModule()
    }

    public enum StarRoundingd: Int {
        case roundToHalfStar = 0
        case ceilToHalfStar = 1
        case floorToHalfStar = 2
        case roundToFullStar = 3
        case ceilToFullStar = 4
        case floorToFullStar = 5
    }

    var userBenifitDictArray: [String:Any] = [:]
    var blogName = String()

    func postNewBenefitRatingToServerModule(){

        serverModule.postNewBenefitFeedbackToAPI(params: params, benId: userBenifitDictArray["benefitId"] as! Int) {
            (rating) in
        }
    }

    func getBenefitInfoFromServerModule(){
        serverModule.loadBenefitInfoFromAPI(benefitId:  userBenifitDictArray["benefitId"] as! Int) {
            (transaction) in

            let rating  = String(transaction!["rating"] as! Float)
            self.ratingLabel.text = rating
            self.name.text = transaction!["title"] as? String
            self.descriptionLabel.text = transaction!["description"] as? String

        }
    }

    override func viewDidLoad() {
        download.layer.cornerRadius = 11
        rate.layer.cornerRadius = 11
        super.viewDidLoad()

        getBenefitInfoFromServerModule()

        var dateS = userBenifitDictArray["dateStart"] as! String
        dateS  = dateS.components(separatedBy: "T")[0]
        dateStart.text = dateS

        var dateE = userBenifitDictArray["dateEnd"] as! String
        dateE  = dateE.components(separatedBy: "T")[0]
        dateEnd.text = dateE

        name.text=userBenifitDictArray["description"] as? String
        status.text=userBenifitDictArray["status"] as? String

    }
}
