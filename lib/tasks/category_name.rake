##desc "Fetch product prices"
#task :fetch_name => :environment do
#
#  require 'nokogiri'
#  require 'open-uri'
#
#  Category.find_by_name(nil).each do |category|
#    url = "http://www.ebay.in/cat/mobiles"
#    doc = Nokogiri::HTML(open(url))
#    name = doc.at_css("#product2Tab6 a , #product2Tab3 a , #product2Tab5 a , #product2Tab4 a , #product2Tab2 a")
#    category.create(:name => name)
#  end
#end
