
task :generate do
	puts 'Generating project'
	paths = [
		"Common/Resources",
		"Core/Resources",
		"MobileApp/Resources",
		"TestKit/Resources"
	]
	paths.each { |path| puts 'Creating directory #{path}' }
	paths.each { |path| createDirectoryIfNotExists(path) }
	
	if isInstalled("tuist")
		puts 'Tuist installed. Running `tuist generate`'
		sh 'tuist generate'
	else 
		puts 'Tuist is not installed! Install it and ther run again `rake generate`'
	end
	
end

def createDirectoryIfNotExists(path)
	Dir.mkdir(path) unless Dir.exist?(path)
end

def isInstalled(program)
	ENV['PATH'].split(File::PATH_SEPARATOR).any? do |directory| 
		File.executable?(File.join(directory, program.to_s))
	end
end
