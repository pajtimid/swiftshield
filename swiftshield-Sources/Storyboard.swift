import Foundation

class Storyboard {
    static func customClass(`class`: String) -> String {
        return "customClass=\"\(`class`)\""
    }
    
    static func storyboardIdentifier(`class`: String) -> String {
        return "storyboardIdentifier=\"\(`class`)\""
    }

    static func actionSelector(method: String) -> String {
        return "action selector=\"\(method):\""
    }
}
