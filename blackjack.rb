#!/usr/bin/env ruby
puts "Hi welcome to Blackjack"
def main
  @deck =  (1..52).to_a.shuffle  #deck creates a fresh random deck
  @playerHand = [@deck.pop,@deck.pop]  #players initial hand
  @dealerHand = [@deck.pop,@deck.pop]  #dealers initial hand
  puts "You have the " + identCard(@playerHand[0]) + " and the " + identCard(@playerHand[1]) + " for a score of " + scoreHand(@playerHand).to_s
  puts "Dealer shows the #{identCard(@dealerHand[0])}"  
  loop do
    puts "Would you like to (h)it, (s)tand or (q)uit?"
    answer = gets().downcase.strip
    case 
      when answer == "q"
        break
      when answer == "h"
        playerHit
        break if scoreHand(@playerHand) > 21#not sure why I need this, if I put it in the playerHit method I error.
      when answer == "s"
        playerStand
        break
    end #end case
  end #end loop
  puts "Would you like to play again? (y/n)"
  replay = gets().downcase.strip
  main if replay == "y"
end #end main
def getValue(card)# This function takes a card as a parameter and returns the value of that card
  case card%13
    when 0,11,12 then return 10
    when 1 then return 11 
    else return card%13
    end #end case
end #end getValue 
def identCard(card) #given a card numb(1..52) identifies the face and suit of that card
  suit = (case (card-1)/13
          when 0 then " of hearts"
          when 1 then " of clubs"
          when 2 then " of diamonds"
          when 3 then " of spades"
          else raise StandardError
          end)  #end case
  case card%13
    when 1 then return "Ace" + suit
    when 11 then return "Jack" + suit
    when 12 then return "Queen" + suit
    when 0 then return "King" + suit
    else return (card%13).to_s + suit
  end #end case
end #end identCard
def scoreHand(hand) #determines the score of the hand
  total=0
  aceCount=0
  hand.each  do |i|
    aceCount+=1 if i%13==1
    total+=getValue(i)
    while total>21 do
      if aceCount>0 then
       total = total-10
       aceCount-=1
      end #end if
      break if aceCount == 0
    end #end while     
  end #end do
  total 
end #end scorehand
def playerHit
  @playerHand<<@deck.pop
  puts "You drew the " + identCard(@playerHand[@playerHand.length - 1])
  puts "Your score is now " + scoreHand(@playerHand).to_s
  puts "Bust! You lose." if scoreHand(@playerHand)> 21
end #end playerhit
def playerStand
  puts "You stand with a score of " + scoreHand(@playerHand).to_s
  puts "Dealer shows the " + identCard(@dealerHand[0]) + " and the " + identCard(@dealerHand[1]) + " for a score of " + scoreHand(@dealerHand).to_s
  puts "Dealer stands" if scoreHand(@dealerHand)>16
  while scoreHand(@dealerHand)<17
    @dealerHand<<@deck.pop
    puts "Dealer drew the #{identCard(@dealerHand[@dealerHand.length - 1])}" 
    puts "Dealer's score is now #{scoreHand(@dealerHand).to_s}"  
    puts "Dealer busts!" if scoreHand(@dealerHand)>21
  end #end while
  if scoreHand(@dealerHand) > scoreHand(@playerHand) && scoreHand(@dealerHand)<22  then puts "you lose"
  elsif scoreHand(@dealerHand) < scoreHand(@playerHand) || scoreHand(@dealerHand)>21 then puts "you win!"
  else puts "draw"
  end #end if
end #end playerStand
main  #executues main program