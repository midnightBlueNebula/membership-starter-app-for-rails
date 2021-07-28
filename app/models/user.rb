class User < ApplicationRecord
    attr_accessor :remember_token

    has_secure_password

    mount_uploader :picture, PictureUploader

    before_create { email.downcase! }


    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 300 }
    validates :password, presence: true, length: { minimum:6, maximum: 300 }
    validate :picture_size
    
    
    class << self
    
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost                                                          
            BCrypt::Password.create(string, cost: cost)
        end

        def new_token
            SecureRandom.urlsafe_base64
        end

    end

    def remember 
        @remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    private

    def picture_size
        if picture.size > 20.megabytes
          errors.add(:picture, "size should be less than 20 megabytes.")
        end
    end
end
