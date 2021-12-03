//
//  Extension.swift
//  GoPlace-Client
//
//  Created by dianna on 15/11/21.
//

import UIKit

extension UIButton{
    func isChecked (_ isChecked: Bool)
    {
        let image = UIImage(named:"Checked_\(isChecked ? 1 : 0)")
        self.setImage(image, for: .normal)
    }
    
}
