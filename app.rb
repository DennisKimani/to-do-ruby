require("bundler/setup")
  Bundler.require(:default)
  also_reload("lib/**/*.rb")

  Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get('/') do
  @tasks = Task.all
  erb(:index)
end

get('/tasks/new') do
  erb(:new_task)
end

get('/tasks/:id/edit') do
  @task = Task.find(params.fetch('id').to_i)
  erb(:task_edit)
end

patch('/tasks/:id') do
  description = params.fetch('description')
  @task = Task.find(params.fetch('id').to_i)
  @task.update(description: description)
  @tasks = Task.all
  erb(:index)
end

post('/tasks') do
  description = params.fetch("description")
  @task = Task.new({:description => description, :done => false})
  if @task.save()
    erb(:success)
  else
    erb(:errors)
  end
end
