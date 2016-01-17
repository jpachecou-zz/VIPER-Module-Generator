# VIPER Module Generator

[![Build Status](https://travis-ci.org/jpachecou/VIPER-Module-Generator.svg?branch=master)](https://travis-ci.org/jpachecou/VIPER-Module-Generator)
![](https://img.shields.io/badge/plataform-osx-lightgrey.svg)
[![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/jpachecou/VIPER-Module-Generator/blob/master/LICENSE.md)

##Description

Simple Viper module generator with graphic interface easier of using

### Download in App store
<a href="https://itunes.apple.com/us/app/viper-module-generator/id1071345094?mt=12"><img src="http://www.particlenews.com/apps/landing_downloadv2_v1.0.0.3/landing_downloadv2_ios_download.svg" alt="Download to App Store" width="120" height="40"></a>

## Viper files structure
```bash
+-- Data
| - {{ModuleName}}Model.swift
+-- Logic
| - {{ModuleName}}Interactor.swift
| - {{ModuleName}}DataManager.swift
+-- Module
| - {{ModuleName}}Module.swift
+-- UI
| +-- Presenter
| | - {{ModuleName}}Presenter.swift
| +-- Routing
| | - {{ModuleName}}Wireframe.swift
| +-- View
| | # Storyboard file
| | +-- Controllers
| | | - {{ModuleName}}ViewController.swift  
```

## Instalation

It is the easiest way to create a module VIPER

1. Download and run the app
2. Write the name of the module, the developer, the project and the organization
3. Select the folder where you want to create the module
4. Drag the module to the project
5. Ready!!! 🍻🍻🍻

Download the last release [here](https://github.com/jpachecou/VIPER-Module-Generator/releases)
