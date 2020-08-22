public struct Deck<Element: Card>: Equatable {
    public typealias Element = Element
    internal var cards: [Element] = []
    
    internal init(cards: [Element]) {
        self.cards = cards
    }
    
    /// Shuffles the `Cards` in the `Deck`.
    ///
    /// Simply shuffles the array that contains the `Card` objects.
    public mutating func shuffle() {
        self.cards.shuffle()
    }
    
    /// Deals an equal number of cards from this `Deck` into each recipient `Deck` or as many as possible until this `Deck` is empty.
    ///
    /// - Parameters:
    ///   - count: The number of cards to deal into each deck
    ///   - decks: The decks that will receive the cards.
    public mutating func deal(_ count: Int, into decks: inout [Deck<Element>]) {
        for _ in 0..<count {
            for i in 0..<decks.count {
                if let card = self.cards.popLast() {
                    decks[i].append(card)
                }
            }
        }
    }
    
    public static var empty: Deck<Element> {
        return Deck<Element>()
    }
}

extension Deck: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.init(cards: elements)
    }
    
    public typealias ArrayLiteralElement = Element
}

extension Deck: RangeReplaceableCollection, BidirectionalCollection, MutableCollection, RandomAccessCollection {
    public typealias Index = Array<Element>.Index
    
    public init() {}
    
    public var startIndex: Deck.Index {
        return cards.startIndex
    }
    
    public var endIndex: Deck.Index {
        return cards.endIndex
    }
    
    public subscript(position: Index) -> Deck.Element {
        get {
            return cards[position]
        }
        set {
            cards[position] = newValue
        }
    }
    
    public func index(before i: Deck.Index) -> Deck.Index {
        return cards.index(before: i)
    }
    
    public func index(after i: Deck.Index) -> Deck.Index {
        return cards.index(after: i)
    }
    
    mutating public func replaceSubrange<C>(_ subrange: Range<Array<Element>.Index>, with newElements: C) where C : Collection, Self.Element == C.Element {
        cards.replaceSubrange(subrange, with: newElements)
    }
    
    public func shuffled() -> Deck<Element> {
        return Deck<Element>(cards.shuffled())
    }
    
    public func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Deck<Element> {
        return Deck<Element>(try cards.sorted(by: areInIncreasingOrder))
    }
}
