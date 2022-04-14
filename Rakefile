namespace :run do
  task :client do 
  	system("ruby client.rb")

  end

  task :rest_api do
  	system("curl --cacert cert.pem https://localhost:2000")
  end
end