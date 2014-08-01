output_file = File.open('./build/build_status.html', 'w')
output_file << "<h3>Beginning the Build at #{time.now}</h3>"
system('middleman build')
output_file << "<h3>Completed the Generator Script at #{time.now}</h3>"
output_file.close
