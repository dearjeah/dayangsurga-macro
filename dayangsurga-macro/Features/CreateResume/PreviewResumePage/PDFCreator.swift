//
//  PDFCreator.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 31/10/21.
//

import UIKit
import PDFKit
import CoreMedia

class PDFCreator: NSObject{
    let dataInput: String
        var userResume: User_Resume?
    init(dataInput: String, userResume: User_Resume?) {
        self.dataInput = dataInput
                self.userResume = userResume
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
            var sectionBottom = addTitleSection(pageRect: pageRect, title: "Meme Amelia", drawContext: drawContext, context: context)
            sectionBottom = addSummarySection(pageRect: pageRect, currentPosition: sectionBottom, drawContext: drawContext, context: context)
            sectionBottom = addExperienceSection(pageRect: pageRect, drawContext: drawContext, startPosition: sectionBottom, context: context)
            sectionBottom = addEducationSection(pageRect: pageRect, startPosition: sectionBottom, drawContext: drawContext, context: context)
            sectionBottom = addSkillSection(pageRect: pageRect, drawContext: drawContext, startPosition: sectionBottom, context: context)
            sectionBottom = addAccomplishmentSection(pageRect: pageRect, drawContext: drawContext, startPosition: sectionBottom, context: context)
        }
        return data
    }
    
    func addTitleSection(pageRect: CGRect, title: String, drawContext: CGContext, context: UIGraphicsPDFRendererContext)->CGFloat{
        let titleBottom = addTitle(pageRect: pageRect, text: title, context: context)
        let sectionBottom = addPersonalInformation(pageRect: pageRect, startPosition: titleBottom, text: "081211223344|meme123@gmail.com|Tangerang, Indonesia", context: context)
    
        
        return sectionBottom + 12.0
    }
    
    func addSummarySection(pageRect: CGRect,currentPosition: CGFloat, drawContext: CGContext, context:UIGraphicsPDFRendererContext)->CGFloat{
        let headerBottom = addHeader(pageRect: pageRect, headerTop: currentPosition, text: "Summary", context: context)
        let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
        let contentBottom = addParagraphText(pageRect: pageRect, textTop: separatorBottom, text: "Highly capable Product manager with 1+ year(s) of experience in managing various projects,seeking to apply strategic planning to grow revenue and market share", context: context)
        
        return contentBottom + 4.0
    }
    
    func addEducationSection(pageRect: CGRect,startPosition: CGFloat, drawContext: CGContext, context: UIGraphicsPDFRendererContext)->CGFloat{
        var sectionBottom: CGFloat = 0.0
        let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Education", context: context)
        let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
        for index in 0...2{
            if index == 0{
                sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: separatorBottom, text: "DS University", context: context)
            }else{
                sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: sectionBottom, text: "Dayang Surga University", context: context)
            }
            addPeriodText(pageRect: pageRect, textTop: sectionBottom, text: "2014-2018", context: context)
            sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "Bachelor of Economics", context: context)
            sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "GPA 3.50", context: context)
            sectionBottom = addParagraphText(pageRect: pageRect, textTop: sectionBottom, text: "She sells sea shells by the sea shore\nUlar besar melingkar lingkar diatas pagar", context: context)
        }
            return sectionBottom + 4.0
        }
    
        func addExperienceSection(pageRect: CGRect, drawContext: CGContext, startPosition: CGFloat, context:UIGraphicsPDFRendererContext)-> CGFloat{
            //Check if empty
            var sectionBottom:CGFloat = 0.0
            let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Experience", context: context)
            let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
            for index in 0...2{
                if index == 0{
                    sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: separatorBottom, text: "PT. Aga Aga", context: context)
                }else{
                    sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: sectionBottom, text: "PT. Dayang Surga", context: context)
                }
                addPeriodText(pageRect: pageRect, textTop: sectionBottom, text: "2018-2020", context: context)
                sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "Project Manager", context: context)
                sectionBottom = addParagraphText(pageRect: pageRect, textTop: sectionBottom, text: "Handled various projects\nTook part in supervising 5 major projects with various partners", context: context)
            }
            
            return sectionBottom + 4.0
        }
    
        func addAccomplishmentSection(pageRect:CGRect, drawContext: CGContext, startPosition: CGFloat, context: UIGraphicsPDFRendererContext)-> CGFloat{
            let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Accomplishment", context: context)
            let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
            var sectionBottom: CGFloat = 0.0
            for index in 0...2{
                if index == 0{
                    sectionBottom = addBodyText(pageRect: pageRect, textTop: separatorBottom, text: "Swift Certification", context: context)
                }else{
                    sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "Google Languange Certification", context: context)
                }
            }
            return sectionBottom + 4.0
            
        }
        
        func addSkillSection(pageRect: CGRect, drawContext: CGContext, startPosition: CGFloat, context: UIGraphicsPDFRendererContext)->CGFloat{
            var sectionBottom: CGFloat = 0.0
            let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Technical Skills", context: context)
            let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
            for index in 0...2{
                if index == 0{
                    sectionBottom = addBodyText(pageRect: pageRect, textTop: separatorBottom, text: "Sketch, Figma", context: context)
                }else{
                    sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "Swift, Java, C++", context: context)
                }
            }
            
            return sectionBottom + 4.0
        }
        
    func addTitle(pageRect: CGRect, text: String, context: UIGraphicsPDFRendererContext)->CGFloat{
            // Initialize Font & attributes of font
        let titleFont = UIFont(name: "Georgia", size: 18.0)
//        UIFont.systemFont(ofSize: 18.0, weight: .bold)
        let titleAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: titleFont ?? UIFont.systemFont(ofSize: 18.0, weight: .bold)]
            let attributedTitle = NSAttributedString(
                string: text,
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
        
        func addPersonalInformation(pageRect: CGRect, startPosition:CGFloat, text: String, context: UIGraphicsPDFRendererContext)->CGFloat{
            let personalInfoFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
            let personalInfoAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: personalInfoFont]
            let attributedInfo = NSAttributedString(string: text, attributes: personalInfoAttribute)
            
            var infoRect: CGRect
            
            if startPosition + attributedInfo.size().height <= 822{
                infoRect = CGRect(x: (pageRect.width-attributedInfo.size().width)/2.0, y: startPosition, width: attributedInfo.size().width, height: attributedInfo.size().height)
            }else{
                context.beginPage()
                infoRect = CGRect(x: (pageRect.width-attributedInfo.size().width)/2.0, y: 20, width: attributedInfo.size().width, height: attributedInfo.size().height)
            }
            
            attributedInfo.draw(in: infoRect)
            
            return infoRect.origin.y + infoRect.height + 4.0
        }
    
        func addHeader(pageRect: CGRect, headerTop:CGFloat, text: String, context: UIGraphicsPDFRendererContext)->CGFloat{
            let headerFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
            let headerAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: headerFont]
            let attributedHeader = NSAttributedString(string: text, attributes: headerAttribute)
            
            var headerRect: CGRect
            print(UIFont.familyNames)
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
            let attributedInstitution = NSAttributedString(string: text, attributes: institutionAttribute)
            
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
            
            let attributedPeriod = NSAttributedString(string: text, attributes: periodAttribute)
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
            
            let attributedBody = NSAttributedString(string: text, attributes: bodyAttribute)
            
            var bodyRect: CGRect
        
            if textTop + attributedBody.size().height <= 822{
                bodyRect = CGRect(x: 20, y: textTop, width: attributedBody.size().width, height: attributedBody.size().height)
            }else{
                context.beginPage()
                bodyRect = CGRect(x: 20, y: 20, width: attributedBody.size().width, height: attributedBody.size().height)
            }
            
            attributedBody.draw(in: bodyRect)
            
            return bodyRect.origin.y + bodyRect.height + 4.0
        }
        
        func addParagraphText(pageRect: CGRect, textTop:CGFloat,text: String, context: UIGraphicsPDFRendererContext)->CGFloat{
            let paragraphFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            let paragraphAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: paragraphFont, NSAttributedString.Key.paragraphStyle: paragraphStyle]
            
            let attributedParagraph = NSAttributedString(
                string: text, attributes: paragraphAttribute)
            var paragraphRect: CGRect
            
            if textTop + attributedParagraph.size().height <= 822{
                paragraphRect = CGRect(x:20, y: textTop, width: pageRect.width - 25, height:  round(attributedParagraph.size().width / pageRect.width) * attributedParagraph.size().height)
            }else{
                context.beginPage()
                paragraphRect = CGRect(x:20, y: 20, width: pageRect.width - 25, height:  round(round(attributedParagraph.size().width / pageRect.width) + 1) * attributedParagraph.size().height)
            }
          
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
