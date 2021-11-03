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
    
    init(dataInput: String) {
        self.dataInput = dataInput
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
      let pageRect = CGRect(x: 0, y: 0, width: 595, height: 842)

      // 3
      let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
      // 4
      let data = renderer.pdfData { (context) in
        // 5
        context.beginPage()
        let drawContext = context.cgContext
        // 6
//        let titleBottom = addTitle(pageRect: pageRect)
//        drawSeparator(drawContext, pageRect: pageRect, height: 10.0)
//        addBodyText(pageRect: pageRect, textTop:titleBottom + 36.0)
        
      }

      return data
    }
    
    func addTitle(pageRect: CGRect)->CGFloat{
        // Initialize Font & attributes of font
        let titleFont = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        let titleAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: dataInput,
            attributes: titleAttribute)
        let titlesStringSize = attributedTitle.size()
        
        // Set Rect for text
        let titleStringRect = CGRect(
            x: (pageRect.width-titlesStringSize.width)/2.0,
            y: 36,
            width: titlesStringSize.width,
            height: titlesStringSize.height
      )
        // Draw title in PDF
      attributedTitle.draw(in: titleStringRect)
        
        //Return new coordinates
      return titleStringRect.origin.y + titleStringRect.size.height + 4.0
    }
    
    func addHeader(pageRect: CGRect, headerTop:CGFloat)->CGFloat{
        let headerFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let headerAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: headerFont]
        let attributedHeader = NSAttributedString(string: dataInput, attributes: headerAttribute)
        
        let headerRect = CGRect(x: 20, y: headerTop, width: attributedHeader.size().width, height: attributedHeader.size().height)
        
        attributedHeader.draw(in: headerRect)
        return headerRect.origin.y + headerRect.height + 4.0
    }
    
    func addPeriodText(pageRect: CGRect, textTop: CGFloat){
        let periodFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let periodAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: periodFont]
        
        let attributedPeriod = NSAttributedString(string: dataInput, attributes: periodAttribute)
        let periodRect = CGRect(
            x: pageRect.width - attributedPeriod.size().width - 20,
            y: textTop,
            width: attributedPeriod.size().width,
            height: attributedPeriod.size().height
        )
        
        attributedPeriod.draw(in: periodRect)
    }
    
    func addBodyText(pageRect: CGRect, textTop: CGFloat)->CGFloat{
        let bodyFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let bodyAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: bodyFont]
        
        let attributedBody = NSAttributedString(string: dataInput, attributes: bodyAttribute)
        
        let bodyRect = CGRect(x: 20, y: textTop, width: attributedBody.size().width, height: attributedBody.size().height)
        
        attributedBody.draw(in: bodyRect)
        return bodyRect.origin.y + bodyRect.height + 4.0
    }
    
    func addParagraphText(pageRect: CGRect, textTop:CGFloat)->CGFloat{
        let paragraphFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
          
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
          
        let paragraphAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: [paragraphFont], NSAttributedString.Key.paragraphStyle: paragraphStyle]
          
        let attributedParagraph = NSAttributedString(
        string: dataInput, attributes: paragraphAttribute)
        let paragraphRect = CGRect(x:10, y: textTop, width: pageRect.width - 20, height: attributedParagraph.size().height)
          
        attributedParagraph.draw(in: paragraphRect)
        return paragraphRect.origin.y + paragraphRect.height + 4.0
    }
    
    func drawSeparator(_ drawSeparator: CGContext, pageRect: CGRect, height: CGFloat)->CGFloat{
        // Save CG State
        drawSeparator.saveGState()
        
        // Set Line width & color
        drawSeparator.setLineWidth(0.8)
        drawSeparator.setStrokeColor(UIColor.darkGray.cgColor)
        
        // Set separator coordinates & draw line
        drawSeparator.move(to: CGPoint(x: 20, y: height))
        drawSeparator.addLine(to: CGPoint(x: pageRect.width-20, y: height))
        drawSeparator.strokePath()
        
        // Restore CG State
        drawSeparator.restoreGState()
        
        return height + 4.0
    }
    
}
