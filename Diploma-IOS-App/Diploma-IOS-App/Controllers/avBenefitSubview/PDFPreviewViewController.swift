import UIKit
import PDFKit

class PDFPreviewViewController: UIViewController {
  public var documentData: Data?


    @IBOutlet weak var pdfVie: PDFView!
    override func viewDidLoad() {
    super.viewDidLoad()
print (documentData)
    if let data = documentData {
      pdfVie.document = PDFDocument(data: data)
      pdfVie.autoScales = true
    }
  }
}
