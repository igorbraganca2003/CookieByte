//
//  IconCartDelegate.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 28/05/24.
//

import UIKit

class IconCartDelegate {
    var uiView: CookiePopUp?
    var viewController: HomeViewController?
    
    func changeIcon(){
        viewController?.navigationItem.rightBarButtonItems?[1].isHidden = true
        viewController?.navigationItem.rightBarButtonItems?[0].isHidden = true
        print("chamou")
    }
}
//delegate.uiView = self //cookiepopup
