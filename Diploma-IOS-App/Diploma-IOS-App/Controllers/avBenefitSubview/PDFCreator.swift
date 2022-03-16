import UIKit
import PDFKit

class PDFCreator: NSObject {
  let title: String
  let body: String


  init(title: String, body: String) {
    self.title = title
    self.body = body
  }
  func addTitle(pageRect: CGRect) -> CGFloat {
    // 1
    let titleFont = UIFont.systemFont(ofSize: 18.0, weight: .bold)
    // 2
    let titleAttributes: [NSAttributedString.Key: Any] =
      [NSAttributedString.Key.font: titleFont]
    // 3
    let attributedTitle = NSAttributedString(
      string: title,
      attributes: titleAttributes
    )
    // 4
    let titleStringSize = attributedTitle.size()
    // 5
    let titleStringRect = CGRect(
      x: (pageRect.width - titleStringSize.width) / 2.0,
      y: 36,
      width: titleStringSize.width,
      height: titleStringSize.height
    )
    // 6
    attributedTitle.draw(in: titleStringRect)
    // 7
    return titleStringRect.origin.y + titleStringRect.size.height
  }
  func addBodyText(pageRect: CGRect, textTop: CGFloat) {
    let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    // 1
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .natural
    paragraphStyle.lineBreakMode = .byWordWrapping
    // 2
    let textAttributes = [
      NSAttributedString.Key.paragraphStyle: paragraphStyle,
      NSAttributedString.Key.font: textFont
    ]
    let attributedText = NSAttributedString(
      string: body,
      attributes: textAttributes
    )
    // 3
    let textRect = CGRect(
      x: 10,
      y: textTop,
      width: pageRect.width - 20,
      height: pageRect.height - textTop - pageRect.height / 5.0
    )
    attributedText.draw(in: textRect)
  }
func createFlyer() -> Data {
  // 1
  let pdfMetaData = [
    kCGPDFContextCreator: "GPN",
    kCGPDFContextAuthor: "GPN.com"
  ]
  let format = UIGraphicsPDFRendererFormat()
  format.documentInfo = pdfMetaData as [String: Any]

  // 2
  let pageWidth = 8.5 * 72.0
  let pageHeight = 11 * 72.0
  let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

  // 3
  let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
  // 4
  let data = renderer.pdfData { (context) in
    // 5
    context.beginPage()
    // 6
    let attributes = [
      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 72)
    ]

    let titleBottom = addTitle(pageRect: pageRect)
    addBodyText(pageRect: pageRect, textTop: titleBottom + 36.0)
  }

  return data
}
}
