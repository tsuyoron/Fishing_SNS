class Catch < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :tags, dependent: :destroy
  belongs_to :user

  has_one_attached :catch_image

  validates :title,presence:true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 釣果画像処理
  def get_catch_image(width, height)
    unless catch_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      catch_image.attach(io:File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    catch_image.variant(resize_to_limit: [width, height]).processed
  end
end
