class Item < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :categories

    has_attached_file :item_img, :styles => { :item_index => "75x75", :item_show => "325x475>"}, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :item_img, content_type: /\Aimage\/.*\z/

    validates :name, presence: true
    validates :description, length: { in: 1..2000 }
    validates :user_id, presence: true
end
