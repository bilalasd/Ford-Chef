require 'csv'


ilo_clients = [
#  { host: '10.81.36.2', user: 'user', password: 'HP3advance', ssl_enabled: false },
 # { host: '10.81.36.3', user: 'user', password: 'HP3advance', ssl_enabled: false }
]


oneview_clients = []



isAddingUser = false;
isDeletingUser = false;
count = 0

CSV.foreach('/root/chef-repo/cookbooks/my_ilo/recipes/tasks.csv') do |row|
#	puts row.inspect
	count=count+1
	#puts count

	function = row[0]	
	puts function
	case function

	when "ADD_ILO_CLIENT"
		host = row[1]
		user = row[2]
		password = row[3]
		ssl = row[4].upcase == "TRUE"
		puts "Adding new ilo client to the list with host #{host}"
		ilo_clients << {host: host, user: user, password: password, ssl_enabled: ssl}
		

	


	when "ADD_ONEVIEW_CLIENT"
		url = "https://"
		url << row[1]
#		url = row[1]
		user = row[2]
		password = row[3]
		ssl_enabled = row[4]

		puts "Adding new oneview client to the list with url #{url}"
		oneview_clients = {url:url, user:user, password:password}
		puts "url: #{url} user: #{user} pw: #{password}"
		

			

	when "ADD_USER"
		username = row[1]
                password = row[2]

	        puts "Adding user: #{username} with password: #{password}"
                ilo_user username do
        		ilos ilo_clients
                        password password
                        login_priv true
                end

	

		
	when "DELETE_USER"	
		username = row[1]
#                password = row[2]

        	puts "Deleting user: #{username} with password: #{password}"
                ilo_user username do
                	ilos ilo_clients
                        action :delete
                end




	when "ADD_SERVER_PROFILE_FROM_TEMPLATE"
		server = row[1]
		data = row[2]
		template = row[3]
		hardware = row[4]
		
		
		puts "Adding server from profile"
		puts "Data: #{data}"
		puts "Template: #{template}"
		puts "Hardware: #{hardware}"
		
		
		oneview_server_profile server do
			client oneview_clients
			data(
				description: 'Override Description',
				boot: {
					'order' => [],
					'manageBoot' => false
				}
			)
			server_profile_template template
			server_hardware hardware
		end



	else
		puts "NOT A VALID FUNCTION ON LINE #{count}"
	end

end
