

class User < ActiveRecord::Base
  include Paperclip::Glue

  has_attached_file :avatar, styles: { large: "600X600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/ 
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end

