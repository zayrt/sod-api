class Question
	include Mongoid::Document

	field :created_at,      type: DateTime, default: DateTime.now
  field :updated_at,      type: DateTime
  field :name,				    type: String
  field :user_id,         type: BSON::ObjectId
  field :type_id,         type: BSON::ObjectId
	 
  belongs_to              :user
  has_many                :answers, dependent: :destroy
  has_many                :votes, dependent: :destroy
  has_one                 :type

  validates               :name, presence: true, length: { minimum: 3 }
  validates               :type_id, presence: true
end
