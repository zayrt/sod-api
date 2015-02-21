class Question
	include Mongoid::Document

	field :created_at,      type: DateTime, default: DateTime.now
  field :updated_at,      type: DateTime
  field :name,				    type: String
  field :user_id,         type: BSON::ObjectId
  field :type_id,         type: BSON::ObjectId
  field :result_type,     type: String
  field :question,        type: String
	 
  belongs_to              :user
  validates               :name, presence: true, length: { minimum: 3 }
  validates               :type_id, presence: true
  has_many                :answers, dependent: :destroy
  has_one                 :type
end
