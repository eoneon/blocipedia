class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis
  has_many :collaborators

  after_initialize :init

  enum role: [:standard, :premium, :admin]

  def init
    self.role  ||= :standard  
  end

  def users_name
    username
  end
end
