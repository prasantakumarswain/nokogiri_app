class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ebay_category
    if Category.all.empty?
      url ="http://www.ebay.in/cat/mobiles"
      doc = Nokogiri::HTML(open(url))
      name = doc.css("#brand .nav-tabs-m a")
      name.each do |category_name|
        name = Nokogiri::HTML(category_name.content).text
        if Category.find_by_name(name).nil?
          Category.create(:name => name)
        end
      end
    end
  end

  def ebay_product
    if Product.all.empty?
      product_descriptions = Array.new
      Category.all.each do |cat|
        url = "http://www.ebay.in/cat/mobiles/brand/#{cat.name}"
        doc = Nokogiri::HTML(open(url))
        doc.css("#cpProductModuleItems").each do |item|
          name = item.css("#itemsdiv a")
          name.each do |link|
              product_descriptions_url = "http://www.ebay.in#{link['href']}"
              product_description = Nokogiri::HTML(open(product_descriptions_url)).css(".row-fluid~ .row-fluid+ span .span12").text
              product_description = product_description.gsub("\r\n\t\t\t\t\t","")
              product_descriptions.push(product_description)
          end
          image = item.css("#itemsdiv img")
          name =  item.css("#itemsdiv a").text
          name = name.split("...")
          price = item.css("#itemsdiv .discount").text
          price = price.split("Rs. ")
          name.each_with_index do |product_name,i|
            product_image = image[i]['src']
            product_price =  price[i+1].gsub(",","").to_i
            @category = Category.find_by_name(cat.name)
            @category.products.create(:image => product_image, :name => product_name,:price => product_price,:description => product_descriptions[i+1])
          end
        end
      end
    end
  end
end
