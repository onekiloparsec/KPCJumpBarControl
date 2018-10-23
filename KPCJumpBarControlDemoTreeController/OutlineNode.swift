//
//  OutlineNode.swift
//  iObserve2
//
//  Created by Cédric Foellmi on 04/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import AppKit

@objcMembers class OutlineNode: NSObject {
    let uuid: UUID
    
    var title: String = ""
    var subtitle: String = ""
    var notes: String = ""
    var icon: NSImage? = nil
    var childNodes: [OutlineNode] = []
    weak var parentNode: OutlineNode? = nil
    
    // MARK: - Constructors
    
    init(_ title: String) {
        self.uuid = UUID()
        self.title = title
    }
    
    // Outline
    
    var isLeaf: Bool {
        get { return self.outlineChildren.count == 0 }
    }
    
    var isRoot: Bool {
        get { return self.title.starts(with: "root") }
    }

    var outlineChildren: NSMutableArray {
        get { return NSMutableArray(array: self.childNodes) }
        set { self.childNodes = newValue.map {$0} as! [OutlineNode] }
    }
    
    // MARK: - SearchableOutlineView

    var originalChildNodes: [OutlineNode] = []

    func searchableContent() -> String {
        return self.title + self.subtitle
    }

}

