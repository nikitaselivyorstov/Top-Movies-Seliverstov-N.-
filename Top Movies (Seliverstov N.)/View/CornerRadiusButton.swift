//
//  CornerRadiusButton.swift
//  Top Movies (Seliverstov N.)
//
//  Created by Nikita Seliverstov  on 07/08/2019.
//  Copyright © 2019 Nikita Seliverstov . All rights reserved.
//

import UIKit

final class CornerRadiusButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 16
    }
}
