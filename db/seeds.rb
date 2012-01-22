subtasks = %w{ announcements puzzles users submissions comments }
subtasks.map!{|s| 'db:seed:' + s }

subtasks.each do |subtask|
  Rake::Task[subtask].invoke
end
