//
//  Constants.swift
//  ViperModules
//
//  Created by Jonathan Pacheco on 29/12/15.
//  Copyright © 2015 Jonathan Pacheco. All rights reserved.
//

import Cocoa

enum ModuleFolderNames: String {
    
    case DataFolderName         = "Data"
    case LogicFolderName        = "Logic"
    case ModuleFolderName       = "Module"
    case UIFolderName           = "UI"
    case PresenterFolderName    = "Presenter"
    case ViewsFolderName        = "View"
    case RoutingFolderName      = "Routing"
    case ControllerFolderName   = "Controllers"
    
}

enum ModuleFileNames: String {
    
    case ModelFileName          = "Model"
    case InteractorFileName     = "Interactor"
    case ModuleFileName         = "Module"
    case PresenterFileName      = "Presenter"
    case WireframeFileName      = "Wireframe"
    case ViewControllerFileName = "ViewController"
    
    var nameWithExtension: String {
        get { return self.rawValue.stringByAppendingString(".swift") }
    }
    
}

enum ModuleFolders {
    
    case DefaultFolder(baseUrl: NSURL, moduleName: String)
    case DataFolder(NSURL)
    case LogicFolder(NSURL)
    case ModuleFolder(NSURL)
    case UIFolder(NSURL)
    
    indirect case PresenterFolder(ModuleFolders)
    indirect case ViewsFolder(ModuleFolders)
    indirect case RoutingFolder(ModuleFolders)
    indirect case ControllersFolder(ModuleFolders)

    var URL: NSURL {
        get {
            switch self {
            case DefaultFolder(let baseURL, let moduleName):
                return baseURL.URLByAppendingPathComponent(moduleName)
                
            case DataFolder(let baseURL):
                return baseURL.URLByAppendingPathComponent(ModuleFolderNames.DataFolderName.rawValue)
            case LogicFolder(let baseURL):
                return baseURL.URLByAppendingPathComponent(ModuleFolderNames.LogicFolderName.rawValue)
            case ModuleFolder(let baseURL):
                return baseURL.URLByAppendingPathComponent(ModuleFolderNames.ModuleFolderName.rawValue)
            case UIFolder(let baseURL):
                return baseURL.URLByAppendingPathComponent(ModuleFolderNames.UIFolderName.rawValue)
                
            case PresenterFolder(let parentFolder):
                return parentFolder.URL.URLByAppendingPathComponent(ModuleFolderNames.PresenterFolderName.rawValue)
            case ViewsFolder(let parentFolder):
                return parentFolder.URL.URLByAppendingPathComponent(ModuleFolderNames.ViewsFolderName.rawValue)
            case RoutingFolder(let parentFolder):
                return parentFolder.URL.URLByAppendingPathComponent(ModuleFolderNames.RoutingFolderName.rawValue)
            case .ControllersFolder(let parentFolder):
                return parentFolder.URL.URLByAppendingPathComponent(ModuleFolderNames.ControllerFolderName.rawValue)
            }
        }
    }
    
}

enum ModuleFiles {
    
    case ModelFile(baseURL: NSURL, module: ModuleModel)
    case InteractorFile(baseURL: NSURL, module: ModuleModel)
    case ModuleFile(baseURL: NSURL, module: ModuleModel)
    case PresenterFile(baseURL: NSURL, module: ModuleModel)
    case ViewControllerFile(baseURL: NSURL, module: ModuleModel)
    case WireframeFile(baseURL: NSURL, module: ModuleModel)
    
    var URL: NSURL {
        get {
            switch self {
            case .ModelFile(let baseURL, let module):
                let fileName = ModuleFileNames.ModelFileName.nameWithExtension
                return ModuleFolders.DataFolder(baseURL).URL.URLByAppendingPathComponent("\(module.moduleName)\(fileName)")
                
            case .InteractorFile(let baseURL, let module):
                let fileName = ModuleFileNames.InteractorFileName.nameWithExtension
                return ModuleFolders.LogicFolder(baseURL).URL.URLByAppendingPathComponent("\(module.moduleName)\(fileName)")
                
            case .ModuleFile(let baseURL, let module):
                let fileName = ModuleFileNames.ModuleFileName.nameWithExtension
                return ModuleFolders.ModuleFolder(baseURL).URL.URLByAppendingPathComponent("\(module.moduleName)\(fileName)")
                
            case .PresenterFile(let baseURL, let module):
                let UIFolder = ModuleFolders.UIFolder(baseURL)
                let fileName = ModuleFileNames.PresenterFileName.nameWithExtension
                return ModuleFolders.PresenterFolder(UIFolder).URL.URLByAppendingPathComponent("\(module.moduleName)\(fileName)")
                
            case .ViewControllerFile(let baseURL, let module):
                let UIFolder = ModuleFolders.UIFolder(baseURL)
                let fileName = ModuleFileNames.ViewControllerFileName.nameWithExtension
                return ModuleFolders.ViewsFolder(UIFolder).URL.URLByAppendingPathComponent("\(module.moduleName)\(fileName)")
                
            case .WireframeFile(let baseURL, let module):
                let UIFolder = ModuleFolders.UIFolder(baseURL)
                let fileName = ModuleFileNames.WireframeFileName.nameWithExtension
                return ModuleFolders.RoutingFolder(UIFolder).URL.URLByAppendingPathComponent("\(module.moduleName)\(fileName)")
            }
        }
    }
    
}

