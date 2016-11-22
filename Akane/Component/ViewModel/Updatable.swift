//
// This file is part of Akane
//
// Created by JC on 17/04/16.
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code
//

import Foundation

var UpdatableOnRenderAttr = "UpdatableOnRenderAttr"

public protocol Updatable : class, _HasAssociatedObjects {
    func setNeedsUpdate()
}

extension Updatable {
    var onRender: ((Void) -> Void)? {
        get { return self._associatedObjects[UpdatableOnRenderAttr] as? ((Void) -> Void) }
        set { self._associatedObjects[UpdatableOnRenderAttr] = onRender }
    }

    func setNeedsUpdate() {
        self.onRender?()
    }
}
