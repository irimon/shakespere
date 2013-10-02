class Role < ActiveRecord::Base
  attr_accessible :longest_speach, :name, :number_of_lines, :number_of_scenes, :scenes_percent

 before_save :default_values
  
   
  def default_values
	if (self.longest_speach == nil)
		self.longest_speach  = 0
		self.number_of_lines = 0
		self.number_of_scenes = 0
		self.scenes_percent = 0
	end
  end

  
  
end
