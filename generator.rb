output_file = File.open('./build/build_status.html', 'w')
output_file.write("<h3>Beginning the Build at #{Time.now}</h3>")
output_file.close
system('middleman build')
output_file = File.open('./build/build_status.html', 'w+')
output_file.write("<h3>Completed the Generator Script at #{Time.now}</h3>")
output_file.close
