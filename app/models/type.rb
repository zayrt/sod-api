class Type
	include Mongoid::Document
	
	field :created_at,      type: DateTime, default: DateTime.now
  field :updated_at,      type: DateTime
  field :name,						type: String
  field :nb_result_max,		type: Integer, default: 0

  validates 							:name, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }
end