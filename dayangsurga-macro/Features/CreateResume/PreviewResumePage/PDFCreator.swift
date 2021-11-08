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
//    let userResume: User_Resume?
    init(dataInput: String) {
        self.dataInput = dataInput
//        self.userResume = userResume
    }
    
    func createPDF() -> Data {
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
        var sectionBottom = addTitle(pageRect: pageRect, context: context)
          sectionBottom = addEducationSection(pageRect: pageRect, startPosition: sectionBottom, drawContext: drawContext, context: context)
          sectionBottom = addExperienceSection(pageRect: pageRect, drawContext: drawContext, startPosition: sectionBottom, context: context)
          sectionBottom = addAccomplishmentSection(pageRect: pageRect, drawContext: drawContext, startPosition: sectionBottom, context: context)
          sectionBottom = addSkillSection(pageRect: pageRect, drawContext: drawContext, startPosition: sectionBottom, context: context)
      }

      return data
    }
    
    func addTitle(pageRect: CGRect, title: String, drawContext: CGContext, context: UIGraphicsPDFRendererContext)->CGFloat{
        let titleBottom = addTitle(pageRect: pageRect, context: context)
        let infoBottom = addHeader(pageRect: pageRect, headerTop: titleBottom, text: "", context: context)
        let currentHeight = drawSeparator(drawContext, pageRect: pageRect, height: infoBottom)
        
        return currentHeight + 4.0
    }
    
    func addEducationSection(pageRect: CGRect,startPosition: CGFloat, drawContext: CGContext, context: UIGraphicsPDFRendererContext)->CGFloat{
        var sectionBottom: CGFloat = 0.0
        // Check if empty
        let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Education", context: context)
        let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
        for index in 0...3{
            if index == 0{
                sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: separatorBottom, text: "", context: context)
            }else{
                sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: sectionBottom, text: "", context: context)
            }
            addPeriodText(pageRect: pageRect, textTop: sectionBottom, text: "", context: context)
            sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "", context: context)
            sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "", context: context)
            sectionBottom = addParagraphText(pageRect: pageRect, textTop: sectionBottom, text: "", context: context)
            }
        
        return sectionBottom + 4.0
    }
    func addExperienceSection(pageRect: CGRect, drawContext: CGContext, startPosition: CGFloat, context:UIGraphicsPDFRendererContext)-> CGFloat{
        //Check if empty
        var sectionBottom:CGFloat = 0.0
        let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Experience", context: context)
        let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
        for index in 0...3{
            if index == 0{
                sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: separatorBottom, text: "", context: context)
            }else{
                sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: sectionBottom, text: "", context: context)
            }
            sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: sectionBottom, text: "", context: context)
            addPeriodText(pageRect: pageRect, textTop: sectionBottom, text: "", context: context)
            sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "", context: context)
            sectionBottom = addParagraphText(pageRect: pageRect, textTop: sectionBottom, text: "", context: context)
            }
        
        return sectionBottom + 4.0
    }
    func addAccomplishmentSection(pageRect:CGRect, drawContext: CGContext, startPosition: CGFloat, context: UIGraphicsPDFRendererContext)-> CGFloat{
        var sectionBottom: CGFloat = 0.0
        let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Accomplishment", context: context)
        let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
        for index in 0...3{
            if index == 0{
                addPeriodText(pageRect: pageRect, textTop: separatorBottom, text: "", context: context)
                sectionBottom = addBodyText(pageRect: pageRect, textTop: separatorBottom, text: "", context: context)
            }else{
                addPeriodText(pageRect: pageRect, textTop: sectionBottom, text: "", context: context)
                sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "", context: context)
            }
            sectionBottom = addParagraphText(pageRect: pageRect, textTop: sectionBottom, text: "", context: context)
            }
        
        return sectionBottom + 4.0
        
    }
    
    func addSkillSection(pageRect: CGRect, drawContext: CGContext, startPosition: CGFloat, context: UIGraphicsPDFRendererContext)->CGFloat{
        var sectionBottom: CGFloat = 0.0
        let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Technical Skills", context: context)
        let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
        for index in 0...3{
            if index == 0{
                sectionBottom = addBodyText(pageRect: pageRect, textTop: separatorBottom, text: "", context: context)
            }else{
                sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "", context: context)
            }
        }
        
        return 0
    }
    
    func addTitle(pageRect: CGRect, context: UIGraphicsPDFRendererContext)->CGFloat{
        // Initialize Font & attributes of font
        let titleFont = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        let titleAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: titleFont]
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

        //Return new coordinates
      return titleStringRect.origin.y + titleStringRect.size.height + 4.0
    }
    
    func addHeader(pageRect: CGRect, headerTop:CGFloat, text: String, context: UIGraphicsPDFRendererContext)->CGFloat{
        let headerFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let headerAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: headerFont]
        let attributedHeader = NSAttributedString(string: dataInput, attributes: headerAttribute)
        
        var headerRect: CGRect
        
        if headerTop + attributedHeader.size().height <= 822{
             headerRect = CGRect(x: (pageRect.width-attributedHeader.size().width)/2.0, y: headerTop, width: attributedHeader.size().width, height: attributedHeader.size().height)
        }else{
            context.beginPage()
            headerRect = CGRect(x: (pageRect.width-attributedHeader.size().width)/2.0, y: 20, width: attributedHeader.size().width, height: attributedHeader.size().height)
        }
        
        attributedHeader.draw(in: headerRect)
        
        return headerRect.origin.y + headerRect.height + 4.0
    }
    
    func addInstitutionText(pageRect: CGRect, institutionTop: CGFloat,text: String, context: UIGraphicsPDFRendererContext)->CGFloat{
        let institutionFont = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        var institutionRect: CGRect
        let institutionAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: institutionFont]
        let attributedInstitution = NSAttributedString(string: dataInput, attributes: institutionAttribute)
        
        if attributedInstitution.size().height <= 822{
             institutionRect = CGRect(x: 20, y: institutionTop, width: attributedInstitution.size().width, height: attributedInstitution.size().height)
        }else{
            context.beginPage()
            institutionRect = CGRect(x: 20, y: 20, width: attributedInstitution.size().width, height: attributedInstitution.size().height)
        }
        
        attributedInstitution.draw(in: institutionRect)
        
        return institutionRect.origin.y + institutionRect.height + 4.0
    }
    
    func addPeriodText(pageRect: CGRect, textTop: CGFloat, text: String, context: UIGraphicsPDFRendererContext){
        let periodFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let periodAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: periodFont]
        
        let attributedPeriod = NSAttributedString(string: dataInput, attributes: periodAttribute)
        let periodRect = CGRect(
            x: pageRect.width - attributedPeriod.size().width - 20,
            y: textTop,
            width: attributedPeriod.size().width,
            height: attributedPeriod.size().height
        )
        //check height add if-> check siapa yang dipanggil sebelum dia, adjust code
        attributedPeriod.draw(in: periodRect)
    }
    
    func addBodyText(pageRect: CGRect, textTop: CGFloat, text: String, context: UIGraphicsPDFRendererContext)->CGFloat{
        let bodyFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let bodyAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: bodyFont]
        
        let attributedBody = NSAttributedString(string: dataInput, attributes: bodyAttribute)
        
        let bodyRect = CGRect(x: 20, y: textTop, width: attributedBody.size().width, height: attributedBody.size().height)
        //check height add if
        attributedBody.draw(in: bodyRect)
        return bodyRect.origin.y + bodyRect.height + 4.0
    }
    
    func addParagraphText(pageRect: CGRect, textTop:CGFloat, text: String, context: UIGraphicsPDFRendererContext)->CGFloat{
        let paragraphFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
          
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
          
        let paragraphAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: [paragraphFont], NSAttributedString.Key.paragraphStyle: paragraphStyle]
          
        let attributedParagraph = NSAttributedString(
        string: dataInput, attributes: paragraphAttribute)
        let paragraphRect = CGRect(x:10, y: textTop, width: pageRect.width - 20, height: attributedParagraph.size().height)
        //check height add if
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
