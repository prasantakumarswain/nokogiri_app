class Category < ActiveRecord::Base
  has_many :products , :dependent => :destroy

  #def self.search(search)
  #  where("name like ?", "%#{search}%")
  #end
end

