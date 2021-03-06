class Vote
	include Mongoid::Document

  field :created_at,      type: DateTime, default: DateTime.now
  field :updated_at,      type: DateTime
  field :user_id, 				type: BSON::ObjectId
  field :question_id,     type: BSON::ObjectId
  field :answers_ids,     type: Array
    
  belongs_to :question
  belongs_to :user
end
