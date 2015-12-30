//
//  FilesManager.swift
//  ViperModules
//
//  Created by Jonathan Pacheco on 29/12/15.
//  Copyright © 2015 Jonathan Pacheco. All rights reserved.
//

import Cocoa

class FilesManager {
    
    var moduleModel: ModuleModel
    private var baseURL: String?
    
    init(moduleModel: ModuleModel) {
        self.moduleModel = moduleModel
    }
    
    func generateModule() {
        self.loadBaseFolder { path in
            self.createFolders((path, self.moduleModel.moduleName))
            self.createFolders((path, self.moduleModel.moduleName))
        }
    }
    
    private func createFolders(params: (baseUrl: NSURL?, moduleName: String)) {
        guard var baseUrl = params.baseUrl else { return }
        baseUrl = ModuleFolders.DefaultFolder(baseUrl: baseUrl, moduleName: params.moduleName).URL
        self.baseURL = baseUrl.path
        for url in self.getAllFolderURLS(baseUrl) {
            self.createFolder(url)
        }
        for file in self.getAllFilesURLS(baseUrl, module: self.moduleModel) {
            ClassGenerator.generateClass(file, model: self.moduleModel)
        }
        self.showResults(baseUrl)
    }
    
    private func createFolder(url: NSURL) {
        guard let path = url.path else { return }
        
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(path) {
            do {
                try fileManager.createDirectoryAtPath(path, withIntermediateDirectories: false, attributes: nil)
            } catch {}
        }
    }

    
    private func loadBaseFolder(callback: (path: NSURL) -> Void) {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.canCreateDirectories = true
        panel.beginWithCompletionHandler { result in
            if result == NSFileHandlingPanelOKButton {
                if let theDoc = panel.URLs.first {
                    callback(path: theDoc)
                }
            }
        }
    }
    
}

// Utils

extension FilesManager {
    
    func getAllFolderURLS(baseUrl: NSURL) -> [NSURL] {
        let UIFolder = ModuleFolders.UIFolder(baseUrl)
        let ViewsFolder = ModuleFolders.ViewsFolder(UIFolder)
        return [
            baseUrl,
            ModuleFolders.DataFolder(baseUrl).URL,
            ModuleFolders.LogicFolder(baseUrl).URL,
            ModuleFolders.ModuleFolder(baseUrl).URL,
            UIFolder.URL,
            ModuleFolders.PresenterFolder(UIFolder).URL,
            ModuleFolders.RoutingFolder(UIFolder).URL,
            ViewsFolder.URL,
            ModuleFolders.ControllersFolder(ViewsFolder).URL
        ]
    }
    
    func getAllFilesURLS(baseUrl: NSURL, module: ModuleModel) -> [ModuleFiles] {
        return [
            ModuleFiles.ModelFile(baseURL: baseUrl, module: module),
            ModuleFiles.InteractorFile(baseURL: baseUrl, module: module),
            ModuleFiles.ModuleFile(baseURL: baseUrl, module: module),
            ModuleFiles.PresenterFile(baseURL: baseUrl, module: module),
            ModuleFiles.WireframeFile(baseURL: baseUrl, module: module),
            ModuleFiles.ViewControllerFile(baseURL: baseUrl, module: module)
        ]
    }
    
    func showResults(baseUrl: NSURL) {
        guard let path = baseUrl.path?.stringByAppendingString("/") else { return }
        NSWorkspace.sharedWorkspace().selectFile(nil, inFileViewerRootedAtPath: path)

    }
    
}
