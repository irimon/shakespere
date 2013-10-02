require 'nokogiri'
require 'open-uri'


class RolesController < ApplicationController
   helper_method :sort_column, :sort_direction


 def new
	
  end

  def create
		scene_count = 0
		path = Rails.public_path + "/julius_caesar.xml"
		doc = Nokogiri::XML(open(path))
		doc.xpath("//PERSONA").each do |persona| 
		
			 name = persona.text 
			 if  Role.find_by_name(name) == nil
				Role.create(name: name)
			end
				
		 end
		
		
		doc.xpath("//SCENE").each do |scene| 
			 scene_count = scene_count+1
			  # for role in Role.all
				  # role[:in_scene] = FALSE
			  # end
			names_in_scene = Hash.new
			
			
			scene.xpath('SPEECH').each do |speach| 
				 line_count = 0;
				 
				speach.xpath('SPEAKER').each do |sp| 
					@speaker = sp.text
				
				 
					 if (@speaker != "All") 
						
						 speach.xpath('LINE').each do |line| 
							 line_count = line_count+1
						 end
						
						 role =  Role.find_by_name(@speaker)
						 role ||= Role.find(:first, :conditions => ["name LIKE ?", "%#{@speaker}"])
						
						  if (names_in_scene.has_key?(@speaker) == FALSE)  
							names_in_scene[@speaker] = 1
						  end
						 
						
						 if role.longest_speach < line_count
							role.longest_speach = line_count
						 end
						 role.number_of_lines = role.number_of_lines + line_count
						  

						  # if (role[:in_scene] == FALSE) 
							   # role[:in_scene] = TRUE
							   # role.number_of_scenes = role.number_of_scenes + 1
						  # end
						 role.save
					 end
				end
			 end
			 
			 puts names_in_scene
			 names_in_scene.each { |key,value| 
				
					role = Role.find_by_name(key)
					role ||= Role.find(:first, :conditions => ["name LIKE ?", "%#{key}"])
					role.number_of_scenes = role.number_of_scenes + 1
					role.save
			
			 }
			names_in_scene.clear
			
		 end
		 
		 for role in Role.all
			 role.scenes_percent = role.number_of_scenes.to_f/scene_count
			 role.save
		 end	
			
		render 'new'
  end
  
  
  def show
		@roles = Role.order(sort_column + ' ' + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end
  
  
  private
  
  def sort_column
    Role.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
