
import UIKit

public typealias AttributedString = NSAttributedString

typealias AttributeTuple = (key: AttributedString.Key, value: Any)

func attributeTuple(for attribute: AttributedString.Builder.Attribute) -> AttributeTuple {
    switch attribute {
    case .font(let value):
        return (key: .font, value: value)
    case .text(let color):
        return (key: .foregroundColor, value: color)
    case .background(let color):
        return (key: .backgroundColor, value: color)
    }
}

func attributesDictionary(from attributesTuple: [AttributeTuple]) -> [AttributedString.Key: Any] {
    return attributesTuple.reduce(into: [AttributedString.Key: Any]()) { (dict, tuple) in dict[tuple.key] = tuple.value }
}

// MARK: - AttributedString

public extension AttributedString {

    /// `Builder` is a class that allows building `AttributedString` instances easily.
    public class Builder {

        private(set) var attributedString: NSMutableAttributedString = NSMutableAttributedString()

        public init() {} // empty initializer

        public enum Attribute {
            case font(UIFont)
            case text(color: UIColor)
            case background(color: UIColor)
        }


        /// The actual `build` function which returns the built `AttributedString`.
        ///
        /// - Returns: the built `AttributedString`
        public func build() -> AttributedString {
            return attributedString
        }

        /// Receives a **text** and the **attributes** for the given **text**.
        ///
        /// - Parameters:
        ///   - text: the string to add
        ///   - attributes: the attributes for the given text
        /// - Returns: a `Builder` reference
        public func text(_ text: String, attributes: [Attribute] = []) -> Builder {
            attributedString.append(
                AttributedString(
                    string: text,
                    attributes: attributesDictionary(from: attributes.map(attributeTuple))
                )
            )
            return self
        }

        /// Adds a **space** with the given **attributes**.
        ///
        /// - Parameter attributes: the attributes for the **space**
        /// - Returns: a `Builder` reference
        public func space(attributes: [Attribute] = []) -> Builder {
            return text(" ", attributes: attributes)
        }

        /// Adds the indicated **spaces**.
        ///
        /// The `number` parameter is of `UInt` type. This is to reduce possible issues when passing negative numbers by mistake.
        ///
        /// - Parameters:
        ///   - number: the number of spaces to add
        ///   - attributes: the attributes for the **spaces**
        /// - Returns: a `Builder` reference
        public func spaces(_ number: UInt, attributes: [Attribute] = []) -> Builder {
            for _ in 0..<number {
                _ = space(attributes: attributes)
            }
            return self
        }

    }

}
