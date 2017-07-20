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


post ('/tasks') do
    @new_task = Task.new(params.fetch("description"))
    if @new_task.save()
      redirect("/tasks/".concat(@new_task.id().to_s()))
    else
      erb(:index)
    end
  end

  get('/tasks/:id') do
    @task = Task.find(params.fetch("id").to_i())
    erb(:task)
  end

  # delete('/tasks/:id') do
  #   @task = Task.find(params.fetch("id").to_i()
  #   if @task.destroy()
  #     redirect("/tasks")
  #   else
  #     erb(:task)
  #   end
  # end
