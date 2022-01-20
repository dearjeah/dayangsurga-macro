//
//
//  UIImage+Extension.swift
//  dayangsurga-macro
//
//  Created by Dayang Surga Team.
//  swiftlint:disable all

import UIKit

// MARK: - Images Asset

extension UIImage {
    
    static let comingSoon = UIImage.image(named: "comingSoon")
    static let icAccomplishmentActive = UIImage.image(named: "icAccomplishmentActive")
    static let icAccomplishmentInactive = UIImage.image(named: "icAccomplishmentInactive")
    static let icAccomplishmentUnfilled = UIImage.image(named: "icAccomplishmentUnfilled")
    static let icEducationActive = UIImage.image(named: "icEducationActive")
    static let icEducationNoFill = UIImage.image(named: "icEducationNoFill")
    static let icEducationUnfilled = UIImage.image(named: "icEducationUnfilled")
    static let icExperienceActive = UIImage.image(named: "icExperienceActive")
    static let icExperienceNoFill = UIImage.image(named: "icExperienceNoFill")
    static let icExperienceUnfilled = UIImage.image(named: "icExperienceUnfilled")
    static let icLinkedIn = UIImage.image(named: "icLinkedIn")
    static let icPersonalInformationActive = UIImage.image(named: "icPersonalInformationActive")
    static let icPersonalInformationUnfilled = UIImage.image(named: "icPersonalInformationUnfilled")
    static let icPreviewResume = UIImage.image(named: "icPreviewResume")
    static let icRoundSelectionFilled = UIImage.image(named: "icRoundSelectionFilled")
    static let icRoundSelectionNoFill = UIImage.image(named: "icRoundSelectionNoFill")
    static let icSwipeNo = UIImage.image(named: "icSwipeNo")
    static let icSwipeYes = UIImage.image(named: "icSwipeYes")
    static let icTechnicalSkillActive = UIImage.image(named: "icTechnicalSkillActive")
    static let icTechnicalSkillNoFill = UIImage.image(named: "icTechnicalSkillNoFill")
    static let icTechnicalSkillUnfilled = UIImage.image(named: "icTechnicalSkillUnfilled")
    static let icWhatsApp = UIImage.image(named: "icWhatsApp")
    static let imgBtnCreateResume = UIImage.image(named: "imgBtnCreateResume")
    static let imgCreateResume = UIImage.image(named: "imgCreateResume")
    static let imgEmptyStateAccom = UIImage.image(named: "imgEmptyStateAccom")
    static let imgEmptyStateEdu = UIImage.image(named: "imgEmptyStateEdu")
    static let imgEmptyStateLandingPage = UIImage.image(named: "imgEmptyStateLandingPage")
    static let imgExpEmptyState = UIImage.image(named: "imgExpEmptyState")
    static let imgExpertDara = UIImage.image(named: "imgExpertDara")
    static let imgExpertDyah = UIImage.image(named: "imgExpertDyah")
    static let imgExpertFahri = UIImage.image(named: "imgExpertFahri")
    static let imgExpertInfo = UIImage.image(named: "imgExpertInfo")
    static let imgExpertMaria = UIImage.image(named: "imgExpertMaria")
    static let imgExpertNashtiti = UIImage.image(named: "imgExpertNashtiti")
    static let imgExpertRasyid = UIImage.image(named: "imgExpertRasyid")
    static let imgExpertRomano = UIImage.image(named: "imgExpertRomano")
    static let imgLogoAigoe = UIImage.image(named: "imgLogoAigoe")
    static let imgPersonalInformationEmptyState = UIImage.image(named: "imgPersonalInformationEmptyState")
    static let imgResumePreview = UIImage.image(named: "imgResumePreview")
    static let imgResumeTemplateArial = UIImage.image(named: "imgResumeTemplateArial")
    static let imgResumeTemplateGeorgia = UIImage.image(named: "imgResumeTemplateGeorgia")
    static let imgResumeTemplateHeletvica = UIImage.image(named: "imgResumeTemplateHeletvica")
    static let imgSkillEmptyState = UIImage.image(named: "imgSkillEmptyState")
    
    //System Image
    static let icDoc = UIImage(systemName: "doc.text")
    static let icPencil = UIImage(systemName: "pencil")
    static let icTextCheck = UIImage(systemName: "text.badge.checkmark")
    static let icRepeat = UIImage(systemName: "repeat")
    static let icTrash = UIImage(systemName: "trash")
    static let icXmark = UIImage(systemName: "xmark")
    
    static let icPersonFill = UIImage(systemName: "person.fill")
    static let icEduFill = UIImage(systemName: "graduationcap.fill")
    static let icExpFill = UIImage(systemName: "bag.fill")
    static let icSkillFill = UIImage(systemName: "gearshape.fill")
    static let icAchvFill = UIImage(systemName: "rosette")
    
    
    private static func image(named: String) -> UIImage {
        return UIImage(named: named)!
    }
}
