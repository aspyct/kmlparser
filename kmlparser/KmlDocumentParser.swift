//
//  RootKmlParser.swift
//  DATS Finder
//
//  Created by Antoine d'Otreppe on 02/10/14.
//  Copyright (c) 2014 Aspyct.org. All rights reserved.
//

import Foundation

class KmlDocumentParser : NSObject, NSXMLParserDelegate {
    let onPlacemark: (KmlPlacemark) -> ()
    
    var currentSubparser: NSXMLParserDelegate?
    
    init(onPlacemark: (KmlPlacemark) -> ()) {
        self.onPlacemark = onPlacemark
    }
    
    // https://stackoverflow.com/questions/25793940/parser-parse-in-swift-leads-to-exc-bad-access/25797967#25797967
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]) {
        if elementName == "Placemark" {
            self.currentSubparser = KmlPlacemarkParser({ (placemark) -> () in
                self.onPlacemark(placemark)
                
                parser.delegate = self
            })
            
            parser.delegate = self.currentSubparser
        }
    }
}