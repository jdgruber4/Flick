//
//  tapExtensition.swift
//  Flick
//
//  Created by Gruber, John David on 12/14/20.
//

import SwiftUI

extension UIView {
    open override func touchesBegan(_ touches: Set, with event: UIEvent?){
        super.touchesBegan(touches, with: event)
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.endEditing(true)
    }
}
