//
//  PreloadPersonalInfoPlaceholder.swift
//  dayangsurga-macro
//
//  Created by Anya Akbar on 07/11/21.
//

import Foundation

func preloadPersonalInfoPlaceholder() {
    PersonalInformationPlaceholderRepository.shared.createUserPh(   pi_ph_id: 1,
                        user_id: 0,
                        name_ph: "e.g: Olip Dayangz",
                        phoneNumber_ph: "e.g: 08123456XXX",
                        email_ph: "e.g. Olipia@gmail.com",
                        address_ph: "e.g. Jakarta, Indonesia",
                        summary_ph: "e.g. Highly capable Product Manager with 1+ years experience in technology companies, seeking to apply strategic planning to grow revenue and market share. ")
}
