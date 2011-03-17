class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_many :announcements, :foreign_key => "author_id", :dependent => :destroy
  has_many :submissions, :dependent => :destroy
  
  attr_protected :admin
  
  def self.create_from_hash!(hash)
    create(:name     => hash['user_info']['name'], 
           :nickname => hash['user_info']['nickname'])
  end

  def name
    read_attribute(:name) || nickname || "Anonymous ##{id}"
  end

  def refresh_names(hash)
    return if nickname

    update_attributes(:name      => hash['user_info']['name'],
                      :nickname  => hash['user_info']['nickname'])
  end
  
  def solution_for(puzzle)
    return if puzzle.nil?
    submissions.where(:puzzle_id => puzzle.id, :correct => true).first
  end
end
