//
//  PDFCreator.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 31/10/21.
//

import UIKit
import PDFKit
import CoreMedia

class PDFCreator: NSObject {
    var userResume: User_Resume?
    var resumeContent = Resume_Content()
    var personalInfo = Personal_Info()
    var eduData = [Education]()
    var expData = [Experience]()
    var skillData = [Skills]()
    var accomData = [Accomplishment]()
    var selectedTemplate = Int()
    init(resumeContent: Resume_Content, userResume: User_Resume?, selectedTemplate: Int) {
        self.resumeContent = resumeContent
        self.userResume = userResume
        self.selectedTemplate = selectedTemplate
    }
    
    func createPDF() -> Data {
        getResumeContentData()
        personalInfo = PersonalInfoRepository.shared.getPersonalInfoById(id: resumeContent.personalInfo_id ?? "") ?? Personal_Info()
        let userName = personalInfo.fullName ?? ""
        let pdfMetaData = [
            kCGPDFContextCreator: "Resume Creator",
            kCGPDFContextAuthor: userResume?.personalInfo?.fullName,
            kCGPDFContextTitle: userResume?.name
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageRect = CGRect(x: 0, y: 0, width: 595, height: 842)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { (context) in
            context.beginPage()
            let drawContext = context.cgContext
            var sectionBottom = addTitleSection(pageRect: pageRect, title: userName, drawContext: drawContext, context: context)
            sectionBottom = addSummarySection(pageRect: pageRect, currentPosition: sectionBottom, drawContext: drawContext, context: context)
            sectionBottom = addExperienceSection(pageRect: pageRect, drawContext: drawContext, startPosition: sectionBottom, context: context)
            sectionBottom = addEducationSection(pageRect: pageRect, startPosition: sectionBottom, drawContext: drawContext, context: context)
            sectionBottom = addSkillSection(pageRect: pageRect, drawContext: drawContext, startPosition: sectionBottom, context: context)
            sectionBottom = addAccomplishmentSection(pageRect: pageRect, drawContext: drawContext, startPosition: sectionBottom, context: context)
        }
        return data
    }
    
    func generatePdfThumbnail(of thumbnailSize: CGSize , atPage pageIndex: Int, pdfData: Data) -> UIImage? {
        let pdfDocument = PDFDocument(data: pdfData)
        let pdfDocumentPage = pdfDocument?.page(at: pageIndex)
        return pdfDocumentPage?.thumbnail(of: thumbnailSize, for: PDFDisplayBox.trimBox)
    }
    
    func addTitleSection(pageRect: CGRect, title: String, drawContext: CGContext, context: UIGraphicsPDFRendererContext)->CGFloat{
        //User Data
        let phone = personalInfo.phoneNumber ?? ""
        let email = personalInfo.summary ?? ""
        let location = personalInfo.location ?? ""
        
        let titleBottom = addTitle(pageRect: pageRect, text: title, context: context, template: Int(resumeContent.resumeTemplate_id))
        let sectionBottom = addPersonalInformation(pageRect: pageRect, startPosition: titleBottom, text: "\(phone) | \(email) | \(location)", context: context, template: Int(resumeContent.resumeTemplate_id))
    
        
        return sectionBottom + 12.0
    }
    
    func addSummarySection(pageRect: CGRect,currentPosition: CGFloat, drawContext: CGContext, context:UIGraphicsPDFRendererContext)->CGFloat{
        let summary = personalInfo.summary ?? ""
        let headerBottom = addHeader(pageRect: pageRect, headerTop: currentPosition, text: "Summary", context: context, template: Int(resumeContent.resumeTemplate_id))
        let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
        let contentBottom = addParagraphText(pageRect: pageRect, textTop: separatorBottom, text: "\(summary)", context: context, template: Int(resumeContent.resumeTemplate_id))
        
        return contentBottom + 4.0
    }
    
    func addEducationSection(pageRect: CGRect,startPosition: CGFloat, drawContext: CGContext, context: UIGraphicsPDFRendererContext)->CGFloat{
        //User Data
        var sectionBottom: CGFloat = startPosition
        if eduData.count != 0 {
        let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Education", context: context, template: Int(resumeContent.resumeTemplate_id))
        let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
        for index in 0..<eduData.count {
            let institutionName = eduData[index].institution ?? ""
            let startYear = eduData[index].start_date?.string(format: Date.ISO8601Format.Year) ?? ""
            let endYear = eduData[index].end_date?.string(format: Date.ISO8601Format.Year) ?? ""
            let duration =  "\(startYear) - \(endYear)"
            let title = eduData[index].title ?? ""
            let gpa = String(eduData[index].gpa)
            let desc = eduData[index].activity ?? ""
            
            if index == 0 {
                sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: separatorBottom, text: institutionName, context: context, template: Int(resumeContent.resumeTemplate_id))
            }else {
                sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: sectionBottom, text: institutionName, context: context, template: Int(resumeContent.resumeTemplate_id))
            }
            addPeriodText(pageRect: pageRect, textTop: sectionBottom, text: duration, context: context, template: Int(resumeContent.resumeTemplate_id))
            sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: title, context: context, template: Int(resumeContent.resumeTemplate_id))
            sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "GPA \(gpa)", context: context, template: Int(resumeContent.resumeTemplate_id))
            sectionBottom = addParagraphText(pageRect: pageRect, textTop: sectionBottom, text: desc, context: context, template: Int(resumeContent.resumeTemplate_id))
        }
            return sectionBottom + 4.0}
        else{
            return sectionBottom
        }
        }
    
        func addExperienceSection(pageRect: CGRect, drawContext: CGContext, startPosition: CGFloat, context:UIGraphicsPDFRendererContext)-> CGFloat{
            var sectionBottom:CGFloat = startPosition
            if expData.count != 0 {
            let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Experience", context: context, template: Int(resumeContent.resumeTemplate_id))
            let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
            for index in 0..<expData.count{
                let company = expData[index].jobCompanyName ?? ""
                let position = expData[index].jobTitle ?? ""
                let desc = expData[index].jobDesc ?? ""
                let startDate = expData[index].jobStartDate?.string(format: Date.ISO8601Format.MonthYear) ?? ""
                var endDate = ""
                let isCurrently = expData[index].jobStatus
                if isCurrently {
                    endDate = "Present"
                } else {
                    endDate = expData[index].jobEndDate?.string(format: Date.ISO8601Format.MonthYear) ?? ""
                }
                let duration = "\(String(describing: startDate)) - \(endDate)"
                
                if index == 0{
                    sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: separatorBottom, text: company, context: context, template: Int(resumeContent.resumeTemplate_id))
                }else{
                    sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: sectionBottom, text: company, context: context, template: Int(resumeContent.resumeTemplate_id))
                }
                addPeriodText(pageRect: pageRect, textTop: sectionBottom, text: duration, context: context, template: Int(resumeContent.resumeTemplate_id))
                sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: position, context: context, template: Int(resumeContent.resumeTemplate_id))
                sectionBottom = addParagraphText(pageRect: pageRect, textTop: sectionBottom, text: desc, context: context, template: Int(resumeContent.resumeTemplate_id))
            }
            
                return sectionBottom + 4.0}
            else{
                return sectionBottom
            }
        }
    
        func addAccomplishmentSection(pageRect:CGRect, drawContext: CGContext, startPosition: CGFloat, context: UIGraphicsPDFRendererContext)-> CGFloat{
            if accomData.count != 0 {
            let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Accomplishment", context: context, template: Int(resumeContent.resumeTemplate_id))
            let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
            var sectionBottom: CGFloat = startPosition
            for index in 0..<accomData.count {
                let title = accomData[index].title ?? ""
                let givenDate = accomData[index].given_date?.string(format: Date.ISO8601Format.MonthYear) ?? ""
                let isCurrently = accomData[index].status
                var endDate = ""
                if isCurrently {
                    endDate = "Present"
                } else {
                    endDate = accomData[index].end_date?.string(format: Date.ISO8601Format.MonthYear) ?? ""
                }
                let issuer = accomData[index].issuer ?? ""
                let desc = accomData[index].desc
                
                if index == 0{
                    sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: separatorBottom, text: "\(title)", context: context, template: Int(resumeContent.resumeTemplate_id))
                    addPeriodText(pageRect: pageRect, textTop: separatorBottom, text: "\(givenDate) - \(endDate)", context: context, template: Int(resumeContent.resumeTemplate_id))
                }else{
                    addPeriodText(pageRect: pageRect, textTop: sectionBottom, text: "\(givenDate) - \(endDate)", context: context, template: Int(resumeContent.resumeTemplate_id))
                    sectionBottom = addInstitutionText(pageRect: pageRect, institutionTop: sectionBottom, text: "\(title)", context: context, template: Int(resumeContent.resumeTemplate_id))
                }
                sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: "\(issuer)", context: context, template: Int(resumeContent.resumeTemplate_id))
            }
                return sectionBottom + 4.0}
            else{
                return startPosition
            }
        }
        
        func addSkillSection(pageRect: CGRect, drawContext: CGContext, startPosition: CGFloat, context: UIGraphicsPDFRendererContext)->CGFloat{
            var sectionBottom: CGFloat = startPosition
            if skillData.count != 0{
            let headerBottom = addHeader(pageRect: pageRect, headerTop: startPosition, text: "Technical Skills", context: context, template: Int(resumeContent.resumeTemplate_id))
            let separatorBottom = drawSeparator(drawContext, pageRect: pageRect, height: headerBottom)
            for index in 0..<skillData.count {
                let skillName = skillData[index].skill_name ?? ""
                if index == 0{
                    sectionBottom = addBodyText(pageRect: pageRect, textTop: separatorBottom, text: skillName, context: context, template: Int(Int(resumeContent.resumeTemplate_id)))
                }else{
                    sectionBottom = addBodyText(pageRect: pageRect, textTop: sectionBottom, text: skillName, context: context, template: Int(resumeContent.resumeTemplate_id))
                }
            }
            
                return sectionBottom + 4.0}
            else{
                return sectionBottom
            }
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
                headerFont = UIFont(name: "Helvetica-Bold", size: 14.0)
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
            var fixedTextHeight: CGFloat
            let textHeight = attributedParagraph.size().width/pageRect.width
    
            if round(textHeight)<textHeight{
                fixedTextHeight = round(textHeight) + 1
            }else{
                fixedTextHeight = round(textHeight)
            }
        
            if textTop + attributedParagraph.size().height <= 822{
                paragraphRect = CGRect(x:20, y: textTop, width: pageRect.width - 25, height: fixedTextHeight * attributedParagraph.size().height + attributedParagraph.size().height)
            }else{
                context.beginPage()
                paragraphRect = CGRect(x:20, y: 20, width: pageRect.width - 25, height:  fixedTextHeight * attributedParagraph.size().height + attributedParagraph.size().height)
            }
      
            attributedParagraph.draw(in: paragraphRect)
            
        return paragraphRect.origin.y + (fixedTextHeight * attributedParagraph.size().height) + 15
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

extension PDFCreator {
    func getResumeContentData(){
        getEduData()
        getExpData()
        getSkillData()
        getAccomData()
    }
    
    func getEduData() {
        if let eduId = resumeContent.edu_id {
            for i in 0..<eduId.count {
                let tmp = EducationRepository.shared.getEducationById(educationId: eduId[i]) ?? Education()
                eduData.append(tmp)
            }
        }
    }
    func getExpData(){
        if let expId = resumeContent.exp_id {
            for i in 0..<expId.count {
                let tmp = ExperienceRepository.shared.getExperienceById(experienceId: expId[i]) ?? Experience()
                expData.append(tmp)
            }
        }
    }
    func getSkillData(){
        if let skillId = resumeContent.skill_id {
            for i in 0..<skillId.count {
                let tmp = SkillRepository.shared.getSkillsById(skillId: skillId[i]) ?? Skills()
                skillData.append(tmp)
            }
        }
    }
    func getAccomData(){
        if let accomId = resumeContent.accom_id {
            for i in 0..<accomId.count {
                let tmp = AccomplishmentRepository.shared.getAccomplishmentById(AccomplishmentId: accomId[i]) ?? Accomplishment()
                accomData.append(tmp)
            }
        }
    }
}
