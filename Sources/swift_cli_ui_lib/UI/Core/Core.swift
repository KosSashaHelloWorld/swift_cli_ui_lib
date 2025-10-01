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

import Foundation

// MARK: - Core Protocols
protocol Drawable
{
    func draw(in screenBounds: Rect, renderer: Renderer)
    var size: Size { get }
}

protocol View: Drawable
{
    var frame: Rect { get set }
    var needsDisplay: Bool { get set }
}

// MARK: - Core Types
struct Size
{
    var width: Int
    var height: Int

    static let zero: Size = Size(width: 0, height: 0)
}

struct Point
{
    var x: Int
    var y: Int
}

struct Rect
{
    var origin: Point
    var size: Size
}

// MARK: - ANSI Renderer
class Renderer
{
    private var buffer: [String] = []

    func clearScreen()
    {
        buffer.append(ANSIFunc.clear.rawValue)
    }

    func moveCursor(to point: Point)
    {
        buffer.append("\u{001B}[\(point.y + 1);\(point.x + 1)H")
    }

    func setColor(_ color: ANSIColor)
    {
        buffer.append(color.rawValue)
    }

    func write(_ text: String)
    {
        buffer.append(text)
    }

    func flush()
    {
        print(buffer.joined(), terminator: "")
        buffer.removeAll()
    }
}

// MARK: - ANSI Colors
enum ANSIColor: String {
    case black =    "\u{001B}[30m"
    case red =      "\u{001B}[31m"
    case green =    "\u{001B}[32m"
    case yellow =   "\u{001B}[33m"
    case blue =     "\u{001B}[34m"
    case magenta =  "\u{001B}[35m"
    case cyan =     "\u{001B}[36m"
    case white =    "\u{001B}[37m"
    case reset =    "\u{001B}[0m"
}

// MARK: - ANSI Functios
enum ANSIFunc: String
{
    case clear =    "\u{001B}[2J"
}