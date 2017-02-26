//
//  Extention.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/24/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import Foundation
import UIKit

enum StoryBoard: String {
    case Main = "Main"
    func viewController(_ name: String) -> UIViewController {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: name)
    }
}
