//
//  FilesManager.swift
//  ViperModules
//
//  Created by Jonathan Pacheco on 29/12/15.
//  Copyright © 2015 Jonathan Pacheco. All rights reserved.
//

import Cocoa

enum FilesManagerType {
    case File
    case Folder
    case Invalid
}

class FilesManager {
    
    var moduleModel: ModuleModel
    private var baseURL: String?
    private var templatePath: NSURL! {
        get { return NSBundle.mainBundle().URLForResource("Templates", withExtension: nil)! }
    }
    
    init(moduleModel: ModuleModel) {
        self.moduleModel = moduleModel
    }
    
    func generateModule() {
        self.loadBaseFolder { path in
            self.createFolders((path, self.moduleModel))
            self.createFolders((path, self.moduleModel))
        }
    }
    
    private func createFolders(params: (baseUrl: NSURL?, model: ModuleModel)) {
        guard let baseUrl = params.baseUrl?.URLByAppendingPathComponent(params.model.moduleName) else { return }
        self.createFolder(baseUrl)
        guard let enumerator = NSFileManager.defaultManager().enumeratorAtURL(self.templatePath,
            includingPropertiesForKeys: [NSURLIsDirectoryKey],
            options: NSDirectoryEnumerationOptions.init(rawValue: 0), errorHandler:  { _, _ in return true })
            else { return }
        for url in enumerator {
            guard let url = url as? NSURL else { break }
            let fileType = FilesManager.isPathDirectory(url.path ?? "")
            let fileName: String? = (fileType == .File ? params.model.moduleName : nil)
            if let fileUrl = self.getNewUrlWithBase(baseUrl, template: url, fileName: fileName) {
                print(fileUrl)
                switch fileType {
                case .Folder:
                    self.createFolder(fileUrl)
                case .File:
                    ClassGenerator.generateClass(fileUrl, templateUrl: url, model: params.model)
                default: break
                }
            }
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

    private func getNewUrlWithBase(base: NSURL, template: NSURL, fileName: String?) -> NSURL? {
        guard let templateBasePath = self.templatePath.path else { return nil }
        guard let templatePath = template.path else { return nil }
        let range = Range<String.Index>(start: templateBasePath.endIndex, end: templatePath.endIndex)
        let newPath = templatePath[range]
        let newUrl = base.URLByAppendingPathComponent(newPath)
        
        if let fileName = fileName {
            guard var lastPathComponent = newUrl.lastPathComponent else { return newUrl }
            lastPathComponent = lastPathComponent.stringByReplacingOccurrencesOfString("Template", withString: fileName)
            lastPathComponent = (lastPathComponent as NSString).stringByDeletingPathExtension
            lastPathComponent += ".swift"
            return newUrl.URLByDeletingLastPathComponent?.URLByAppendingPathComponent(lastPathComponent)
        }
        
        return newUrl
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
    
    func showResults(baseUrl: NSURL) {
        guard let path = baseUrl.path?.stringByAppendingString("/") else { return }
        NSWorkspace.sharedWorkspace().selectFile(nil, inFileViewerRootedAtPath: path)
    }
    
    class func isPathDirectory(path: String) -> FilesManagerType {
        var isDirectory: ObjCBool = ObjCBool(false)
        if NSFileManager.defaultManager().fileExistsAtPath(path, isDirectory: &isDirectory) {
            return isDirectory.boolValue ? .Folder : .File
        }
        return .Invalid
    }
}
