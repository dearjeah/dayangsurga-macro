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
            var sectionBottom = addTitleSection(pageRect: pageRect, title: "Olivia Dwi Susanti", drawContext: drawContext, context: context)
            sectionBottom = addSummarySection(pageRect: pageRect, currentPosition: sectionBottom, drawContext: drawContext, context: context)
            sectionBottom = addExperienceSection(pageRect: pageRect, drawContext: drawContext, startPosition: sectionBottom, context: context)
            sectionBottom = addEducationSection(pageRect: pageRect, startPosition: sectionBottom, drawContext: drawContext, context: context)
            sectionBottom = addSkillSection(pageRect: pageRect, drawContext: drawContext, startPosition: sectionBottom, context: context)
            sectionBottom = addAccomplishmentSection(pageRect: pageRect, drawContext: drawContext, startPosition: sectionBottom, context: context)
        }
        return data
    }
    
    func addTitleSection(pageRect: CGRect, title: String, drawContext: CGContext, context: UIGraphicsPDFRendererContext)->CGFloat{
        let titleBottom = addTitle(pageRect: pageRect, text: title, context: context, template: 1)
        let sectionBottom = addPersonalInformation(pageRect: pageRect, startPosition: titleBottom, text: "082136123123 | oliviadwisusanti@gmail.com | Tangerang, Indonesia", context: context, template: 1)
    
        
        return sectionBottom + 12.0
    }
    
    func addSummarySection(pageRect: CGRect,currentPosition: CGFloat, drawContext: CGContext, context:UIGraphicsPDFRendererContext)->CGFloat{
        let headerBottom = addHeader(pageRect: pageRect, headerTop: currentPosition, text: "Summary", context: context, template: 1)
        let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
        let contentBottom = addParagraphText(pageRect: pageRect, textTop: separatorBottom, text: "I'm a fersh graduate of BINUS University major on Management Undergraduate Student (specialization on E-Business). I have ability to work in a team or independent and fast learning.", context: context, template: 1)
        
        return contentBottom + 4.0
    }
    
    func addEducationSection(pageRect: CGRect,startPosition: CGFloat, drawContext: CGContext, context: UIGraphicsPDFRendererContext)->CGFloat{
        var sectionBottom: CGFloat = 0.0
        let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Education", context: context, template: 1)
        let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
        for index in 0...0{
            if index == 0{
                sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: separatorBottom, text: "BINUS University", context: context, template: 1)
            }else{
                sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: sectionBottom, text: "Dayang Surga University", context: context, template: 1)
            }
            addPeriodText(pageRect: pageRect, textTop: sectionBottom, text: "2017 - 2021", context: context, template: 1)
            sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "Bachelor of Economics", context: context, template: 1)
            sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "GPA 3.99", context: context, template: 1)
            sectionBottom = addParagraphText(pageRect: pageRect, textTop: sectionBottom, text: "Actively partook in extracurricular activities (SPV of Academic Departement at HIMME BINUS)\nBecame a mentor and taught newly admitted university students", context: context, template: 1)
        }
            return sectionBottom + 4.0
        }
    
        func addExperienceSection(pageRect: CGRect, drawContext: CGContext, startPosition: CGFloat, context:UIGraphicsPDFRendererContext)-> CGFloat{
            //Check if empty
            var sectionBottom:CGFloat = 0.0
            let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Experience", context: context, template: 1)
            let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
            for index in 0...0{
                if index == 0{
                    sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: separatorBottom, text: "Apple Developer Academy @ BINUS", context: context, template: 1)
                }else{
                    sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: sectionBottom, text: "PT. Dayang Surga", context: context, template: 1)
                }
                addPeriodText(pageRect: pageRect, textTop: sectionBottom, text: "February 2021- Present", context: context, template: 1)
                sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "iOS Developer", context: context, template: 1)
                sectionBottom = addParagraphText(pageRect: pageRect, textTop: sectionBottom, text: "Developed application and implemented various frameworks including:\n1. Core Data\n2. Health Kit\n3. UIKit\nDesigned custom assets for applications", context: context, template: 1)
            }
            
            return sectionBottom + 4.0
        }
    
        func addAccomplishmentSection(pageRect:CGRect, drawContext: CGContext, startPosition: CGFloat, context: UIGraphicsPDFRendererContext)-> CGFloat{
            let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Accomplishment", context: context, template: 1)
            let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
            var sectionBottom: CGFloat = 0.0
            for index in 0...0{
                if index == 0{
                    sectionBottom = addBodyText(pageRect: pageRect, textTop: separatorBottom, text: "BINUS Mentor Scholarship 2020 - 2021", context: context, template: 1)
                }else{
                    sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "Google Languange Certification", context: context, template: 1)
                }
            }
            return sectionBottom + 4.0
            
        }
        
        func addSkillSection(pageRect: CGRect, drawContext: CGContext, startPosition: CGFloat, context: UIGraphicsPDFRendererContext)->CGFloat{
            var sectionBottom: CGFloat = 0.0
            let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Technical Skills", context: context, template: 1)
            let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
            for index in 0...0{
                if index == 0{
                    sectionBottom = addBodyText(pageRect: pageRect, textTop: separatorBottom, text: "Swift", context: context, template: 1)
                }else{
                    sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "Swift, Java, C++", context: context, template: 1)
                }
            }
            
            return sectionBottom + 4.0
        }
        
    func addTitle(pageRect: CGRect, text: String, context: UIGraphicsPDFRendererContext, template: Int)->CGFloat{
            // Initialize Font & attributes of font
        var titleFont: UIFont?
        if template == 0{
            titleFont = UIFont(name: "Arial-Bold", size: 18.0)
        }
        else if template == 1 {
           titleFont = UIFont(name: "Georgia-Bold", size: 18.0)
        }else{
            titleFont = UIFont(name: "Helvetica-Bold", size: 18.0)
        }

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
        
    func addPersonalInformation(pageRect: CGRect, startPosition:CGFloat, text: String, context: UIGraphicsPDFRendererContext, template: Int)->CGFloat{
            var personalInfoFont: UIFont?
            if template == 0{
                personalInfoFont = UIFont(name: "Arial", size: 12.0)
            }
            else if template == 1 {
                personalInfoFont = UIFont(name: "Georgia", size: 12.0)
            }else{
                personalInfoFont = UIFont(name: "Helvetica", size: 12.0)
            }
        
            let personalInfoAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: personalInfoFont ?? UIFont.systemFont(ofSize: 12.0, weight: .regular)]
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
    
    func addHeader(pageRect: CGRect, headerTop:CGFloat, text: String, context: UIGraphicsPDFRendererContext, template: Int)->CGFloat{
            var headerFont: UIFont?
            if template == 0{
                headerFont = UIFont(name: "Arial", size: 14.0)
            }
            else if template == 1 {
                headerFont = UIFont(name: "Georgia", size: 14.0)
            }else{
                headerFont = UIFont(name: "Helvetica", size: 14.0)
            }
        
          
            let headerAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: headerFont ?? UIFont.systemFont(ofSize: 14.0, weight: .regular)]
            let attributedHeader = NSAttributedString(string: text, attributes: headerAttribute)
            
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
        
    func addInstitutionText(pageRect: CGRect, institutionTop: CGFloat,text: String, context: UIGraphicsPDFRendererContext, template: Int)->CGFloat{
        var institutionFont: UIFont?
            if template == 0{
                institutionFont = UIFont(name: "Arial-Bold", size: 12.0)
            }
            else if template == 1 {
                institutionFont = UIFont(name: "Georgia-Bold", size: 12.0)
            }else{
                institutionFont = UIFont(name: "Helvetica-Bold", size: 12.0)
            }
            var institutionRect: CGRect
            let institutionAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: institutionFont ?? UIFont.systemFont(ofSize: 12.0, weight: .bold)]
        
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
        
    func addPeriodText(pageRect: CGRect, textTop: CGFloat, text: String, context: UIGraphicsPDFRendererContext, template: Int){
            var periodFont: UIFont?
                if template == 0{
                    periodFont = UIFont(name: "Arial", size: 12.0)
                }
                else if template == 1 {
                    periodFont = UIFont(name: "Georgia", size: 12.0)
                }else{
                    periodFont = UIFont(name: "Helvetica", size: 12.0)
                }

            let periodAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: periodFont ?? UIFont.systemFont(ofSize: 12.0, weight: .regular)]
            
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
        
    func addBodyText(pageRect: CGRect, textTop: CGFloat, text: String, context: UIGraphicsPDFRendererContext, template: Int)->CGFloat{
            var bodyFont: UIFont?
                if template == 0{
                    bodyFont = UIFont(name: "Arial", size: 12.0)
                }
                else if template == 1 {
                    bodyFont = UIFont(name: "Georgia", size: 12.0)
                }else{
                    bodyFont = UIFont(name: "Helvetica", size: 12.0)
                }
        
            let bodyAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: bodyFont ?? UIFont.systemFont(ofSize: 12.0, weight: .regular)]
            
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
        
    func addParagraphText(pageRect: CGRect, textTop:CGFloat,text: String, context: UIGraphicsPDFRendererContext, template: Int)->CGFloat{
            var paragraphFont: UIFont?
                if template == 0{
                    paragraphFont = UIFont(name: "Arial", size: 12.0)
                }
                else if template == 1 {
                    paragraphFont = UIFont(name: "Georgia", size: 12.0)
                }else{
                    paragraphFont = UIFont(name: "Helvetica", size: 12.0)
                }
            
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            let paragraphAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: paragraphFont ?? UIFont.systemFont(ofSize: 12.0, weight: .regular), NSAttributedString.Key.paragraphStyle: paragraphStyle]
            
            let attributedParagraph = NSAttributedString(
                string: text, attributes: paragraphAttribute)
            var paragraphRect: CGRect
            
            if textTop + attributedParagraph.size().height <= 822{
                paragraphRect = CGRect(x:20, y: textTop, width: pageRect.width - 25, height:  round(attributedParagraph.size().width / pageRect.width) * attributedParagraph.size().height + attributedParagraph.size().height)
            }else{
                context.beginPage()
                paragraphRect = CGRect(x:20, y: 20, width: pageRect.width - 25, height:  round(round(attributedParagraph.size().width / pageRect.width) ) * attributedParagraph.size().height + attributedParagraph.size().height)
            }
          
            attributedParagraph.draw(in: paragraphRect)
            
        return paragraphRect.origin.y + attributedParagraph.size().height + 15
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
