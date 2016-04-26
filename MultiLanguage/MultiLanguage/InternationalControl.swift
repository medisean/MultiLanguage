//
//  InternationalControl.swift
//  MultiLanguageDemo
//
//  Created by ZouLiangming on 16/1/6.
//  Copyright © 2016年 ZouLiangming. All rights reserved.
//

import UIKit

enum Language: String, CustomStringConvertible {
    case English = "en"
    case SimplifiedChinese = "zh-Hans"
    case TraditionalChinese = "zh-Hant"
    case Korean = "ko"
    case Japanese = "ja"
    
    var description: String {
        switch self {
        case .English:
            return "English"
        case .SimplifiedChinese:
            return "简体中文"
        case .TraditionalChinese:
            return "繁體中文"
        case .Korean:
            return "한국어"
        case .Japanese:
            return "日本語"
        }
    }
    
    static var allLanguages: [Language] {
        return [.SimplifiedChinese, .TraditionalChinese, .English, .Korean, .Japanese]
    }
}

func LocalizedString(key: String, comment: String? = nil) -> String {
    if let path = NSBundle.mainBundle().pathForResource(InternationalControl.currentLanguage.rawValue, ofType: "lproj"), bundle = NSBundle(path: path) {
        return bundle.localizedStringForKey(key, value: comment, table: nil)
    }
    return key
}

class InternationalControl {
    
    static let kCurrentLanguageKey = "currentLanguageKey"
    static var currentLanguage: Language {
        get {
            if let currentLanguage = NSUserDefaults.standardUserDefaults().objectForKey(kCurrentLanguageKey) as? String {
                return Language(rawValue: currentLanguage) ?? defaultLanguage
            } else {
                return defaultLanguage
            }
        }
        set {
            let savedLanguage = availableLocalizations.contains(newValue.rawValue) ? newValue : defaultLanguage
            if savedLanguage != currentLanguage {
                NSUserDefaults.standardUserDefaults().setObject(savedLanguage.rawValue, forKey: kCurrentLanguageKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    static var localeForCurrentLanguage: NSLocale {
        return NSLocale(localeIdentifier: currentLanguage.rawValue)
    }
    
    static var defaultLanguage: Language {
        var defaultLanguage: Language = getPreferredLanguage()
        
        guard let preferredLocalization = NSBundle.mainBundle().preferredLocalizations.first else {
            return defaultLanguage
        }
        if availableLocalizations.contains(preferredLocalization) {
            defaultLanguage = Language(rawValue: preferredLocalization) ?? defaultLanguage
        }
        
        return defaultLanguage
    }
    
    private static var availableLocalizations: [String] {
        return NSBundle.mainBundle().localizations
    }
    
    private static func getPreferredLanguage() -> Language {
        var defaultPreferredLanguage = Language.English
        let preferredLanguages = NSLocale.preferredLanguages()
        if let firstPreferreLanguage = preferredLanguages.first {
            if firstPreferreLanguage.containsString(Language.SimplifiedChinese.rawValue) {
                defaultPreferredLanguage = Language.SimplifiedChinese
            } else if firstPreferreLanguage.containsString(Language.TraditionalChinese.rawValue) {
                defaultPreferredLanguage = Language.TraditionalChinese
            } else if firstPreferreLanguage.containsString(Language.Korean.rawValue) {
                defaultPreferredLanguage = Language.Korean
            } else if firstPreferreLanguage.containsString(Language.Japanese.rawValue) {
                defaultPreferredLanguage = Language.Japanese
            }
        }
        return defaultPreferredLanguage
    }
}
