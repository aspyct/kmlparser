//
//  KmlTextParser.swift
//  DATS Finder
//
//  Created by Antoine d'Otreppe on 02/10/14.
//  Copyright (c) 2014 Aspyct.org. All rights reserved.
//

import Foundation

class KmlTextParser : NSObject, NSXMLParserDelegate {
    let onFinish: (String) -> ()
    var foundString = ""
    
    init(onFinish: (String) -> ()) {
        self.onFinish = onFinish
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        foundString += string
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String!, qualifiedName qName: String!) {
        onFinish(foundString)
    }
}