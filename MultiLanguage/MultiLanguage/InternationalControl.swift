//
//  InternationalControl.swift
//  MultiLanguageDemo
//
//  Created by ZouLiangming on 31/3/6.
//  Copyright © 2016年 ZouLiangming. All rights reserved.
//

import UIKit

let kCurrentLanguageKey = "currentLanguageKey"
let kDefaultLanguage = Language.English

enum Language: String {
    case English = "en"
    case SimplifiedChinese = "zh-Hans"
    case TraditionalChinese = "zh-Hant"
    case Korean = "ko"
    case Japanese = "ja"
}

public func LocalizedString(key: String) -> String {
    return LocalizedString(key, comment: nil)
}

public func LocalizedString(key: String, comment: String?) -> String {
    if let path = NSBundle.mainBundle().pathForResource(InternationalControl.currentLanguage().rawValue, ofType: "lproj"), bundle = NSBundle(path: path) {
        return bundle.localizedStringForKey(key, value: comment, table: nil)
    }
    return key
}

class InternationalControl: NSObject {
    class func localeForCurrentLanguage() -> NSLocale {
        return NSLocale(localeIdentifier: currentLanguage().rawValue)
        
    }
    
    class func currentLanguage() -> Language {
        if let currentLanguage = NSUserDefaults.standardUserDefaults().objectForKey(kCurrentLanguageKey) as? String {
            return Language(rawValue: currentLanguage) ?? defaultLanguage()
        }
        return defaultLanguage()
    }
    
    class func defaultLanguage() -> Language {
        var defaultLanguage: Language = .English
        guard let preferredLanguage = NSBundle.mainBundle().preferredLocalizations.first else {
            return kDefaultLanguage
        }
        let availableLanguages: [String] = self.availableLanguages()
        if availableLanguages.contains(preferredLanguage) {
            defaultLanguage = Language(rawValue: preferredLanguage) ?? kDefaultLanguage
        } else {
            defaultLanguage = kDefaultLanguage
        }
        return defaultLanguage
    }
    
    class func setCurrentLanguage(language: Language) {
        let selectedLanguage = availableLanguages().contains(language.rawValue) ? language : defaultLanguage()
        if selectedLanguage != currentLanguage() {
            NSUserDefaults.standardUserDefaults().setObject(selectedLanguage.rawValue, forKey: kCurrentLanguageKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    class func availableLanguages() -> [String] {
        return NSBundle.mainBundle().localizations
    }
}
