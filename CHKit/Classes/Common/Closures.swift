//
//  Closures.swift
//  Runner
//
//  Created by wbitos on 2019/7/24.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import UIKit

open class Closures: NSObject {
    public typealias Action<T> = (T) -> Void
    public typealias Default<R> = () -> R
    public typealias Status = (Bool) -> Void
    public typealias Custom<T, R> = (T) -> R
    public typealias UserInfo<T> = (T, [AnyHashable: Any]?) -> Void
    
    public typealias ActionCallback<T, E> = (T, Closures.Action<E>?) -> Void

}
