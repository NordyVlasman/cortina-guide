//
//  Assets.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 03/01/2022.
//

import Foundation

struct AssetToLoad: EntityToLoad {
    var asset: Asset
    
    var key: Asset.Options
    var filename: String { return Asset.name(for: asset, options: key) }
}


enum Asset {
    struct Options: OptionSet, Hashable {
        let rawValue: Int
        static let none = Options([])
    }
    
    case ball
    case bike
    
    static func name(for asset: Asset, options: Options = []) -> String {
        
        switch (asset, options) {
        default:
            fatalError("Invalid asset \(asset) with options: \(options)")
        }
    }
    
    static func url(for asset: Asset, options: Options = []) -> URL {
        let name = self.name(for: asset, options: options)
        guard let url = Bundle.main.url(forResource: name, withExtension: "usdc") else {
            fatalError("Asset could not be located")
        }
        return url
    }
}
