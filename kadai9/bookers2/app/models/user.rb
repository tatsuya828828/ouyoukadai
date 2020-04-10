class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships


    def following?(other_user)
      following_relationships.find_by(following_id: other_user.id)
    end

    def follow!(other_user)
      following_relationships.create!(following_id: other_user.id)
    end

    def unfollow!(other_user)
      following_relationships.find_by(following_id: other_user.id).destroy
    end

  def self.search(search,word)
    if search == "perfect_match"
      @user = User.where(name: "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
      elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
      elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
      else
      @user = User.all
     end
  end

  attachment :profile_image


  include JpPrefecture
  jp_prefecture :prefecture_code
  #prefecture_codeはuserが持っているカラム

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end



  def address
    "%s %s"%([self.city,self.street])
  end

  geocoded_by :address
  after_validation :geocode


  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :name, presence: true
  validates :introduction, length: {maximum: 50}
end