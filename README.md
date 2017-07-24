# Ford-Chef
This project contains two files that are being used: do_tasks.rb and tasks.csv

## do_tasks.rb
This file is the recipe that executes the tasks described in tasks.csv. In most cases this file won't need editing.

## tasks.csv
You update this file to tell the `do_tasks.rb` what to do. Every row in the csv is a task. The first column is the task name and all the other columns are information needed for the task. Table below shows what data to provide for each task. Information in the table below is also available in the `tasks_instruction.csv` file. `tasks.csv` file provided is a sample file.


<table>
					<tr>
						<td>ADD_ILO_CLIENT</td>
						<td>IP</td>
						<td>USERNAME</td>
						<td>PASSWORD</td>
						<td>SSL ENABLED?</td>
					</tr>
					<tr>
						<td>ADD_ONEVIEW_CLIENT</td>
						<td>URL</td>
						<td>USERNAME</td>
						<td>PASSWORD</td>
						<td>SSL ENABLED?</td>
					</tr>
					<tr>
						<td>ADD_USER</td>
						<td>USERNAME</td>
						<td>PASSWORD</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>DELETE_USER</td>
						<td>USERNAME</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>ADD_SERVER_PROFILE_FROM_TEMPLATE</td>
						<td>PROFILE NAME</td>
						<td>DATA (With quotation marks)</td>
						<td>TEMPLATE NAME</td>
						<td>HARDWARE</td>
					</tr>
			</table>
      
### Notes
1. Only one ADD_ONEVIEW_CLIENT can be used
2. DATA for ADD_SERVER_PROFILE_FROM_TEMPLATE must be a string with quotation marks.
      
      
## How to use the recipe
This recipe relies on two libraries [oneview-chef](https://github.com/HewlettPackard/oneview-chef) and [ilo-chef](https://github.com/HewlettPackard/ilo-chef). They must be cloned and added as cookbooks to the workstation. After they are added, add the following to `metadata.rb` file in the cookbook where this recipe resides

```
depends 'oneview-chef'
depends 'ilo-chef'
```

## Test Environment
This project was tested using one node with chef workstation and chef client installed. The command used to run the recipe was following
```
chef-client -z -o <cookbook>::do_tasks
```
Note that that `do_tasks` above does not have `.rb`
