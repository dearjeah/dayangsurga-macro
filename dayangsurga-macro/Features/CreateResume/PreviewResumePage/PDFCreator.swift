//
//  PDFCreator.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 31/10/21.
//

import UIKit
import PDFKit

class PDFCreator: NSObject{
    let dataInput: String
    var userResume: User_Resume?
    init(dataInput: String, userResume: User_Resume?) {
        self.dataInput = dataInput
        self.userResume = userResume
    }
    
    func createFlyer() -> Data {
      // 1
      let pdfMetaData = [
        kCGPDFContextCreator: "Resume Creator",
        kCGPDFContextAuthor: "Dayang Surga",
        kCGPDFContextTitle: dataInput
      ]
      let format = UIGraphicsPDFRendererFormat()
      format.documentInfo = pdfMetaData as [String: Any]

      // 2
      let pageWidth = 8.3 * 72.0
      let pageHeight = 11.7 * 72.0
      let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

      // 3
      let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
      // 4
      let data = renderer.pdfData { (context) in
        // 5
        context.beginPage()
//        // 6
        let titleBottom = addTitle(pageRect: pageRect)
        addBodyText(pageRect: pageRect, textTop:titleBottom + 36.0)
        
      }

      return data
    }
    
    func addTitle(pageRect: CGRect)->CGFloat{
        let titleFont = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        let fontColor = UIColor.white
        let titleAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: titleFont, NSAttributedString.Key.strokeColor: fontColor]
        let attributedTitle = NSAttributedString(
            string: dataInput,
            attributes: titleAttribute)
        let titlesStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: (pageRect.width-titlesStringSize.width)/2.0,
            y: 36,
            width: titlesStringSize.width,
            height: titlesStringSize.height
      )
      attributedTitle.draw(in: titleStringRect)
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addBodyText(pageRect: CGRect, textTop:CGFloat){
      let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .natural
      paragraphStyle.lineBreakMode = .byWordWrapping
      
      let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: textFont, NSAttributedString.Key.paragraphStyle: paragraphStyle]
      
      let attributedText = NSAttributedString(
      string: dataInput, attributes: textAttributes)
      let textRect = CGRect(
        x:10,
        y: textTop,
        width: pageRect.width - 20,
        height: pageRect.height - textTop - pageRect.height / 5.0)
      
      attributedText.draw(in: textRect)
    }
}
