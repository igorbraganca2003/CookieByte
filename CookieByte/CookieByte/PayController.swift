//
//  PayController.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 26/06/24.
//

import Foundation
import PassKit
import UIKit

typealias PayCompletion = (Bool, [String: Any]?) -> Void

class PayController: NSObject {

    var controller: PKPaymentAuthorizationController?
    var status = PKPaymentAuthorizationStatus.failure
    var payData: [String: Any]?
    var completionHandler: PayCompletion!
    
    let applePay = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .white)
    let request = PKPaymentRequest()
    
    func startPayment(items: [PKPaymentSummaryItem], completion: @escaping PayCompletion){
        
        completionHandler = completion
        
        request.merchantIdentifier  = "merchant.com.order.cookiebyte"
        request.merchantCapabilities = [.capability3DS, .capabilityEMV]
        request.countryCode = "BR"
        request.currencyCode = "BRL"
        request.supportedNetworks = [.discover, .masterCard, .visa, .elo, .maestro, .amex]
//        request.paymentSummaryItems = [...]
        
        controller = PKPaymentAuthorizationController(paymentRequest: request)
        controller?.delegate = self
        controller?.present(completion: {(presented: Bool) in
            if presented {
                print("Present Paymente Controller")
            } else {
                print("Failed to present Payment Controller")
                self.completionHandler(false, nil)
            }
        })
    }
    
}

extension PayController: PKPaymentAuthorizationControllerDelegate {
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        self.status = PKPaymentAuthorizationStatus.success
        
        do {
            if let json = try JSONSerialization.jsonObject(with: payment.token.paymentData, options: []) as? [String: Any] {
                self.payData = json
                completion(PKPaymentAuthorizationResult(status: PKPaymentAuthorizationStatus.success, errors: [Error]()))
            }
        } catch let error as NSError{
            print("Failed to load: \(error.localizedDescription)")
            completion(PKPaymentAuthorizationResult(status: PKPaymentAuthorizationStatus.success, errors: [Error]()))
        }
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
                if self.status == .success {
                    self.completionHandler!(true, self.payData)
                    print("Success")
                } else {
                    self.completionHandler!(false, nil)
                    print("Failed")
                }
            }
        }
    }
}
