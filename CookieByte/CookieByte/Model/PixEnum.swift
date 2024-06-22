//
//  PixEnum.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 14/06/24.
//

import UIKit

enum PixEnum {
    case empty
    case four
    case eight
    case twelve
    case sixteen
    case twenty
    case twentyfour
    case twentyeight
    case thirtytwo

    
    var label: String {
        switch self {
        case .empty:
            return "00020126360014br.gov.bcb.pix0114+55119893645855204000053039865802BR5925Igor Braganca De Toledo S6009Sao Paulo62070503***6304E6B4"
        case .four:
            return "00020126360014br.gov.bcb.pix0114+551198936458552040000530398654044.005802BR5925Igor Braganca De Toledo S6009Sao Paulo62070503***6304F9AA"
        case .eight:
            return "00020126360014br.gov.bcb.pix0114+551198936458552040000530398654048.005802BR5925Igor Braganca De Toledo S6009Sao Paulo62070503***630412CA"
        case .twelve:
            return "00020126360014br.gov.bcb.pix0114+5511989364585520400005303986540512.005802BR5925Igor Braganca De Toledo S6009Sao Paulo62070503***6304D400"
        case .sixteen:
            return "00020126360014br.gov.bcb.pix0114+5511989364585520400005303986540516.005802BR5925Igor Braganca De Toledo S6009Sao Paulo62070503***63048D20"
        case .twenty:
            return "00020126360014br.gov.bcb.pix0114+5511989364585520400005303986540520.005802BR5925Igor Braganca De Toledo S6009Sao Paulo62070503***6304B789"
        case .twentyfour:
            return "00020126360014br.gov.bcb.pix0114+5511989364585520400005303986540524.005802BR5925Igor Braganca De Toledo S6009Sao Paulo62070503***6304EEA9"
        case .twentyeight:
            return "00020126360014br.gov.bcb.pix0114+5511989364585520400005303986540528.005802BR5925Igor Braganca De Toledo S6009Sao Paulo62070503***630405C9"
        case .thirtytwo:
            return "00020126360014br.gov.bcb.pix0114+5511989364585520400005303986540532.005802BR5925Igor Braganca De Toledo S6009Sao Paulo62070503***6304A1EE"
        }
    }
    
    var qrCode: UIImage? {
        switch self {
        case .empty:
            return UIImage(named: "Pix")
        case .four:
            return UIImage(named: "Pix4")
        case .eight:
            return UIImage(named: "Pix8")
        case .twelve:
            return UIImage(named: "Pix12")
        case .sixteen:
            return UIImage(named: "Pix16")
        case .twenty:
            return UIImage(named: "Pix20")
        case .twentyfour:
            return UIImage(named: "Pix24")
        case .twentyeight:
            return UIImage(named: "Pix28")
        case .thirtytwo:
            return UIImage(named: "Pix32")
        }
    }
    
}
