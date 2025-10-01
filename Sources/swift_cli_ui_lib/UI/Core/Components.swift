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

// MARK: - Base View
class ViewBase: View
{
    var frame: Rect
    var needsDisplay: Bool = true
    var backgroundColor: ANSIColor?

    init (frame: Rect)
    {
        self.frame = frame
    }

    var size: Size { frame.size }

    func draw(in screenBounds: Rect, renderer: Renderer)
    {
        if let color = backgroundColor
        {
            renderer.setColor(color)
            for y in 0..<frame.size.height
            {
                renderer.moveCursor(to: Point(x: frame.origin.x, y: frame.origin.y + y))
                renderer.write(String(repeating: " ", count: frame.size.width))
            }
            renderer.setColor(.reset)
        }
    }
}

// MARK: - Label
class Label: ViewBase
{
    var text: String
    var textColor: ANSIColor = .white

    init(frame: Rect, text: String)
    {
        self.text = text
        super.init(frame: frame)
    }

    override func draw(in screenBounds: Rect, renderer: Renderer)
    {
        super.draw(in: screenBounds, renderer: renderer)

        let drawRect = frame.intersection(screenBounds) // TODO
        guard drawRect.size.width > 0, drawRect.size.height > 0 else { return }

        renderer.setColor(textColor)
        renderer.moveCursor(to: frame.origin)

        let visibleText = String(text.prefix(frame.size.width))
        renderer.write(visibleText)
        renderer.setColor(.reset)
    }
}


// MARK: - Button
class Button: ViewBase
{
    var title: String
    var action: () -> Void
    var isHighlighted = false

    init(frame: Rect, title: String, action: @escaping () -> Void)
    {
        self.title = title
        self.action = action
        super.init(frame: frame)
    }

    override func draw(in screenBounds: Rect, renderer: Renderer)
    {
        super.draw(in: screenBounds, renderer: renderer)
        
        let drawRect = frame.intersection(screenBounds) // TODO
        guard drawRect.size.width > 0, drawRect.size.height > 0 else { return }
        
        renderer.moveCursor(to: frame.origin)
        
        if isHighlighted {
            renderer.setColor(.blue)
            renderer.write("[\(title)]")
            renderer.setColor(.reset)
        } else {
            renderer.write(" \(title) ")
        }
    }
}