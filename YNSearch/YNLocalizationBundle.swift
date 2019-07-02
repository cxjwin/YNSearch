//
//  YNLocalizationBundle.swift
//  YNSearch
//
//  Created by smart on 2019/7/2.
//  Copyright © 2019 SeungyounYi. All rights reserved.
//

import Foundation

extension Bundle {
    
    static let PodsBundleName = "YNSearch-iOS"
    
    class func localizationBundle() -> Bundle {
        let classBundle = Bundle(for: YNSearch.self)
        guard let bundlePath = classBundle.path(forResource: Bundle.PodsBundleName, ofType: "bundle") else {
            return classBundle
        }
        guard let bundle = Bundle(path: bundlePath) else {
            return classBundle
        }
        return bundle;
    }
    
}
