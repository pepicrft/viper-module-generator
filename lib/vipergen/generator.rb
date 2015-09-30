module Vipergen
	# Cosntants
	class Generator
		# Constants
		LANGUAGES = ["swift", "objc"]
		REPLACEMENT_KEY = "VIPER"
		AUTHOR_REPLACEMENT_KEY = "AUTHOR"
		YEAR_REPLACEMENT_KEY = "YEAR"
        SWIFT_MODULE_REPLACEMENT_KEY = "SWIFT_MODULE"

		# Main method that generate the VIPER files structure
		def self.generate_viper(template, language, name, path, author, swift_module)
			puts "Generating VIPER-Module"
			puts "Template: #{template}"
			puts "Language: #{language}"
			puts "Name: #{name}"
			puts "Path: #{path}"
			puts "Author: #{author}"
            puts "Module: #{swift_module}"
			path_from = Vipergen::FileManager.path_from(template, language)
			path_to = Vipergen::FileManager.destination_viper_path(path, name)
			Vipergen::FileManager.copy(path_from, path_to)
			files = Vipergen::FileManager.files_in_path(path_to)
			rename_files(files, name, author, swift_module)
		end

		# Rename all the files in the files array
		# - It renames the name of the file 
		# - It renames the content of the file
		def self.rename_files(files, name, author, swift_module)
			files.each do |file|
				raise SyntaxError unless file.include? (Vipergen::Generator::REPLACEMENT_KEY)
				rename_file(file, name, author, swift_module)
			end
		end

		# Rename a given file
		# - It renames the name of the file
		# - It renames the content of the file
		def self.rename_file(file, name, author, swift_module)
			new_path = file.gsub((Vipergen::Generator::REPLACEMENT_KEY), name)
			Vipergen::FileManager.move(file, new_path)
			rename_file_content(new_path, name, author, swift_module)
		end

		# Rename the file content
		# @return: An String with the every VIPER replaced by 'name'
		def self.rename_file_content(filename, name, author, swift_module)
			# Reading content
			file = File.open(filename, "rb")
			content = file.read
			file.close

			# Replacing content
			content = content.gsub((Vipergen::Generator::REPLACEMENT_KEY), name)
			content = content.gsub((Vipergen::Generator::AUTHOR_REPLACEMENT_KEY), author)
            content = content.gsub((Vipergen::Generator::SWIFT_MODULE_REPLACEMENT_KEY), swift_module)
			content = content.gsub((Vipergen::Generator::YEAR_REPLACEMENT_KEY), "#{Time.new.year}")

			# Saving content with replaced string
			File.open(filename, "w+") do |file|
   				file.write(content)
			end
		end
	end
end