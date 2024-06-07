class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :firstName, type: String
  field :lastName, type: String
  field :email, type: String

  validates :firstName, :lastName, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def self.search(search)
    User.any_of({"firstName":  /#{search}/} , {"lastName": /#{search}/}, {"email": /#{search}/})
  end

end
