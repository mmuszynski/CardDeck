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
        XCTAssertEqual(PlayingCard(suit: .club, rank: .ace), PlayingCard("Ace of Clubs"))
        XCTAssertEqual(PlayingCard(suit: .spade, rank: .two), PlayingCard("Two♠"))
        XCTAssertEqual(PlayingCard(suit: .spade, rank: .two), PlayingCard("2♠"))
        XCTAssertEqual(PlayingCard(suit: .spade, rank: .two), PlayingCard("Two of ♠"))
        XCTAssertEqual(PlayingCard(suit: .spade, rank: .two), PlayingCard("Two of Spades"))

        //face cards
        XCTAssertEqual(PlayingCard(suit: .diamond, rank: .jack), PlayingCard("Jack of Diamonds"))
        XCTAssertEqual(PlayingCard(suit: .diamond, rank: .jack), PlayingCard("J of Diamonds"))
        XCTAssertEqual(PlayingCard(suit: .diamond, rank: .jack), PlayingCard("J of ♦"))
        XCTAssertEqual(PlayingCard(suit: .diamond, rank: .jack), PlayingCard("Jack of ♦"))
        
        XCTAssertEqual(PlayingCard(suit: .heart, rank: .queen), PlayingCard("Queen of Hearts"))
        XCTAssertEqual(PlayingCard(suit: .heart, rank: .queen), PlayingCard("Q of Hearts"))
        XCTAssertEqual(PlayingCard(suit: .heart, rank: .queen), PlayingCard("Queen of ♥"))
        XCTAssertEqual(PlayingCard(suit: .heart, rank: .queen), PlayingCard("Q of ♥"))
        
        XCTAssertEqual(PlayingCard(suit: .club, rank: .king), PlayingCard("King of Clubs"))
        XCTAssertEqual(PlayingCard(suit: .club, rank: .king), PlayingCard("K of Clubs"))
        XCTAssertEqual(PlayingCard(suit: .club, rank: .king), PlayingCard("King of ♣"))
        XCTAssertEqual(PlayingCard(suit: .club, rank: .king), PlayingCard("K of ♣"))
        
    }
    
    func testSort() {
        var hand = PlayingCard.emptyDeck
        hand.append(PlayingCard(suit: .spade, rank: .ace))
        hand.append(PlayingCard(suit: .spade, rank: .five))
        hand.append(PlayingCard(suit: .spade, rank: .ten))
        hand.append(PlayingCard(suit: .diamond, rank: .two))
        hand.append(PlayingCard(suit: .diamond, rank: .jack))
        hand.append(PlayingCard(suit: .heart, rank: .three))
        
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
