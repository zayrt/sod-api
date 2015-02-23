class Vote
	include Mongoid::Document

  field :created_at,      type: DateTime, default: DateTime.now
  field :updated_at,      type: DateTime
  field :name,						type: String
  field :user_id, 				type: BSON::ObjectId
  field :answer_id, 			type: BSON::ObjectId
  field :question_id,     type: BSON::ObjectId
    
  belongs_to :answer
  belongs_to :user
end
