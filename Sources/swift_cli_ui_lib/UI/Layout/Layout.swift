/**    
CLI UI Library to easly draw UI in terminal. Developed using Swift language
Copyright (C) 2025  Kosolobov Alexandr Petrovich

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

/// Layout Protocol
protocol Layout {
    func layoutSubviews(of container: ContainerView)
}

struct StackLayout: Layout {
    var axis: Axis
    var spacing: Int = 1
    
    enum Axis {
        case horizontal, vertical
    }
    
    func layoutSubviews(of container: ContainerView) {
        var currentOrigin = container.frame.origin
        
        for view in container.subviews {
            view.frame.origin = currentOrigin // TODO
            
            switch axis {
            case .horizontal:
                currentOrigin.x += view.size.width + spacing
            case .vertical:
                currentOrigin.y += view.size.height + spacing
            }
        }
    }
}

class ContainerView: ViewBase {
    var subviews: [View] = []
    var layout: Layout?
    
    func addSubview(_ view: View) {
        subviews.append(view)
        setNeedsLayout()
    }
    
    func setNeedsLayout() {
        needsDisplay = true
        layout?.layoutSubviews(of: self)
    }
    
    override func draw(in screenBounds: Rect, renderer: Renderer) {
        super.draw(in: screenBounds, renderer: renderer)
        
        for view in subviews {
            view.draw(in: screenBounds, renderer: renderer)
        }
    }
}