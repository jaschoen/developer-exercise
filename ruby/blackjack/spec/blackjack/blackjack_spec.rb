require 'spec_helper'

describe Game do 
	let(:deck)        { Deck.new }
	let(:game)        { Game.new }

	describe "#deal" do 
		it "deals 2 cards to player_hand" do
			game.deal
			expect(game.player_hand.cards.size).to eq(2)
		end
		it "deals 2 cards to dealer_hand" do
			game.deal
			expect(game.dealer_hand.cards.size).to eq(2)
		end
		it "removes dealt cards from the deck" do 
			game.deal
			expect(game.deck.playable_cards.size).to eq(48)
		end
	end

	describe "#hit_player" do 
		it "adds a card to the player hand" do
			game.deal
			game.hit_player 
			expect(game.player_hand.cards.size).to eq(3)
		end
	end

	describe "#hit_dealer" do 
		it "adds a card to the dealer hand" do
			game.deal
			game.hit_dealer 
			expect(game.dealer_hand.cards.size).to eq(3)
		end
	end

	describe "#bust?(hand)" do 
		it "returns true if player total is 22+" do 
			hand = game.player_hand
			hand.cards << Card.new(:hearts, :four,  4 )
			hand.cards << Card.new(:spades, :eight, 8 )
			hand.cards << Card.new(:clubs,  :ten,   10)
			expect(game.bust?(hand)).to be_truthy
		end

		it "returns false if total is 21-" do 
			hand = game.player_hand
			hand.cards << Card.new(:spades, :eight, 8 )
			hand.cards << Card.new(:clubs,  :ten,   10)
			expect(game.bust?(hand)).to be_falsy
		end
	end

	describe "#blackjack?(hand)" do 
		it "returns true if hand total is exactly 21" do 
			hand = game.player_hand 
			hand.cards << Card.new(:spades, :Ace, 11)
			hand.cards << Card.new(:clubs,  :ten, 10)
			expect(game.blackjack?(hand)).to be_truthy
		end
		it "returns false if hand total is not 21" do 
			hand = game.player_hand 
			hand.cards << Card.new(:spades, :four, 4)
			hand.cards << Card.new(:clubs,  :ten, 10)
			expect(game.blackjack?(hand)).to be_falsy
		end
	end
end
describe Deck do 
	let(:deck)        { Deck.new }
	it "initializes the deck with 52 cards" do
		expect(deck.playable_cards.size).to eq(52)
	end
end

describe Player_hand do
	let(:player_hand) { Player_hand.new }
	it "initializes with 0 cards" do 
		expect(player_hand.cards.size).to eq(0)
	end
	describe "#count" do 
		it "returns hand value" do
			player_hand.cards << Card.new(:hearts, :three, 3)
			player_hand.cards << Card.new(:spades, :eight, 8)
			expect(player_hand.count).to eq(11)
		end
	end
end

describe Dealer_hand do
	let(:dealer_hand) { Dealer_hand.new }
	
	it "initializes with 0 cards" do 
		expect(dealer_hand.cards.size).to eq(0)
	end

	describe "#count" do 
		it "returns hand value" do
			dealer_hand.cards << Card.new(:hearts, :three, 3)
			dealer_hand.cards << Card.new(:spades, :eight, 8)
			expect(dealer_hand.count).to eq(11)
		end
	end
end

describe Console do 
	let(:ui) { Console.new}
	describe "#welcome" do
		it "Outputs a welcome message" do
			expect {ui.welcome}.to output("Welcome to Blackjack, good luck!\n").to_stdout
		end
	end
	describe "#prompt_for_action" do
		it "prompts hit or stay" do 
			expect {ui.prompt_for_action}.to output("Press 1 for hit and 2 for stay\n").to_stdout
		end
	end
	describe "#dealer_showing(hand)" do 
		it "outputs one dealer card" do 
			hand = Dealer_hand.new
			hand.cards << Card.new(:spades, :eight, 8)
			expect {ui.dealer_showing(hand)}.to output("Dealer is showing the \n" + 
				                                         "eight of spades\n\n").to_stdout
		end
	end
	describe "#player_showing(hand)" do 
		it "outputs player hand" do 
			hand = Player_hand.new
			hand.cards << Card.new(:hearts, :three, 3)
			hand.cards << Card.new(:spades, :eight, 8)
			expect {ui.player_showing(hand)}.to output("Player cards are:\n" +
																									 "three of hearts\n" +
																									 "eight of spades\n\n").to_stdout
		end
	end
	# describe "#you_lose" do
	# 	it "outputs 'Dealer wins this one, maybe you're better at slot machines." do 
	# 		expect {ui.you_lose}.to output("Dealer wins this one, maybe you're better at slot machines.\n").to_stdout
	# 	end
	# end
	# describe "#you_win" do
	# 	it "outputs 'You win! Well played." do 
	# 		expect {ui.you_lose}.to output("\n").to_stdout
	# 	end
	# end	
	# describe "#get_player_move" do
	# 	it "gets player move" do 

	# 	end
	# end
	describe "#output_point_total(hand)" do
		it "outputs ' total is 11' when hand is 8 and 3" do 
			hand = Player_hand.new
			hand.cards << Card.new(:hearts, :three, 3)
			hand.cards << Card.new(:spades, :eight, 8)
			expect {ui.output_point_total(hand)}.to output("====================\n" + 
				                                             "point total is 11\n\n").to_stdout
		end
	end
	describe "#player_stays" do
		it "outputs player stays" do 
			expect {ui.player_stays}.to output("Player stays\n").to_stdout
		end
	end		
end
