//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit

public extension LMRowView {
    public convenience init(margin: CGFloat? = .nan,
        topMargin: CGFloat? = .nan,
        leadingMargin: CGFloat? = .nan,
        bottomMargin: CGFloat? = .nan,
        trailingMargin: CGFloat? = .nan,
        horizontalAlignment: LMHorizontalAlignment = .fill,
        verticalAlignment: LMVerticalAlignment = .fill,
        spacing: CGFloat = 0,
        isAlignToBaseline: Bool = false,
        baseline: LMBaseline = .first,
        _ subviews: [UIView] = [],
        _ callback: ((LMRowView) -> Void)? = nil) {
        self.init(margin: margin,
            topMargin: topMargin,
            leadingMargin: leadingMargin,
            bottomMargin: bottomMargin,
            trailingMargin: trailingMargin)

        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
        self.isAlignToBaseline = isAlignToBaseline
        self.baseline = baseline

        for view in subviews {
            addSubview(view)
        }

        callback?(self)
    }
}