import XCTest
@testable import CardDeck

final class PlayingCardTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(PlayingCard.fullDeck.count, 52)
        
        var deck = PlayingCard.fullDeck
        deck.shuffle()
        
        var hands = Array<Deck<PlayingCard>>(repeating: Deck<PlayingCard>(), count: 4)
        
        deck.deal(5, into: &hands)
        XCTAssertEqual(hands[0].count, 5)
        XCTAssertEqual(hands[1].count, 5)
        XCTAssertEqual(hands[2].count, 5)
        XCTAssertEqual(hands[3].count, 5)
        
        let dealtCards = hands.reduce(Deck<PlayingCard>()) { (pile, deck) -> Deck<PlayingCard> in
            return pile + deck
        }
        
        XCTAssertTrue(Set(dealtCards).isDisjoint(with: Set(deck)))
        XCTAssertEqual(deck.count, 52 - 20)
    }
    
    func testStringLiteral() {
        //♠, ♦, ♣, ♥
        XCTAssertEqual(PlayingCard(rank: .ace, suit: .club), PlayingCard("Ace of Clubs"))
        XCTAssertEqual(PlayingCard(rank: .two, suit: .spade), PlayingCard("Two♠"))
        XCTAssertEqual(PlayingCard(rank: .two, suit: .spade), PlayingCard("2♠"))
        XCTAssertEqual(PlayingCard(rank: .two, suit: .spade), PlayingCard("Two of ♠"))
        XCTAssertEqual(PlayingCard(rank: .two, suit: .spade), PlayingCard("Two of Spades"))

        //face cards
        XCTAssertEqual(PlayingCard(rank: .jack, suit: .diamond), PlayingCard("Jack of Diamonds"))
        XCTAssertEqual(PlayingCard(rank: .jack, suit: .diamond), PlayingCard("J of Diamonds"))
        XCTAssertEqual(PlayingCard(rank: .jack, suit: .diamond), PlayingCard("J of ♦"))
        XCTAssertEqual(PlayingCard(rank: .jack, suit: .diamond), PlayingCard("Jack of ♦"))
        
        XCTAssertEqual(PlayingCard(rank: .queen, suit: .heart), PlayingCard("Queen of Hearts"))
        XCTAssertEqual(PlayingCard(rank: .queen, suit: .heart), PlayingCard("Q of Hearts"))
        XCTAssertEqual(PlayingCard(rank: .queen, suit: .heart), PlayingCard("Queen of ♥"))
        XCTAssertEqual(PlayingCard(rank: .queen, suit: .heart), PlayingCard("Q of ♥"))
        
        XCTAssertEqual(PlayingCard(rank: .king, suit: .club), PlayingCard("King of Clubs"))
        XCTAssertEqual(PlayingCard(rank: .king, suit: .club), PlayingCard("K of Clubs"))
        XCTAssertEqual(PlayingCard(rank: .king, suit: .club), PlayingCard("King of ♣"))
        XCTAssertEqual(PlayingCard(rank: .king, suit: .club), PlayingCard("K of ♣"))
        
    }
    
    func testSort() {
        var hand = PlayingCard.emptyDeck
        hand.append(PlayingCard(rank: .ace, suit: .spade))
        hand.append(PlayingCard(rank: .five, suit: .spade))
        hand.append(PlayingCard(rank: .ten, suit: .spade))
        hand.append(PlayingCard(rank: .two, suit: .diamond))
        hand.append(PlayingCard(rank: .jack, suit: .diamond))
        hand.append(PlayingCard(rank: .three, suit: .heart))
        
        let defaultOrder = PlayingCard.order(rankOrder: PlayingCard.Rank.defaultOrder, suitOrder: PlayingCard.Suit.defaultOrder, ascending: true)
        let sorted = hand.shuffled().sorted(by: defaultOrder)
        XCTAssertEqual(hand, sorted)
        
        let ace = hand.removeFirst()
        hand.insert(ace, at: 2)
        let acesHigh = PlayingCard.order(rankOrder: PlayingCard.Rank.acesHigh, suitOrder: PlayingCard.Suit.defaultOrder, ascending: true)
        XCTAssertEqual(hand, hand.shuffled().sorted(by: acesHigh))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
