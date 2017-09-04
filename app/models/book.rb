class Book < ActiveRecord::Base
  belongs_to :course

  def self.valid_params?(params)
  return !params[:title].empty? && !params[:author].empty?
end


end
