//
//  ModuleModel.swift
//  ViperModules
//
//  Created by Jonathan Pacheco on 29/12/15.
//  Copyright © 2015 Jonathan Pacheco. All rights reserved.
//

import Cocoa

class ModuleModel {

    var moduleName = ""
    var projectName = ""
    var developerName = ""
    var organizationName = ""
    
    func then(selfModel: (model: ModuleModel) -> Void) -> ModuleModel {
        selfModel(model: self)
        return self
    }
    
}
