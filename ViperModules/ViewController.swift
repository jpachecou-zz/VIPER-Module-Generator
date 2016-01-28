//
//  ViewController.swift
//  ViperModules
//
//  Created by Jonathan Pacheco on 29/12/15.
//  Copyright © 2015 Jonathan Pacheco. All rights reserved.
//

import Cocoa 

class ViewController: NSViewController {
    
    @IBOutlet weak var moduleNameTextField:          NSTextField!
    @IBOutlet weak var projectNameTextField:         NSTextField!
    @IBOutlet weak var developerNameTextField:       NSTextField!
    @IBOutlet weak var organizationNameTextField:    NSTextField!

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func generateModule(sender: AnyObject) {
        let moduleName           = self.moduleNameTextField.stringValue
        let projectName          = self.projectNameTextField.stringValue
        let developerName        = self.developerNameTextField.stringValue
        var organizationName     = self.organizationNameTextField.stringValue
        
        guard moduleName.characters.count > 0 else {
            self.showMessage("The module name cannot be empty")
            return
        }
        guard projectName.characters.count > 0 else {
            self.showMessage("The project name cannot be empty")
            return
        }
        guard developerName.characters.count > 0 else {
            self.showMessage("The developer name cannot be empty")
            return
        }
        if organizationName.characters.count == 0 {
            organizationName = "Grability"
        }
        
        let model = ModuleModel()
        model.moduleName           = moduleName
        model.projectName          = projectName
        model.developerName        = developerName
        model.organizationName     = organizationName
        
        let filesManager = FilesManager(moduleModel: model)
        filesManager.generateModule()
    }
    
    private func showMessage(message: String) {
        let myPopup: NSAlert = NSAlert()
        myPopup.messageText = "Warning"
        myPopup.informativeText = message
        myPopup.alertStyle = NSAlertStyle.WarningAlertStyle
        myPopup.addButtonWithTitle("OK")
        myPopup.runModal()
    }

}

