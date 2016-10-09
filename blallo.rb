#!/usr/bin/ruby
# encoding: utf-8

require 'telegram/bot'

#path assoluto della cartella in cui risiede lo script
absolute_path = ARGV[0]
TOKEN = ""

Telegram::Bot::Client.run(TOKEN) do |bot|
	bot.listen do |message|
		case message
		when Telegram::Bot::Types::InlineQuery

			#-------------------------------------------
			#RICERCA BALLO
			if message.to_s.downcase.include?('blallo')
				results = [
					[1, 'Blallo', "&#128153;&#128155;&#128153;&#128155;", "Set di cuori blallo"]
				].map do |arr|
					Telegram::Bot::Types::InlineQueryResultArticle.new(
					id: arr[0],
					title: arr[1],
					description: arr[3],
					thumb_url: "http://pix.iemoji.com/images/emoji/apple/ios-9/256/blue-heart.png",
					thumb_width: 10,
					thumb_height: 10,
					input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(message_text: arr[2], parse_mode: "HTML")
					)
				end

			#-------------------------------------------
			#RICERCA CUORI
			elsif message.to_s.downcase.include?('cuori')
				results = [
					[2, 'Cuori', "&#10084;&#10084;&#10084;&#10084;", "Set di cuori rossi"]
			].map do |arr|
					Telegram::Bot::Types::InlineQueryResultArticle.new(
					id: arr[0],
					title: arr[1],
					description: arr[3],
					thumb_url: "http://pix.iemoji.com/images/emoji/apple/ios-9/256/heavy-black-heart.png",
					thumb_width: 10,
					thumb_height: 10,
					input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(message_text: arr[2], parse_mode: "HTML")
					)
				end

			#-------------------------------------------
			#RICERCA MIXED
			elsif message.to_s.downcase.include?('mixed')
				results = [
					[3, 'Mixed Blallo', '&#10084;&#128153;&#128155;&#128155;&#128153;&#10084;', "Set di cuori misto"]
				].map do |arr|
					Telegram::Bot::Types::InlineQueryResultArticle.new(
					id: arr[0],
					title: arr[1],
					description: arr[3],
					thumb_url: "http://pix.iemoji.com/images/emoji/apple/ios-9/256/heart-with-ribbon.png",
					thumb_width: 10,
					thumb_height: 10,
					input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(message_text: arr[2], parse_mode: "HTML")
					)
				end

			#-------------------------------------------
			#RICERCA LOVE
			elsif message.to_s.downcase.include?('love')
				string = message.to_s.split(" ")

				results = [
					[4, 'Love you ♥', "Ti voglio bene #{string[1]}", 'Scrivi a chi vuoi bene']
				].map do |arr|
					Telegram::Bot::Types::InlineQueryResultArticle.new(
					id: arr[0],
					title: arr[1],
					description: arr[3],
					thumb_url: "http://weknowyourdreams.com/images/happy/happy-01.jpg",
					thumb_width: 5,
					thumb_height: 5,
					input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(message_text: arr[2], parse_mode: "HTML")
					)
				end

			#-------------------------------------------
			#ALTRO
			else
				results = [
					[1, 'Blallo', "&#128153;&#128155;&#128153;&#128155;", "Set di cuori blallo","http://pix.iemoji.com/images/emoji/apple/ios-9/256/blue-heart.png",10,10],
					[2, 'Cuori', "&#10084;&#10084;&#10084;&#10084;", "Set di cuori rossi","http://pix.iemoji.com/images/emoji/apple/ios-9/256/heavy-black-heart.png",10,10],
					[3, 'Mixed Blallo', '&#10084;&#128153;&#128155;&#128155;&#128153;&#10084;', "Set di cuori misto","http://pix.iemoji.com/images/emoji/apple/ios-9/256/heart-with-ribbon.png",10,10],
					[4, 'Love you ♥', "Ti voglio bene #{message}", 'Scrivi a chi vuoi bene',"http://weknowyourdreams.com/images/happy/happy-01.jpg",5,5]
				].map do |arr|
					Telegram::Bot::Types::InlineQueryResultArticle.new(
					id: arr[0],
					title: arr[1],
					description: arr[3],
					thumb_url: arr[4],
					thumb_width: arr[5],
					thumb_height: arr[6],
					input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(message_text: arr[2], parse_mode: "HTML")
					)
				end
			end

			#risposta alla query
			bot.api.answer_inline_query(inline_query_id: message.id, results: results)

		when Telegram::Bot::Types::Message
			if message.to_s.downcase.include?("/help")
				bot.api.send_message(chat_id: message.chat.id, text: "BlalloBot: un po di funzioni balle :D\nblallo: invia cuori blalli\ncuori: invia cuori rossi\nmixed blallo: invia cuori misti blalli e rossi\nlove: scrivi a chi vuoi bene e poi premi su love ! ♥\n\nConsigli:\nProva a digitare il nome dalla funzione e vedrai che verrà ricercata.\nSe stai cercando la funzione LOVE scrivi dopo la parola love la il nome della persona che comparirà nel messaggio.")
			else
				bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}! Type /help for some help !")
			end
		end
	end
end
