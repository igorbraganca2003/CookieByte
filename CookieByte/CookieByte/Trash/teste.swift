//
//  teste.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 21/05/24.
//

import UIKit

class teste: UIView{
    
    private let label: UILabel = {
        let label = UILabel()
        
        label.text = "Cookie M&M's"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var vStack: UIStackView = {
        
        let stack = UIStackView(arrangedSubviews: [label, label, label])
        
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
        
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        addUI()
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("Error")
    }
    
    func addUI(){
        self.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

#Preview(){
    return teste()
}
