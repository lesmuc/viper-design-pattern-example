//
//  PersistenceError.swift
//  viper42
//
//  Created by Udo von Eynern on 09.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

import Foundation

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
}

