
def compile(filename)
 `cd src; openscad -o ../print/#{filename}.stl #{filename}.scad`
end

task :default => :compile

task :compile do
  Dir.glob('src/*.scad') do |path|
    puts "Compiling #{path}..."
    filename = File.basename(path)[0..-(File.extname(path).length + 1)]
    compile(filename)
  end
end

