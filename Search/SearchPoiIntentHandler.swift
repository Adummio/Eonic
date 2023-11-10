//
//  SearchPoiIntentHandler.swift
//  Search
//
//  Created by Antonio Ferraioli on 23/05/2020.
//  Copyright © 2020 Antonio Ferraioli. All rights reserved.
//

import Foundation
import Intents

class SearchPoiIntentHandler: NSObject, SearchPoiIntentHandling {
    func resolveOperatoreprova(for intent: SearchPoiIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        completion(INStringResolutionResult.success(with: ""))
    }
    
    func handle(intent: SearchPoiIntent, completion: @escaping (SearchPoiIntentResponse) -> Void) {
        print(intent.operatoreprova)
        completion(SearchPoiIntentResponse(code: .continueInApp, userActivity: nil))
    }
    
}
