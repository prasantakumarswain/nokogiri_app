class Product < ActiveRecord::Base
  belongs_to :category
  def self.search(category, search)
    if category.blank?
      where("name like ?", "%#{search}%")
    else
      where("category_id = ? and name like ?", category, "%#{search}%")
    end
  end
end