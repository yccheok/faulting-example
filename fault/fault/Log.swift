//
//  Log.swift
//  fault
//
//  Created by Yan Cheng Cheok on 22/01/2022.
//

import Foundation
import os.log

func error_log(_ error: Error) {
    os_log("%@", log: OSLog.default, type: .error, String(describing: error))
}
