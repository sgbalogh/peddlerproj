require 'json'


arraynames = ['Book','BookSection','Webpage','Thesis','JournalArticle','Document','NewspaperArticle']

#arraynames = ['AntiSemiticRhetoric','Bartering','BusinessPractices','ContextualResource','CulturalExchange','Family','LiteraryArtisticDepiction','NonPeddlingBackground','PeddlingBackground','ReligiousPractices','RestrictionsCommerce','Routes','Sponsor','SubsequentCommercialCareers','SubsequentNonCommercial','Transportation','VictimsOfCrime','Wares']
arraylen = arraynames.length

r = 0
while r < arraylen
curname = arraynames[r]
	string = File.read('./' + curname + '.json')
	parsed = JSON.parse(string)

	total = parsed["total_results"]

	i = 1
	int = parsed["items"][0]["id"]
	string = int.to_s
	while i < total
		want = parsed["items"][i]["id"]
		wantstring = want.to_s
		string += "," + wantstring
		i += 1
	end
	puts "UPDATE omek_neatline_records SET tags=CONCAT(tags,'," + curname + "') WHERE item_id IN(" + string + ');'
	r += 1
end

