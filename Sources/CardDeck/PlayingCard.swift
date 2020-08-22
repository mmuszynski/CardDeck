//
//  File.swift
//  
//
//  Created by Mike Muszynski on 8/9/20.
//

import Foundation

public struct PlayingCard: Card {
    
    /// The suits available in a deck of playing cards
    public enum Suit: CaseIterable {
        case spade, diamond, club, heart
        
        /// A default order to use for suits
        public static var defaultOrder: [Suit] {
            [.spade, .diamond, .club, .heart]
        }
    }
    
    /// The ranks available in a deck of playing cards
    public enum Rank: CaseIterable {
        case ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
        
        /// A default order to use for ranks. Treats aces as low.
        public static var defaultOrder: [Rank] {
            [.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king]
        }
        
        /// An ordering system where Aces are the highest value, but otherwise the default order is used.
        public static var acesHigh: [Rank] {
            var order = defaultOrder
            let ace = order.removeFirst()
            order.append(ace)
            return order
        }
    }
    
    /// The card's suit
    public var suit: Suit
    
    /// The card's rank
    public var rank: Rank
    
    /// An empty deck (i.e. a deck with no cards in it)
    public static var emptyDeck = Deck<PlayingCard>()
    
    /// A full deck (i.e. a deck with all combinations of suits and ranks)
    public static var fullDeck: Deck<PlayingCard> {
        var cards = [PlayingCard]()
        for suit in PlayingCard.Suit.allCases {
            for rank in PlayingCard.Rank.allCases {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
        
        return Deck(cards: cards)
    }
    
    /// A closure builder for sorting cards by rank and suit
    /// - Parameters:
    ///   - rankOrder: The order in which to sort the cards by rank
    ///   - suitOrder: The order in which to sort the cards by suit
    ///   - ascending: True for ascending order, false for descending
    /// - Returns: A closure used to sort a deck of cards
    public static func order(rankOrder: [PlayingCard.Rank], suitOrder: [PlayingCard.Suit], ascending: Bool) -> ((PlayingCard, PlayingCard) -> Bool) {
        return { (card1, card2) -> Bool in
            let rank1 = rankOrder.firstIndex(of: card1.rank) ?? 0
            let rank2 = rankOrder.firstIndex(of: card2.rank) ?? 0
            let suit1 = suitOrder.firstIndex(of: card1.suit) ?? 0
            let suit2 = suitOrder.firstIndex(of: card2.suit) ?? 0
            
            if suit1 == suit2 {
                if ascending {
                    return rank1 < rank2
                } else {
                    return rank1 > rank2
                }
            } else {
                if ascending {
                    return suit1 < suit2
                } else {
                    return suit1 > suit2
                }
            }
        }
    }
    
    public static var defaultAscendingOrder: ((PlayingCard, PlayingCard) -> Bool) {
        return PlayingCard.order(rankOrder: Rank.defaultOrder, suitOrder: Suit.defaultOrder, ascending: true)
    }
    
    public static var defaultDescendingOrder: ((PlayingCard, PlayingCard) -> Bool) {
        return PlayingCard.order(rankOrder: Rank.defaultOrder, suitOrder: Suit.defaultOrder, ascending: false)
    }
}

/// Allows for the initialization of `PlayingCard` objects by String literals.
///
/// This is not a natural language parsing. Instead, you have two options that will currently work, as described in these two examples:
/// 1. Ace of Spades
/// 2. A♠
extension PlayingCard: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral: Self.StringLiteralType) {
        guard let card = PlayingCard(string: stringLiteral) else {
            fatalError("Couldn't create Playing Card from string: \(stringLiteral)")
        }
        
        self = card
    }
    
    init?(string: String) {
        let components = string.components(separatedBy: " of ")
        
        var rankString = ""
        var suitString = ""
        
        if components.count == 2 {
            rankString = components[0]
            suitString = components[1]
        } else {
            var string = string
            guard let suitCharacter = string.popLast() else {
                return nil
            }
            
            suitString = String(suitCharacter)
            rankString = string
        }
        
        guard
            let rank = PlayingCard.Rank(string: rankString),
            let suit = PlayingCard.Suit(string: suitString)
        else {
            return nil
        }
        
        self = PlayingCard(suit: suit, rank: rank)
    }
}

extension PlayingCard: CustomStringConvertible {
    public var description: String {
        return self.rank.debugDescription + self.suit.debugDescription
    }
}

extension PlayingCard: CustomDebugStringConvertible {
    public var debugDescription: String {
        return self.rank.debugDescription + self.suit.debugDescription
    }
}

extension PlayingCard.Suit: CustomDebugStringConvertible {
    init?(string: String) {
        switch string.lowercased() {
        case "♠", "spades", "spade", "s":
            self = .spade
        case "♦", "diamonds", "diamond", "d":
            self = .diamond
        case "♣", "club", "clubs", "c":
            self = .club
        case "♥", "hearts", "heart", "h":
            self = .heart
        default:
            return nil
        }
    }
    
    public var debugDescription: String {
        switch self {
        case .spade:
            return "♠"
        case .diamond:
            return "♦"
        case .club:
            return "♣"
        case .heart:
            return "♥"
        }
    }
}

extension PlayingCard.Rank: CustomDebugStringConvertible {
    init?(string: String) {
        switch string.lowercased() {
        case "ace", "1", "a":
            self = .ace
        case "two", "2":
            self = .two
        case "three", "3":
            self = .three
        case "four", "4":
            self = .four
        case "five", "5":
            self = .five
        case "six", "6":
            self = .six
        case "seven", "7":
            self = .seven
        case "eight", "8":
            self = .eight
        case "nine", "9":
            self = .nine
        case "ten", "10", "t":
            self = .ten
        case "jack", "j":
            self = .jack
        case "queen", "q":
            self = .queen
        case "king", "k":
            self = .king
        default:
            return nil
        }
    }
    
    public var debugDescription: String {
        switch self {
        case .ace:
            return "A"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .ten:
            return "10"
        case .jack:
            return "J"
        case .queen:
            return "Q"
        case .king:
            return "K"
        }
    }
}
