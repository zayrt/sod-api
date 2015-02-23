class Answer
	include Mongoid::Document
	
	field :created_at,      type: DateTime, default: DateTime.now
  field :updated_at,      type: DateTime
  field :name,						type: String
  field :question_id, 		type: BSON::ObjectId

  belongs_to 							:question
  has_many 								:votes, dependent: :destroy
  
  validates 							:name, presence: true
end
