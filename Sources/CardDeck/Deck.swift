struct Deck<Element: Card>: Equatable {
    typealias Element = Element
    private var cards: [Element] = []
    
    internal init(cards: [Element]) {
        self.cards = cards
    }
    
    /// Shuffles the `Cards` in the `Deck`.
    ///
    /// Simply shuffles the array that contains the `Card` objects.
    mutating func shuffle() {
        self.cards.shuffle()
    }
    
    /// Deals an equal number of cards from this `Deck` into each recipient `Deck` or as many as possible until this `Deck` is empty.
    ///
    /// - Parameters:
    ///   - count: The number of cards to deal into each deck
    ///   - decks: The decks that will receive the cards.
    mutating func deal(_ count: Int, into decks: inout [Deck<Element>]) {
        for _ in 0..<count {
            for i in 0..<decks.count {
                if let card = self.cards.popLast() {
                    decks[i].append(card)
                }
            }
        }
    }
}

extension Deck: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init(cards: elements)
    }
    
    typealias ArrayLiteralElement = Element
}

extension Deck: RangeReplaceableCollection, BidirectionalCollection, MutableCollection, RandomAccessCollection {
    typealias Index = Array<Element>.Index
    
    init() {}
    
    var startIndex: Deck.Index {
        return cards.startIndex
    }
    
    var endIndex: Deck.Index {
        return cards.endIndex
    }
    
    subscript(position: Index) -> Deck.Element {
        get {
            return cards[position]
        }
        set {
            cards[position] = newValue
        }
    }
    
    func index(before i: Deck.Index) -> Deck.Index {
        return cards.index(before: i)
    }
    
    func index(after i: Deck.Index) -> Deck.Index {
        return cards.index(after: i)
    }
    
    mutating func replaceSubrange<C>(_ subrange: Range<Array<Element>.Index>, with newElements: C) where C : Collection, Self.Element == C.Element {
        cards.replaceSubrange(subrange, with: newElements)
    }
    
    @inlinable public func shuffled() -> Deck<Element> {
        return Deck<Element>(cards.shuffled())
    }
    
    @inlinable public func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Deck<Element> {
        return Deck<Element>(try cards.sorted(by: areInIncreasingOrder))
    }
}
