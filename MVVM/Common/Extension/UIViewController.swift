//
//  UINavigationController.swift
//  Tourism
//
//  Created by Mohamed El-Taweel on 7/4/19.
//  Copyright © 2019 Going. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static func create(storyboardName: String,viewControllerID: String)->UIViewController?{
        let targetStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let destinationVC = targetStoryboard.instantiateViewController(withIdentifier: viewControllerID)
        return destinationVC
    }
    
}

