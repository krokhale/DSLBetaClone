# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean          default(FALSE)
#

require 'digest'

class User < ActiveRecord::Base

  attr_accessor :password
 
  attr_accessible :email, :name, :password, :password_confirmation
  
 #asscociations with other models
 
  has_many :microposts, :dependent => :destroy
  
  has_many :coursecreations,:dependent=>:destroy #this deletes only the associations but not asscoiated objects
  has_many :courses, :through => :coursecreations
  
  has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :dependent => :destroy,
                                   :class_name => "Relationship"
  has_many :followers, :through => :reverse_relationships
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
  validates :name, :presence=>true, 
                   :length=>{:maximum=>50}
 
  validates  :email, :presence=>true, 
                     :format=>{:with=> email_regex},
                     :uniqueness=>{:case_sensitive=>false}
 
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40} 
                       
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    #compare encrypted_password with encrypted version of submite password
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user= find_by_id(id)
   (user && user.salt == cookie_salt) ? user : nil
  end
  
  # method for getting the courses of the logged in user
  def user_courses
    courses
  end
  
  # method for getting the feeds of the logged in user
  def feed
    Micropost.where("user_id = ?", id)
  end
  
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end
  
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
  
  
end
