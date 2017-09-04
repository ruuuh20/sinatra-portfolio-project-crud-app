class Course < ActiveRecord::Base
  belongs_to :user
  has_many :books

  def self.valid_params?(params)
    return !params[:name].empty? && !params[:semester].empty?
  end


end
