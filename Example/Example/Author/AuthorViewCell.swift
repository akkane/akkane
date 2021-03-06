//
//  AuthorViewCell.swift
//  Example
//
//  Created by Martin MOIZARD-LANVIN on 15/09/16.
//  Copyright © 2016 Akane. All rights reserved.
//

import UIKit
import Akane

class AuthorViewCell: UITableViewCell, Displayable {
   @IBOutlet var title: UILabel!
   
   func bindings(_ observer: ViewObserver, params: Author) {
        self.title.text = params.name
   }
}
