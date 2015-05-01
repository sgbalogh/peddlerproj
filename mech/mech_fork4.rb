require 'rubygems'
require 'mechanize'
require 'csv'
 
agent = Mechanize.new {|a|
  a.user_agent_alias = 'Mac Safari'
}
 
agent.get('http://jewishpeddler.org/admin/') do |page|
  omeka_page = page.form_with(:action => '/admin/users/login') do |form|
    form.username = '*********'
    form.password = '*********'
  end.submit
 
 
  CSV.foreach('./libimport_2.5_1.175.goog.csv', :headers => true, :header_converters => :symbol) do |line|
 
    # add logic to fill out form
    # click on items
    item_page = agent.click(omeka_page.link_with(:text => %r/Items/))
    # click on add items
    add_item_page = agent.click(item_page.link_with(:text => %r/Add an Item/))
 
    puts "Adding #{line[6]}..."
    puts line[3]
    puts line[1]
 
 
    # Add the item to the form
    add_item_page.form_with(:method => 'POST') do |item_form|
        item_form['public'] = 1
        #item type
        item_form['Elements[121][0][text]'] = line[1]
        #author
        item_form['Elements[94][0][text]'] = line[3]
        item_form['Elements[94][1][text]'] = line[4]
        item_form['Elements[94][2][text]'] = line[5]
        #title dc
        item_form['Elements[50][0][text]'] = line[6]
        #title zotero
        item_form['Elements[218][0][text]'] = line[6]
        #publication title
        item_form['Elements[197][0][text]'] = line[7]
        #isbn
        item_form['Elements[124][0][text]'] = line[8]
        #issn
        item_form['Elements[125][0][text]'] = line[9]
        #doi
        item_form['Elements[123][0][text]'] = line[10]
        #url
        item_form['Elements[220][0][text]'] = line[11]
        #abstractnote
        item_form['Elements[126][0][text]'] = line[12]
        #date
        item_form['Elements[150][0][text]'] = line[13]
        #pages
        item_form['Elements[187][0][text]'] = line[17]
        #issues
        item_form['Elements[168][0][text]'] = line[19]
        #volume
        item_form['Elements[223][0][text]'] = line[20]
        #journalabbreviation
        item_form['Elements[171][0][text]'] = line[22]
        #shorttitle
        item_form['Elements[213][0][text]'] = line[23]
        #publisher
        item_form['Elements[198][0][text]'] = line[28]
        item_form['Elements[198][1][text]'] = line[29]
        #place
        item_form['Elements[189][0][text]'] = line[30]
        item_form['Elements[189][1][text]'] = line[31]
        item_form['Elements[189][2][text]'] = line[32]
        #language
        item_form['Elements[173][0][text]'] = line[33]
        item_form['Elements[173][1][text]'] = line[34]
        item_form['Elements[173][2][text]'] = line[35]
        item_form['Elements[173][3][text]'] = line[36]
        #rights
        item_form['Elements[204][0][text]'] = line[37]
        #archivelocation
        item_form['Elements[130][0][text]'] = line[40]
        #librarycatalog
        item_form['Elements[177][0][text]'] = line[41]
        #callnumber
        item_form['Elements[139][0][text]'] = line[42]
        #extra
        item_form['Elements[160][0][text]'] = line[43]
        #editor
        item_form['Elements[104][0][text]'] = line[49]
        item_form['Elements[104][1][text]'] = line[50]
        item_form['Elements[104][2][text]'] = line[51]
        item_form['Elements[104][3][text]'] = line[52]
        #translator
        item_form['Elements[119][0][text]'] = line[54]
        #contributor
        item_form['Elements[100][0][text]'] = line[55]
        item_form['Elements[100][1][text]'] = line[56]
        #geographicsubject
        item_form['Elements[81][0][text]'] = line[72]
        item_form['Elements[81][1][text]'] = line[73]
        item_form['Elements[81][2][text]'] = line[74]
        item_form['Elements[81][3][text]'] = line[75]
        item_form['Elements[81][4][text]'] = line[76]
        item_form['Elements[81][5][text]'] = line[77]
        item_form['Elements[81][6][text]'] = line[78]
        item_form['Elements[81][7][text]'] = line[79]
        item_form['Elements[81][8][text]'] = line[80]
        item_form['Elements[81][9][text]'] = line[81]
        item_form['Elements[81][10][text]'] = line[82]
        item_form['Elements[81][11][text]'] = line[83]
        item_form['Elements[81][12][text]'] = line[84]
        item_form['Elements[81][13][text]'] = line[85]
        item_form['Elements[81][14][text]'] = line[86]
        item_form['Elements[81][15][text]'] = line[87]
        item_form['Elements[81][16][text]'] = line[88]
        item_form['Elements[81][17][text]'] = line[89]
        item_form['Elements[81][18][text]'] = line[90]
        item_form['Elements[81][19][text]'] = line[91]
        item_form['Elements[81][20][text]'] = line[92]
        item_form['Elements[81][21][text]'] = line[93]
        item_form['Elements[81][22][text]'] = line[94]
        item_form['Elements[81][23][text]'] = line[95]
        item_form['Elements[81][24][text]'] = line[96]
        item_form['Elements[81][25][text]'] = line[97]
        item_form['Elements[81][26][text]'] = line[98]
        item_form['Elements[81][27][text]'] = line[99]
        item_form['Elements[81][28][text]'] = line[100]
        item_form['Elements[81][29][text]'] = line[101]
        item_form['Elements[81][30][text]'] = line[102]
        item_form['Elements[81][31][text]'] = line[103]
        item_form['Elements[81][32][text]'] = line[104]
        item_form['Elements[81][33][text]'] = line[105]
        item_form['Elements[81][34][text]'] = line[106]
        item_form['Elements[81][35][text]'] = line[107]
        #peddler
        item_form['Elements[49][0][text]'] = line[108]
        item_form['Elements[49][1][text]'] = line[109]
        item_form['Elements[49][2][text]'] = line[110]
        item_form['Elements[49][3][text]'] = line[111]
        item_form['Elements[49][4][text]'] = line[112]
        item_form['Elements[49][5][text]'] = line[113]
        item_form['Elements[49][6][text]'] = line[114]
        item_form['Elements[49][7][text]'] = line[115]
        item_form['Elements[49][8][text]'] = line[116]
        item_form['Elements[49][9][text]'] = line[117]
        item_form['Elements[49][10][text]'] = line[118]
        item_form['Elements[49][11][text]'] = line[119]
        item_form['Elements[49][12][text]'] = line[120]
        item_form['Elements[49][13][text]'] = line[121]
        item_form['Elements[49][14][text]'] = line[122]
        item_form['Elements[49][15][text]'] = line[123]
        item_form['Elements[49][16][text]'] = line[124]
        #subjectdatespan
        item_form['Elements[82][0][text]'] = line[125]
        #tags or "subjectterm"
        item_form['tags-to-add'] = "#{line[62]},#{line[63]},#{line[64]},#{line[65]},#{line[66]},#{line[67]},#{line[68]},#{line[69]},#{line[70]},#{line[71]}"
        
        #geom
        item_form['Elements[38][0][geo]'] = line[61]
        item_form['Elements[38][0][zoom]'] = 1
        item_form['Elements[38][0][mapon]'] = 1
        item_form['Elements[38][0][center_lon]'] = "-2896035.6757397"
        item_form['Elements[38][0][center_lat]'] = "3287454.877722"
        #jp_cite
        item_form['Elements[38][0][text]'] = "#{line[59]}" + '////osm
 
        '
    end.submit
  end
end
